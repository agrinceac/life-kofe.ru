<?php
namespace modules\articles\lib;
class ArticleConfig extends \core\modules\base\ModuleConfig
{
	use \core\traits\validators\Base,
		\core\traits\adapters\Date,
		\core\traits\adapters\Alias,
		\core\traits\adapters\Base,
		\core\traits\outAdapters\OutDate,
		\core\traits\validators\Sitemap,
		\core\traits\adapters\Sitemap;

	const ACTIVE_STATUS_ID = 1;
	const BLOCKED_STATUS_ID = 2;

	const TOP_MENU_CATEGORY_ID = 1;

    const INDEX_ALIAS = 'about';
    const USEFUL_ARTICLE_CATEGORY_ID = 3;

	protected $objectClass  = '\modules\articles\lib\Article';
	protected $objectsClass = '\modules\articles\lib\Articles';

	public $templates  = 'modules/articles/tpl/';
	public $imagesPath = 'files/articles/images/';
	public $imagesUrl  = 'data/images/articles/';
	public $filesPath = 'files/articles/files/';
	public $filesUrl  = 'data/files/articles/';

    public $allowableRentPages = [
        'rent_for_office',
        'rent_when_broke',
        'rent_to_exhibition',
    ];

	protected $table = 'articles'; // set value without preffix!
	protected $idField = 'id';
	protected $objectFields = array(
		'id',
		'categoryId',
		'statusId',
		'blank',
		'redirect',
		'priority',
		'name',
		'h1',
		'alias',
		'description',
		'text',
		'date',
		'metaTitle',
		'metaKeywords',
		'metaDescription',
		'headerText',
		'lastUpdateTime',
		'sitemapPriority',
		'changeFreq',
        'breadcrumbsShow'
	);

	public function rules()
	{
		return array(
			'name' => array(
				'validation' => array('_validNotEmpty'),
			),
			'alias' => array(
				'adapt' => '_adaptAlias',
			),
			'statusId' => array(
				'validation' => array('_validInt', array('notEmpty'=>true)),
			),
			'categoryId' => array(
				'validation' => array('_validInt', array('notEmpty'=>true)),
			),
			'date' => array(
				'adapt' => '_adaptRegDate',
			),
			'metaTitle, metaKeywords, metaDescription, headerText' => array(
				'adapt' => '_adaptHtml',
			),
			'blank, breadcrumbsShow' => array(
				'adapt' => '_adaptBool',
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
		);
	}

	public function outputRules()
	{
		return array(
			'date' => array('_outDate'),
			'lastUpdateTime' => array('_outDateTime'),
		);
	}

	public function getActiveStatusId(){return self::ACTIVE_STATUS_ID;}
    public function getBlockStatusId(){return self::BLOCKED_STATUS_ID;}
    public function getTopMenuCategoryId(){return self::TOP_MENU_CATEGORY_ID;}
	public function getIndexAlias(){return self::INDEX_ALIAS;}
}
