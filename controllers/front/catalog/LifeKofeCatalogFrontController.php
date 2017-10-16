<?php
namespace controllers\front\catalog;
use modules\articles\lib\Articles;
use modules\articles\lib\ArticlesObject;
use modules\catalog\categories\CatalogCategoryConfig;
use modules\fabricators\lib\Fabricators;

class LifeKofeCatalogFrontController extends \controllers\front\catalog\CatalogFrontController
{
	const QUANTITY_ITEMS_ON_SUBPAGE = 8;
	const NO_PAGINATION_QUANTITY_ITEMS = 1000000;
    const ITEMS_IN_SELECT = 10;

	protected $permissibleActions = array(
		'search',
        'getFilter',
        'getFabricators',
        'spare_parts',
        'kofe',
        'rashodnye_materialy',
        'getMainCategories',
        'getItemsInSelect',
        'ajaxGetKofeMashinesListBlock',
        'ajaxGetHowMuchKofeBlock',
        'ajaxGetFabricatorsBlock',

        'getActiveCategories',
        'getActiveObjects'
	);

	protected function pageDetect()
	{
		$alias = $this->getLastElementFromRequest();

		$good = $this->getGoodByAlias($alias);
		if ($good && !$good->isHidden()){
			if ($this->checkObjectPath($good)){
				if($this->isDownloadFileRequested())
					return $this->downloadFile($good);
				return $this->viewGood($good);
			}
		}

		$category = $this->getCatalogObject()->getCategories()->getObjectByAlias($alias);
		if ($category)
		    if(!$category->isHidden())
                if ($this->checkObjectPath($category))
                    return $this->viewCategory($category);

        $fabricator = (new Fabricators())->getObjectByAlias($alias);
        if ($fabricator)
            if ($this->checkObjectPath($fabricator))
                return $this->viewFabricator($fabricator);

		$this->sendRequestToArticlesController();
	}

	private function viewCategory($category)
	{
//        $cacheKey = md5($this->getCurrentDomainAlias().'-'.__METHOD__.serialize($this->getREQUEST()->getArray()));
//		$contents = \core\cache\Cacher::getInstance()->get($cacheKey);
//		if ($contents === false){
//			ob_start();
            $fabricator = (new Fabricators())->getObjectByAlias($this->getUriElement(2));
			$this->setSparePartsLevel()
                ->setLevel($this->getFabricatorPreString().$fabricator->getName(), $fabricator->getPath())
				 ->setLevel($category->getName());

            $objects = $this->getObjectsByCategory($category, $fabricator->id)
                            ->setOrderBy('priority ASC')
                            ->setQuantityItemsOnSubpageList([self::QUANTITY_ITEMS_ON_SUBPAGE])
                            ->setPager(self::QUANTITY_ITEMS_ON_SUBPAGE);

			$this->setSpecialMeta($category, $this->getElementFromTheEndOfRequest(2))
                ->setContent('h1', $category->getH1())
                ->setContent('categories', $category->getChildren([self::ACTIVE_CATEGORY_STATUS]))
                ->setContent('objects', $objects)
                ->setContent('itemsInSelect', $this->getItemsInSelect())
                ->setContent('pager', $objects->getPager())
                ->includeTemplate('catalog/catalogList');

//			$contents = ob_get_contents();
//			ob_end_clean();
//			\core\cache\Cacher::getInstance()->set($contents, $cacheKey);
//		}
//		echo $contents;
	}

	private function viewFabricator($fabricator)
    {
        $articles = new \modules\articles\lib\Articles();
        $articleForMeta = $articles->getObjectByAlias($this->_config->getSparePartsCategory()->alias.'_'.$fabricator->getAlias());

        if ($articleForMeta)
            $this->setMetaFromObject($articleForMeta);

        $this->setSparePartsLevel()
            ->setLevel($this->getFabricatorPreString().$fabricator->getName())
            ->setContent('h1', $articleForMeta ? $articleForMeta->h1 : $fabricator->getName())
            ->setContent('categories', $this->getCategoriesByFabricatorId($fabricator->id))
            ->includeTemplate('catalog/catalogList');
    }

    private function setSparePartsLevel()
    {
        return $this->setLevel(
            $this->_config->getSparePartsCategory()->name,
            $this->_config->getSparePartsCategory()->getNativePath()
        );
    }

	protected function getItemsInSelect()
    {
        return self::ITEMS_IN_SELECT;
    }

