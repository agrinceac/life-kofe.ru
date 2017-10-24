<?php
namespace controllers\front\service;
use modules\articles\lib\Article;
use modules\articles\lib\Articles;

class LifeKofeServiceFrontController extends \controllers\base\Controller
{
	use	\core\traits\controllers\ControllersHandler,
		\core\traits\controllers\Templates;

    private $actionsRedirects = array(
        'sitemap.xml'   => 'sitemapxml',
        'robots.txt'    => 'robots',
        'YML.xml'       => 'yml'
    );

	public function __call($actionName, $arguments)
	{
		if (method_exists($this, $actionName))
			return call_user_func_array(array($this, $actionName), $arguments);
		elseif (isset($this->actionsRedirects[$actionName])){
			$action = $this->actionsRedirects[$actionName];
			return $this->$action();
		} else {
			$defaultControllerName = \core\Configurator::getInstance()->controllers->defaultFrontController;
			return $this->getController($defaultControllerName)->$actionName();
		}
	}

	public function redirect404()
	{
		header("HTTP/1.0 404 Not Found");
		$this->includeTemplate('404');
		die();
	}

	public function accessDenied($right)
	{
		$this->redirect404();
	}

	public function forbidden()
	{
		$this->redirect404();
	}

	protected function sitemapxml()
	{
		if ($this->getSERVER()['REQUEST_URI'] != '/sitemap.xml')
			return $this->redirect404();

//        $cacheKey = md5($this->getCurrentDomainAlias().'-'.__METHOD__.serialize($this->getREQUEST()->getArray()));
//		$contents = \core\cache\Cacher::getInstance()->get($cacheKey);
		$sitemap = new \core\seo\sitemap\Sitemap();
//
//		if ($contents === false){

//			mail('sashagrinceac@yahoo.com',
//				'generating sitemap in VnMebelServiceFrontController',
//				'The sitemap was generated in VnMebelServiceFrontController directly, without cache - '.date('Y/m/d H:i:s')
//			);

			$articles = new \modules\articles\lib\Articles();
			$query = 'AND `statusId` = ?d';

			$articles->setSubquery($query, \modules\articles\lib\ArticleConfig::ACTIVE_STATUS_ID);

			$goods = new \modules\catalog\catalog\lib\Catalog();
			$goods->setSubquery(' AND `statusId` NOT IN (?d, ?d)', \modules\catalog\catalog\lib\CatalogItemConfig::BLOCKED_STATUS_ID, \modules\catalog\catalog\lib\CatalogItemConfig::REMOVED_STATUS_ID);
			$goodCategories = $goods->getCategories()->setSubquery(' AND `statusId` = ?d', 1);

            $goods->setLimit(2000);

			$sitemap->addObjects($articles)
					->addObjects($goods)
					->addObjects($goodCategories);

			$contents = $sitemap->getSitemapCode();
//			\core\cache\Cacher::getInstance()->set($contents, $cacheKey);
//		}
		$sitemap->printXMLHeaders();
		echo $contents;
	}

	protected function robots()
	{
		if ($this->getSERVER()['REQUEST_URI'] != '/robots.txt')
			return $this->redirect404();

		$filePath = $this->isProductionDomain()
						? DIR.'/robots/'.$this->getDevelopersDomainAlias().'Robots.txt'
						: DIR.'/robots/DeveloperRobots.txt';

		if (file_exists($filePath)){
			header('Content-type: text/plain');
			include($filePath);
		} else
			$this->redirect404();
	}

    protected function yml()
    {
        if ($this->getSERVER()['REQUEST_URI'] != '/YML.xml')
            return $this->redirect404();
        $yml = new \core\seo\yml\Yml();

        $yml->setShopName('Life kofe')
            ->setCompanyName('Life kofe')

            ->addCategories($this->getController('Catalog')->getActiveCategories());

        foreach($this->getController('Catalog')->getActiveObjects(1250) as $good)
            $yml->addOffer($this->getYmlOfferFromGood($good));

        $yml->printYml();
    }

    protected function getYmlOfferFromGood($good)
    {
        $pictures = array();
        foreach($good->getImagesByCategoryAndStatus(2, 1) as $image)
            $pictures[] = $image->getImage();

        $data = array(
            'id'		=> $good->id,
            'available' => 'true',
            'url'		=> $good->getPath(),
            'price'		=> $good->getShowPrice(),
            'currencyId'=> 'RUR',
            'categoryId'=> $good->categoryId,
            'pictures' => $pictures,
            'name'		=> $good->getName(),
            'description'=> strip_tags($good->text),
            'manufacturerWarranty' => true,
            'delivery' => true
        );
        return new \core\seo\yml\YmlOffer($data);
    }
}
