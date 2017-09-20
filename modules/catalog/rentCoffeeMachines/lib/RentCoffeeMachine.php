<?php
namespace modules\catalog\rentCoffeeMachines\lib;
class RentCoffeeMachine extends \core\modules\base\ModuleObject
{
    protected $configClass = '\modules\catalog\rentCoffeeMachines\lib\RentCoffeeMachineConfig';
    protected $good;

    function __construct($objectId)
    {
        parent::__construct($objectId, new $this->configClass);
    }

    public function getGood()
    {
        if (!$this->good)
            $this->good = \modules\catalog\CatalogFactory::getInstance()->getGoodById($this->catalogItemId);
        return $this->good;
    }
}