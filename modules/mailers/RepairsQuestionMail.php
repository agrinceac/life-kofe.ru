<?php
namespace modules\mailers;
class RepairsQuestionMail extends \core\mail\MailBase
{
	use	\core\traits\RequestHandler,
		\core\traits\controllers\Authorization,
		\core\traits\ObjectPool;

    private $rules = array(
        'name, phone, message' => array(
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

		$res = $this->From($this->noreplyEmail)
				->To($managers)
				->Subject('Клиент написал сообщение со страницы Ремонт кофемашин на сайте '.SEND_FROM)
				->Content('data', $this->data)
				->Content('managers', $managers)
				->BodyFromFile('repairsQuestion.tpl')
				->Send();
		if($res)
			return 1;
		throw new Exception('Error mail() in '.get_class($this).'!');
	}

}
