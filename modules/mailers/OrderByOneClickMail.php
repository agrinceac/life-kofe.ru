<?php
namespace modules\mailers;
class OrderByOneClickMail extends \core\mail\MailBase
{
	use	\core\traits\RequestHandler,
		\core\traits\controllers\Authorization,
		\core\traits\ObjectPool;

    private $rules = array(
        'phoneNumber' => array(
            'validation' => array('_validNotEmpty'),
        )
    );

    public function rules()
    {
        return $this->rules;
    }

	function __construct()
	{
		parent::__construct();
		$this->templates = DIR.'modules/orders/tpl/mailTemplates/';
        $this->data = $_POST;
	}

	public function sendPhoneNumberToManagers()
	{
        if (!$this->_beforeChange($this->data, array_keys($this->data)))
            return false;

//		$managers = array('testdeloadm@gmail.com');
		foreach($this->getObject('modules\administrators\lib\Administrators')->getActiveManagers() as $manager)
			if( \core\utils\Utils::isEmail($manager->getUserData()['email']))
				$managers[] = $manager->getUserData()['email'];

        $managers[] = $this->adminEmail;
        \core\utils\Utils::isEmail($this->bccEmail) ? $managers[] = $this->bccEmail : '';

		$good = \modules\catalog\CatalogFactory::getInstance()->getGoodById($this->data['goodId']);

		$res = $this->From($this->noreplyEmail)
				->To($managers)
				->Subject('Клиент просит позвонить по номеру '.$this->data['phoneNumber'].', для оформления заказа на '.SEND_FROM)
				->Content('good', $good)
				->Content('clientPhoneNumber', $this->data['phoneNumber'])
				->Content('managers', $managers)
				->BodyFromFile('mailOrderByOneClickContent.tpl')
				->Send();
		if($res)
			return 1;
		throw new Exception('Error mail() in '.get_class($this).'!');
	}

}
