<?php
namespace modules\catalog\rentCoffeeMachines\lib;
class RentCoffeeMachineDecorator extends \core\modules\base\ModuleDecorator
{
    public $coffeeMachines;

    function __construct($object)
    {
        parent::__construct($object);
    }

    public function getCoffeeMachines()
    {
        if(empty($this->coffeeMachines)) {
            $this->coffeeMachines = new \modules\catalog\rentCoffeeMachines\lib\RentCoffeeMachines();
            $this->coffeeMachines = $this->filterByArticle($this->coffeeMachines, $this->getParentObject());
        }
        return $this->coffeeMachines;
    }

    public function isCoffeeMachineExists()
    {
        return $this->getCoffeeMachines()->count() != 0;
    }

    private function filterByArticle($coffeeMachines, $parentObject)
    {
        return $coffeeMachines->setSubquery('AND `rentPageId` = ?d', $parentObject->id);
    }
}