<?php
namespace modules\catalog\rentCoffeeMachines\lib;
class RentCoffeeMachineConfig extends \core\modules\base\ModuleConfig
{
    use \core\traits\validators\Base,
        \core\traits\adapters\Base,
        \core\traits\outAdapters\OutBase;

    const ACTIVE_STATUS_ID = 1;
    const BLOCKED_STATUS_ID = 2;

    protected $objectClass  = '\modules\catalog\rentCoffeeMachines\lib\RentCoffeeMachine';
    protected $objectsClass = '\modules\catalog\rentCoffeeMachines\lib\RentCoffeeMachines';

    public $templates  = 'modules/catalog/rentCoffeeMachines/tpl/';

    protected $table = 'catalog_rent_pages_cofee_machines'; // set value without preffix!
    protected $idField = 'id';
    protected $objectFields = array(
        'id',
        'rentPageId',
        'catalogItemId',
    );

    public function rules()
    {
        return array(
            'catalogItemId,rentPageId' => array(
                'validation' => array('_validInt', array('notEmpty'=>true)),
            )
        );
    }

}
