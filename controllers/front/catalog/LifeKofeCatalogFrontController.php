<?php
namespace controllers\front\catalog;
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
                    return $this->viewCategory($alias);

		$this->sendRequestToArticlesController();
	}

	protected function viewCategory($alias)
	{
//        $cacheKey = md5($this->getCurrentDomainAlias().'-'.__METHOD__.serialize($this->getREQUEST()->getArray()));
//		$contents = \core\cache\Cacher::getInstance()->get($cacheKey);
//		if ($contents === false){
//			ob_start();

			$category = $this->getCatalogObject()->getCategories()->getObjectByAlias($alias);
			$this->setLevel($category->getParent()->name, $category->getParent()->getPath())
				 ->setLevel($category->getName());

            $objects = $this->getObjectsByCategory($category)
                            ->setOrderBy('priority ASC')
                            ->setQuantityItemsOnSubpageList([self::QUANTITY_ITEMS_ON_SUBPAGE])
                            ->setPager(self::QUANTITY_ITEMS_ON_SUBPAGE);

			$this->setMetaFromObject($category)
                ->setContent('category', $category)
                ->setContent('subCategories', $category->getChildren([self::ACTIVE_CATEGORY_STATUS]))
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

        $this->setContent('category', $this->_config->getSparePartsCategory())
            ->setContent('subCategories', $this->getActiveCategories()
                                                ->setSubquery(' AND `parentId` != ?d', 0))
            ->includeTemplate('catalog/'.$this->_config->getSparePartsCategoryAlias());
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

			$this->setLevels($good)
				->setMetaFromObject($good)
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

	protected function search()
	{
		$this->setLevel('Поиск');

        $objects = $this->getActiveObjects();
        if($this->getGet()['spareName'])
            $objects->setSubquery(
                'AND `id` IN (SELECT `id`  FROM `'.\modules\catalog\CatalogFactory::getInstance()->mainTable().'` WHERE LOWER(`name`) LIKE \'%?s%\')', strtolower(\core\utils\DataAdapt::textValid($this->getGet()['spareName']))
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

        $this
//            ->setMetaFromObject($category)
            ->setContent('isSearch', true)
            ->setContent('objects', $objects)
            ->setContent('itemsInSelect', $this->getItemsInSelect())
            ->setContent('pager', $objects->getPager())
            ->includeTemplate('catalog/catalogList');
	}

	protected function ajaxGetKofeMashinesListBlock()
    {
        ob_start();
        $this->setContent('objects', $this->getCofeMashines())
            ->includeTemplate('catalog/kofeMashinesList');
        $contents = ob_get_contents();
        ob_end_clean();
        $this->ajaxResponse($contents);
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
        $this->setContent('allFabricators', $this->getFabricators())
            ->includeTemplate('catalog/fabricatorsBlock');
        $contents = ob_get_contents();
        ob_end_clean();
        $this->ajaxResponse($contents);
    }
}