	protected function getFilter()
    {
        $this->includeTemplate('catalog/filter');
    }

    protected function getFabricators()
    {
        return (new Fabricators())->getActiveFabricators();
    }

    protected function spare_parts()
    {
        if($this->getLastElementFromRequest() != __FUNCTION__)
            if($this->getLastElementFromRequest() != $this->_config->getSparePartsCategory())
                return $this->pageDetect();

        $category = $this->_config->getSparePartsCategory();
        $this->setMetaFromObject($category)
            ->setContent('category', $category)
            ->setContent('subCategories', $this->getActiveCategories()
                                                ->setSubquery(' AND `parentId` != ?d', 0))
            ->includeTemplate('catalog/'.$category->alias);
    }

	protected function getMainCategories()
	{
		return $this->getCatalogObject()->getMainCategories(self::ACTIVE_CATEGORY_STATUS);
	}

	protected function viewGood($good)
	{
//        $cacheKey = md5($this->getCurrentDomainAlias().'-'.__METHOD__.serialize($this->getREQUEST()->getArray()));
//		$contents = \core\cache\Cacher::getInstance()->get($cacheKey);
//		if ($contents === false){
//			ob_start();
            $this->setSparePartsLevel()
                ->setLevel($this->getFabricatorPreString().$good->getFabricator()->getName(), $good->getFabricator()->getPath())
                ->setLevel($good->getCategory()->name, $good->getCategory()->getPath())
                ->setLevel($good->getName());

			$this->setMetaFromObject($good)
				->setContent('object', $good)
                ->setContent('itemsInSelect', $this->getItemsInSelect())
                ->setContent('breadcrumbsShow', true)
				->includeTemplate('catalog/catalogObject');

//			$contents = ob_get_contents();
//			ob_end_clean();
//			\core\cache\Cacher::getInstance()->set($contents, $cacheKey);
//		}
//		echo $contents;
	}

	private function getFabricatorPreString()
    {
        return 'Запчасти для кофемашин ';
    }

	protected function search()
	{
		$this->setLevel('Поиск');

        $objects = $this->getActiveObjects();
        $objects->setSubquery( 'AND `categoryId` NOT IN(?s)', implode(',', $this->_config->getHiddenCategoriesId()) )
                ->setSubquery(
                    'AND `categoryId` NOT IN (SELECT `id` FROM `tbl_catalog_catalog_categories` WHERE `parentId` IN (?s))',
                    implode(',', $this->_config->getHiddenCategoriesId())
                );

        if($this->getGet()['spareName'])
            $objects->setSubquery(
                'AND `id` IN (
                    SELECT `id`  FROM `'.\modules\catalog\CatalogFactory::getInstance()->mainTable().
                    '` WHERE (LOWER(`name`) LIKE \'%?s%\' OR LOWER(`articul`) LIKE \'%?s%\') 
                )'
                , strtolower(\core\utils\DataAdapt::textValid($this->getGet()['spareName']))
                , strtolower(\core\utils\DataAdapt::textValid($this->getGet()['spareName']))
            );

        if($this->getGet()['category'])
            $objects->setFiltersByCategoryAlias(\core\utils\DataAdapt::textValid($this->getGet()['category']));

        if($this->getGet()['fabricator'])
            $objects->setSubquery(
                'AND `fabricatorId` = ?d',
                \core\utils\DataAdapt::textValid((new Fabricators())->getIdByAlias($this->getGet()['fabricator']))
            );

        $objects->setOrderBy('priority ASC')
                ->setQuantityItemsOnSubpageList([self::QUANTITY_ITEMS_ON_SUBPAGE])
                ->setPager(self::QUANTITY_ITEMS_ON_SUBPAGE);

        $this->setContent('isSearch', true)
            ->setContent('h1', 'Результаты поиска')
            ->setContent('objects', $objects)
            ->setContent('itemsInSelect', $this->getItemsInSelect())
            ->setContent('pager', $objects->getPager())
            ->includeTemplate('catalog/catalogList');
	}

