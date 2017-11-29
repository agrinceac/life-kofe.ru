<?php
namespace modules\shopcart\lib;
class MailShopcart extends \core\mail\MailBase
{
	use	\core\traits\RequestHandler,
		\core\traits\controllers\Authorization,
		\core\traits\ObjectPool;

	private $shopcart;

	private $rules = array(
        'name, family, phone' => array(
            'validation' => array('_validNotEmpty'),
        ),
        'email' => array(
            'validation' => array('_validEmail', array('key'=>'email', 'notEmpty'=>true)),
        )
	);

    private $deliveryRules = array(
        'city, street, home, flat' => array(
            'validation' => array('_validNotEmpty'),
        )
    );

    private $indexRules  = array(
        'index' => array(
            'validation' => array('_validInt', array('notEmpty'=>true)),
        )
    );

	public function rules()
	{
		return $this->rules;
	}

	public function __construct($shopcart)
	{
		parent::__construct();
		$this->templates = TEMPLATES.\core\url\UrlDecoder::getInstance()->getDomainAlias().'/'.$_REQUEST['lang'].'/emails/';
		$this->data = $_POST;
		$this->shopcart = $shopcart;
	}

	public function MailShopcartToAdmin()
	{
        $this->createRules()
            ->attachFiles();

		if (!$this->_beforeChange($this->data, array_keys($this->data)))
			return false;

		//		$managers = array('testdeloadm@gmail.com');
		$managers = array();
		foreach($this->getObject('modules\administrators\lib\Administrators')->getActiveManagers() as $manager)
			if( \core\utils\Utils::isEmail($manager->getUserData()['email']))
				$managers[] = $manager->getUserData()['email'];

		$managers[] = $this->adminEmail;
        \core\utils\Utils::isEmail($this->bccEmail) ? $managers[] = $this->bccEmail : '';

		return $this->From($this->noreplyEmail)
				->To($managers)
				->Subject('Новый заказ с сайта  '.SEND_FROM)
				->Content('data', $this->data)
				->Content('shopcart', $this->shopcart)
				->BodyFromFile('shopcartMailToAdmin.tpl')
                ->Send();
	}

	private function createRules()
    {
        if($this->isBySelfFreeCharge())
            $this->rules = array_merge($this->rules, $this->deliveryRules);
        if(isset($this->data['index']))
            $this->rules = array_merge($this->rules, $this->indexRules);
        return $this;
    }

    protected function isBySelfFreeCharge()
    {
        return $this->data['deliveryType'] != ShopcartSources::getInstance()->getSource('delivery', 'bySelfFreeCharge');
    }

	private function attachFiles()
    {
        if($this->isCashless()){
            if(!empty($_FILES['upload']['name'][0]))
                foreach($_FILES['upload']['name'] as $key=>$value){
                    $this->Attach( array(
                        'name'     => $_FILES['upload']['name'][$key],
                        'path'     => $_FILES['upload']['tmp_name'][$key]
//					'filetype' => $_FILES['upload']['type'][$key]
                    ) );
                }
            else{
                include(DIR.'includes/errorsList.php');
                $this->addError('upload[0]', $errorsList['upload[0]']);
            }
        }
        return $this;
    }

    protected function isCashless()
    {
        return $this->data['paymentType'] == ShopcartSources::getInstance()->getSource('payment', 'cashless');
    }

//	public function MailShopcartToClient()
//	{
//		$res = $this->From($this->noreplyEmail)
//				->To($this->data['email'])
//				->Subject('Заказ с сайта  '.SEND_FROM)
//				->Content('data', $this->data)
//				->Content('shopcart', $this->shopcart)
//				->BodyFromFile('shopcartMailToClient.tpl')
//				->Send();
//		if($res)
//			return 1;
//		throw new \Exception('Error mail() in '.get_class($this).'!');
//	}
}
