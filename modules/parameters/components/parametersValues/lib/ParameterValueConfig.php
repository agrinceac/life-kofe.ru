<?php
namespace modules\parameters\components\parametersValues\lib;
class ParameterValueConfig extends \core\modules\base\ModuleConfig
{
	use \core\traits\validators\Base,
		\core\traits\adapters\Base,
		\core\traits\adapters\Priority;

	protected $objectClass  = '\modules\parameters\components\parametersValues\lib\ParameterValue';
	protected $objectsClass = '\modules\parameters\components\parametersValues\lib\ParameterValues';

	public $templates  = 'modules/parameters/tpl/';

	protected $table = 'parameters_values'; // set value without preffix!
	protected $idField = 'id';
	protected $objectFields = array(
		'id',
		'value',
		'description',
		'priority',
		'parameterId',
		'alias'
	);

	public function rules()
	{
		return array(
			'value' => array(
				'validation' => array('_validNotEmpty'),
			),
			'priority,parameterId' => array(
				'validation' => array('_validInt'),
			),
			'date' => array(
				'adapt' => '_adaptRegDate',
			),
			'description' => array(
				'adapt' => '_adaptHtml',
			),
			'priority' => array(
				'adapt' => '_adaptPriority',
			)
		);
	}

	public function relations()
	{
		$relations = array(
			'tbl_catalog_catalog_parameters_values_relation' => array('idField'=>'objectId')
		);
		return $relations;
	}

}