	protected function kofe()
    {
        $config = $this->_config;
        $category = $this->getCatalogObject()->getCategories()->getObjectById($config::KOFE_CATEGORY_ID);
        $this->setLevel($category->getName(), $category->getNativePath());

        $objects = $this->getObjectsByCategory($category)
            ->setOrderBy('priority ASC')
            ->setQuantityItemsOnSubpageList([self::QUANTITY_ITEMS_ON_SUBPAGE])
            ->setPager(self::QUANTITY_ITEMS_ON_SUBPAGE);

        $this->setMetaFromObject($category)
            ->setContent('h1', $category->getH1())
            ->setContent('objects', $objects)
            ->setContent('itemsInSelect', $this->getItemsInSelect())
            ->setContent('pager', $objects->getPager())
            ->includeTemplate('catalog/catalogList');
    }

    protected function rashodnye_materialy()
    {
        $config = $this->_config;
        $category = $this->getCatalogObject()->getCategories()->getObjectById($config::CONSUMABLES_CATEGORY_ID);
        $this->setLevel($category->getName(), $category->getNativePath());

        $objects = $this->getObjectsByCategory($category)
            ->setOrderBy('priority ASC')
            ->setQuantityItemsOnSubpageList([self::QUANTITY_ITEMS_ON_SUBPAGE])
            ->setPager(self::QUANTITY_ITEMS_ON_SUBPAGE);

        $this->setMetaFromObject($category)
            ->setContent('h1', $category->getH1())
            ->setContent('objects', $objects)
            ->setContent('itemsInSelect', $this->getItemsInSelect())
            ->setContent('pager', $objects->getPager())
            ->includeTemplate('catalog/catalogList');
    }

	protected function ajaxGetKofeMashinesListBlock()
    {
        if (isset($this->getPOST()['page']) && !empty($this->getPOST()['page']))
            $forPage = $this->getPOST()['page'];
        else
            $forPage = 'rent_for_office';

        ob_start();
        $this->setContent('objects', $this->getCoffeeMashinesForRentPage($forPage))
            ->setContent('page', $forPage)
            ->includeTemplate('catalog/kofeMashinesList');
        $contents = ob_get_contents();
        ob_end_clean();
        $this->ajaxResponse($contents);
    }

    private function getCoffeeMashinesForRentPage($page)
    {
        $article = (new ArticlesObject())->getObjectByAlias($page);
        $config = $this->_config;
        return $this->getObjectsByCategory($this->getCatalogObject()->getCategories()->getObjectById($config::KOFE_MASHINES_CATEGORY_ID))
            ->setSubquery(' AND `id` IN (SELECT `catalogItemId` FROM `' .$this->getObject('\modules\catalog\rentCoffeeMachines\lib\RentCoffeeMachineConfig')->mainTable().'`
            WHERE `rentPageId` =  ?d)', $article->id)
            ->setOrderBy('priority ASC');
    }

    private function getCofeMashines()
    {
        $config = $this->_config;
        return $this->getObjectsByCategory($this->getCatalogObject()->getCategories()->getObjectById($config::KOFE_MASHINES_CATEGORY_ID))
                    ->setOrderBy('priority ASC');
    }

    protected function ajaxGetHowMuchKofeBlock()
    {
        ob_start();
        $objects = $this->getCofeMashines();
        $this->setContent('objects', $objects)
            ->setContent('firstObject', $objects->current())
            ->setContent('kofe', $this->getKofe())
            ->includeTemplate('catalog/howMuchKofeBlock');
        $contents = ob_get_contents();
        ob_end_clean();
        $this->ajaxResponse($contents);
    }

    private function getKofe()
    {
        $config = $this->_config;
        return $this->getObjectsByCategory($this->getCatalogObject()->getCategories()->getObjectById($config::KOFE_CATEGORY_ID))
            ->setOrderBy('priority ASC');
    }

    protected function ajaxGetFabricatorsBlock()
    {
        ob_start();
        $this->setContent('pathMethod', ($this->getPost()['pathMethod']))
            ->setContent('allFabricators', $this->getFabricators())
            ->includeTemplate('catalog/fabricatorsBlock');
        $contents = ob_get_contents();
        ob_end_clean();
        $this->ajaxResponse($contents);
    }

    private function setSpecialMeta($object, $suffix)
    {
        if ($object instanceof \interfaces\IObjectToFrontend) {
            return $this->setTitle($object->getMetaTitle() . ' - ' . ucfirst($suffix))
                ->setDescription($object->getMetaDescription() . ' - ' . ucfirst($suffix))
                ->setKeywords($object->getMetaKeywords() . ',' . $suffix)
                ->setHeaderText($object->getHeaderText());
        }
    }
}