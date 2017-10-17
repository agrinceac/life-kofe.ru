<?php
namespace modules\fabricators\lib;
use modules\catalog\catalog\lib\CatalogItemConfig;

class Fabricator extends \core\modules\base\ModuleDecorator implements \interfaces\IObjectToFrontend
{
    private $noClickIcon = array(
        'fabricatorPage' => array(
            'ulka',
            'rancilio',
            'rancilio-silvia',
            'krups',
            'oks'
        ),
        'catalogPage' => array(
            'rancilio',
            'rancilio-silvia',
            'krups',
            'melitta',
            'rotel',
            'electrolux',
            'aeg',
            'lavazza',
            'danesi'
        )
    );

	function __construct($objectId)
	{
		$object = new FabricatorObject($objectId);
		$object = new \core\modules\categories\CategoryDecorator($object);
		$object = new \core\modules\statuses\StatusDecorator($object);
		$object = new \core\modules\images\ImagesDecorator($object);
		$object = new \core\modules\filesUploaded\FilesDecorator($object);
		$object = new \modules\parameters\components\parametersValues\lib\ParametersValuesRelationDecorator($object);
		$object = new \modules\properties\components\propertiesValues\lib\RelationsDecorator($object);

		parent::__construct($object);
	}

	public function edit ($data, $fields = array())
	{
		if ( $this->getParameters()->edit($data->parametersValues) )
//			if ( $this->additionalCategories->edit($data->additionalCategories) )
				return $this->getParentObject()->edit($data, $fields);

		return false;
	}

	/* Start: Meta Methods */
	public function getMetaTitle()
	{
		return $this->metaTitle ? $this->metaTitle : $this->getName();
	}

	public function getMetaDescription()
	{
		return $this->metaDescription;
	}

	public function getMetaKeywords()
	{
		return $this->metaKeywords;
	}

	public function getHeaderText()
	{
		return $this->headerText;
	}
	/*   End: Meta Methods */

	/* Start: Main Data Methods */
	public function getName()
	{
		return $this->name;
	}
	/*   End: Main Data Methods */

	public function getH1()
	{
		return empty($this->h1) ? $this->name : $this->h1;
	}

	public function getPath()
	{
	    if(in_array($this->alias, $this->noClickIcon['catalogPage']))
            return false;
        return '/'.(new CatalogItemConfig())->getSparePartsCategoryAlias().'/'.$this->alias.'/';
	}

	public function getNativePath()
    {
        if(in_array($this->alias, $this->noClickIcon['fabricatorPage']))
            return false;
        return '/'.$this->alias.'/';
    }

	public function isValidPath($path)
	{
		return $this->getPath() == rtrim($path,'/').'/';
	}

	public function remove () {
		return ($this->delete()) ? (int)$this->id : false ;
	}

	/* Start: Sitemap Methods */
	public function getLastUpdateTime()
	{
		return empty($this->lastUpdateTime) ? time() : $this->lastUpdateTime;
	}

	public function getSitemapPriority()
	{
		return $this->sitemapPriority=='0.0' ? $this->getSitemapPriorityByPath($this->getPath()) : $this->sitemapPriority;
	}

	public function getChangeFreq()
	{
		return empty($this->changeFreq) ? 'weekly' : $this->changeFreq;
	}
	/*   End: Sitemap Methods */

	public function isShowTitleFabricator()
	{
		$config = $this->getConfig();
		return ! in_array($this->id, $config->notShowTitleFabricatorsId);
	}

	public function getConditions()
	{
		return $this->conditions;
	}

	public function getDomain()
    {
        $domain = $this->domain;
        return empty($domain) ? false : $domain;
    }

    public function getText()
    {
        return $this->text;
    }

    public function getAlias()
    {
        return $this->alias;
    }

    public function getMainImage($size)
    {
        $filePath =  'images/bg/fabricators/'.$this->getAlias().'.svg';
        if(file_exists(DIR.$filePath))
            return '/'.$filePath;

        $filePath2 =  'images/bg/fabricators/'.$this->getAlias().'.png';
        if(file_exists(DIR.$filePath2))
            return '/'.$filePath2;

        return $this->getFirstPrimaryImage()->getImage($size);
    }
}