<?php
namespace modules\catalog\rentCoffeeMachines\lib;
class RentCoffeeMachines extends \core\modules\base\ModuleObjects
{
    protected $configClass     = '\modules\catalog\rentCoffeeMachines\lib\RentCoffeeMachineConfig';
    protected $objectClassName = '\modules\catalog\rentCoffeeMachines\lib\RentCoffeeMachine';

    function __construct()
    {
        parent::__construct(new $this->configClass);
    }
}
