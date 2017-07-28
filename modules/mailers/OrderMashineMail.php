<?php
namespace modules\mailers;
class OrderMashineMail extends \core\mail\MailBase
{
	use	\core\traits\RequestHandler,
		\core\traits\controllers\Authorization,
		\core\traits\ObjectPool;

    private $rules = array(
        'name, phone, address, orderType' => array(
            'validation' => array('_validNotEmpty'),
        ),
        'mashineId' => array(
            'validation' => array('_validInt', array('notEmpty'=>true)),
        ),
        'email' => array(
            'validation' => array('_validEmail', array('notEmpty'=>true)),
        ),
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

	public function sendToManagers()
	{
        if (!$this->_beforeChange($this->data, array_keys($this->data)))
            return false;

//		$managers = array('testdeloadm@gmail.com');
		foreach($this->getObject('modules\administrators\lib\Administrators')->getActiveManagers() as $manager)
			if( \core\utils\Utils::isEmail($manager->getUserData()['email']))
				$managers[] = $manager->getUserData()['email'];

        $managers[] = $this->adminEmail;
        \core\utils\Utils::isEmail($this->bccEmail) ? $managers[] = $this->bccEmail : '';

		$this->From($this->noreplyEmail)
            ->To($managers)
            ->Subject('Клиент заказал аренду кофемашины на сайте '.SEND_FROM)
            ->Content('data', $this->data)
            ->Content('good', \modules\catalog\CatalogFactory::getInstance()->getGoodById($this->data['goodId']))
            ->Content('managers', $managers)
            ->BodyFromFile('orderMashine.tpl');

        if(!empty($_FILES['upload']['name'][0]))
            foreach($_FILES['upload']['name'] as $key=>$value){
                $this->Attach( array(
                    'name'     => $_FILES['upload']['name'][$key],
                    'path'     => $_FILES['upload']['tmp_name'][$key]
//					'filetype' => $_FILES['upload']['type'][$key]
                ) );
            }

		if($this->Send())
			return 1;
		throw new Exception('Error mail() in '.get_class($this).'!');
	}

}
