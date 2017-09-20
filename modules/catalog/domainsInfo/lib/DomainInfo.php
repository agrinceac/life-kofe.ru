<?php
namespace modules\catalog\domainsInfo\lib;
use modules\catalog\reviews\lib\Reviews;

class DomainInfo extends \core\modules\base\ModuleDecorator
{
	function __construct($objectId)
	{
		$object = new DomainInfoObject($objectId);
		parent::__construct($object);
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

	/* Start: URL Methods */
	public function getPath()
	{
		throw new \Exception('Method DomainInfo::getPath() was not finished!');
	}
	/*   End: URL Methods */

	public function isValidPath($path)
	{
		return $this->getPath() == rtrim($path,'/').'/';
	}

	/* Start: IGoodForShopcart Methods */
	public function getMinQuantity()
	{
		return 1;
	}

	public function getPriceByQuantity($quantity)
	{
		return $this->price * $quantity;
	}

	public function  getPrice()
	{
		return $this->price;
	}
	/* End: IGoodForShopcart Methods */
	
	public function getGood()
	{
        $goodId = $this->getObjectInfo()['objectId'];
		return \modules\catalog\CatalogFactory::getInstance()->getGoodById($goodId);
	}
	
	public function getParams()
	{
		return \core\utils\Params::getParamsArray($this->description);
	}
	
	public function getSmallParams()
	{
		return \core\utils\Params::getParamsArray($this->smallDescription);
	}

	public function getReviews()
    {
        return (new Reviews())->filterByDomainInfoId($this->id);
    }

    public function getName()
    {
        return $this->name;
    }

    public function getText()
    {
        return $this->text;
    }

    public function getDescription()
    {
        return $this->description;
    }

    public function getDescriptionForPage($page)
    {
        if ($page == 'rent_for_office')
            return $this->description;
        elseif ($page == 'rent_when_broke')
            return $this->description_rent_when_broke;
        elseif ($page == 'rent_to_exhibition')
            return $this->description_rent_to_exhibition;

        return $this->description;
    }
}