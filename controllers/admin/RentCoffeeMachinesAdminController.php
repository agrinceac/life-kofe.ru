<?php
namespace controllers\admin;
use modules\articles\lib\Article;
use modules\articles\lib\ArticlesObject;

class RentCoffeeMachinesAdminController extends \controllers\base\Controller
{
    use \core\traits\controllers\Templates;

    protected $permissibleActions = array(
        'getCoffeeMachinesTable',
        'ajaxGetCoffeeMachinesTable',
        'ajaxAddCoffeeMachine',
        'ajaxDeleteCoffeeMachine'
    );

    public function __construct()
    {
        parent::__construct();
        $this->_config = new \modules\catalog\rentCoffeeMachines\lib\RentCoffeeMachineConfig();
        $this->objectClass = $this->_config->getObjectClass();
        $this->objectsClass = $this->_config->getObjectsClass();
        $this->objectClassName = $this->_config->getObjectClassName();
        $this->objectsClassName = $this->_config->getObjectsClassName();
    }

    protected function getCoffeeMachinesTable($articleId)
    {
        $article = new Article($articleId);

        $this->setContent('article', $article)
            ->setContent('coffeeMachines', $article->getCoffeeMachines())
            ->includeTemplate('coffeeMachinesTable');
    }

    protected function ajaxGetCoffeeMachinesTable()
    {
        echo $this->getCoffeeMachinesTable($this->getPost()->rentPageId);
    }

    protected function ajaxAddCoffeeMachine()
    {
        $objectId =  $this->setObject($this->_config->getObjectsClass())->modelObject->add($this->getPOST(), $this->modelObject->getConfig()->getObjectFields());
        $this->ajax($objectId, 'ajax', true);
    }

    protected function ajaxDeleteCoffeeMachine()
    {
        $additionalGood = $this->getObject($this->objectClass, $this->getPost()->catalogItemId);
        $this->ajaxResponse($additionalGood->remove());
    }
}