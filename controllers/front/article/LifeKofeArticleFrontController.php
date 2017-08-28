<?php
namespace controllers\front\article;
use controllers\front\CatalogFrontController;
use controllers\front\service\LifeKofeServiceFrontController;
use modules\articles\lib\Article;
use modules\catalog\catalog\lib\CatalogItemConfig;

class LifeKofeArticleFrontController extends \controllers\front\article\ArticleFrontController
{
	public function __call($name, $arguments)
	{
		$this->defaultAction();
	}

	public function defaultAction()
	{
		if (!$this->action && $this->getSERVER()['REQUEST_URI']=='/')
			$this->action = 'viewIndex';
		if(isset ($this->getREQUEST()[0]))
			$this->action = $this->getREQUEST()[0];
		if ($this->actionExists($this->action)) {
			$action = $this->action;
			$this->$action();
		} else
			$this->viewArticle($this->action);
	}

	public function viewIndex()
    {
        $article = $this->getArticlesObject()->getObjectByAlias($this->getConfig()->getIndexAlias());
        $this->setArticleLevel($article)
            ->setContent('article', $article)
            ->setContent('breadcrumbsShow', $article->breadcrumbsShow)
            ->setMetaFromObject($article)
            ->includeTemplate('index');
    }

	public function viewArticle($alias)
	{
//        $cacheKey = md5($this->getCurrentDomainAlias().'-'.__METHOD__.serialize($this->getREQUEST()->getArray()));
//		$contents = \core\cache\Cacher::getInstance()->get($cacheKey);
//		if ($contents === false){

            if($this->checkFabricatorAlias($alias))
                return $this->viewFabricatorPage($alias);
			if ($this->checkArticleAlias($alias)) {
				$articles = new \modules\articles\lib\Articles();
				$article = $articles->getObjectByAlias($alias);
				if ($this->checkDomainAlias($article)){
					if ($article->isValidPath($this->getSERVER()['REQUEST_URI'])){
//						ob_start();
						$this->setArticleLevel($article)
							->setContent('article', $article)
                            ->setContent('breadcrumbsShow', $article->breadcrumbsShow)
							->setMetaFromObject($article)
							->includeTemplate('articles/article');
//						$contents = ob_get_contents();
//						ob_end_clean();
//						\core\cache\Cacher::getInstance()->set($contents, $cacheKey);
					}
				}
				else
					return $this->redirect404();
			}
			else
                return $this->redirect404();
//		}
//		echo $contents;
	}

    private function checkFabricatorAlias($alias)
    {
        $fabricators = new \modules\fabricators\lib\Fabricators();
        return $fabricators->checkAlias($alias);
    }

    private function viewFabricatorPage($alias)
    {
//        $cacheKey = md5($this->getCurrentDomainAlias().'-'.__METHOD__.serialize($this->getREQUEST()->getArray()));
//        $contents = \core\cache\Cacher::getInstance()->get($cacheKey);
//        if ($contents === false){
            $fabricators = new \modules\fabricators\lib\Fabricators();
            $fabricator = $fabricators->getObjectByAlias($alias);
//            if ($fabricator->isValidPath($this->getSERVER()['REQUEST_URI'])){
            if( '/'.$fabricator->alias.'/' == $_SERVER['REQUEST_URI'] ){
//                ob_start();
//                $sparePartsCategory = (new CatalogItemConfig())->getSparePartsCategory();
                $this
//                    ->setLevel($sparePartsCategory->getName(), $sparePartsCategory->getPath())
                    ->setArticleLevel($fabricator)
                    ->setContent('article', $fabricator)
                    ->setContent('breadcrumbsShow', true)
                    ->setMetaFromObject($fabricator)
                    ->includeTemplate('articles/article');
//                $contents = ob_get_contents();
//                ob_end_clean();
//                \core\cache\Cacher::getInstance()->set($contents, $cacheKey);
            }
            else
                return $this->redirect404();
//        }
//        echo $contents;
    }

	public function getTopMenu()
	{
//        $cacheKey = md5($this->getCurrentDomainAlias().'-'.__METHOD__.serialize($this->getREQUEST()->getArray()));
//		$contents = \core\cache\Cacher::getInstance()->get($cacheKey);
//		if ($contents === false){
//			ob_start();
			$this->setContent('topMenu', $this->getTopMenuArticles())
				 ->includeTemplate('topMenu');
//			$contents = ob_get_contents();
//			ob_end_clean();
//			\core\cache\Cacher::getInstance()->set($contents, $cacheKey);
//		}
//		echo $contents;
	}

	public function getTopMenuArticles()
    {
        return $this->setMenuData($this->getConfig()->getTopMenuCategoryId(), $this->getConfig()->getActiveStatusId());
    }
}