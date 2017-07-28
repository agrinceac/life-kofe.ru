<?php
namespace modules\catalog\catalog\lib;
class CatalogItemConfig extends \core\modules\base\ModuleConfig
{
	use \core\traits\adapters\Date,
		\core\traits\adapters\Base,
		\core\traits\outAdapters\OutDate,
		\modules\catalog\CatalogValidators,
		\core\traits\validators\Sitemap,
		\core\traits\adapters\Sitemap;

    const KOFE_MASHINES_CATEGORY_ID =8;
    const KOFE_CATEGORY_ID =9;
    const SPARE_PARTS_CATEGORY_ALIAS = 'spare_parts';

	const ACTIVE_STATUS_ID  = 1;
	const BLOCKED_STATUS_ID = 2;
	const REMOVED_STATUS_ID = 3;

	protected $objectClass  = '\modules\catalog\catalog\lib\CatalogItem';
	protected $objectsClass = '\modules\catalog\catalog\lib\Catalog';

	public $templates  = 'modules/catalog/catalog/tpl/';
	public $shopcartTemplate  = 'shopcart/standartShopcartItem';
	public $orderGoodAdminTemplate  = 'standartGoods';
	public $imagesPath = 'files/catalog/images/';
	public $imagesUrl  = 'data/images/catalog/';
	public $filesPath = 'files/catalog/files/';
	public $filesUrl  = 'data/files/catalog/';

	protected $table = 'catalog_catalog'; // set value without preffix!
	protected $idField = 'id';
	protected $objectFields = array(
		'id',
		'categoryId',
		'statusId',
		'description',
		'text',
		'priority',
		'date',
		'lastUpdateTime',
		'sitemapPriority',
		'changeFreq',
		'fabricatorId',
		'seriaId',
		'video',
		'card',
		'onMainDanaPage',
        'onMainMeriPage'
	);

    public $checkboxFields = array(
        'card',
		'onMainDanaPage'
    );

	public function rules()
	{
		return array(
			'name' => array(
				'validation' => array('_validNotEmpty'),
				'adapt' => '_adaptHtml',
			),
			'alias' => array(
				'adapt' => '_adaptAlias',
			),
			'categoryId, statusId' => array(
				'validation' => array('_validInt', array('notEmpty'=>true)),
			),
			'seriaId' => array(
				'validation' => array('_validInt'),
			),
			'fabricatorId' => array(
				'validation' => array('_validInt', array('notEmpty'=>true)),
			),
			'date' => array(
				'adapt' => '_adaptRegDate',
			),
			'lastUpdateTime' => array(
				'validation' => array('_validLastUpdateTime'),
				'adapt' => '_adaptLastUpdateTime',
			),
			'sitemapPriority' => array(
				'validation' => array('_validSitemapPriority'),
				'adapt' => '_adaptSitemapPriority',
			),
			'changeFreq' => array(
				'validation' => array('_validChangeFreq'),
				'adapt' => '_adaptChangeFreq',
			),
			'card, onMainDanaPage, onMainMeriPage' => array(
				'adapt' => '_adaptBool',
			)
		);
	}

	public function outputRules()
	{
		return array(
			'date' => array('_outDate'),
			'lastUpdateTime' => array('_outDateTime'),
		);
	}

	public function getNewStatusId(){return self::NEW_STATUS_ID;}

    public function getSparePartsCategoryAlias()
    {
        return self::SPARE_PARTS_CATEGORY_ALIAS;
    }

    public function getSparePartsCategory()
    {
        return (new Catalog())->getCategories()->getObjectByAlias($this->getSparePartsCategoryAlias());;
    }

    public function getHiddenCategoriesId()
    {
        return [self::KOFE_CATEGORY_ID, self::KOFE_MASHINES_CATEGORY_ID];
    }
}