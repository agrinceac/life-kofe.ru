<?php
namespace controllers\front\order;
class MainOrderFrontController extends \controllers\base\Controller
{
	use
		\core\traits\controllers\Templates,
		\core\traits\controllers\Authorization,
		\core\traits\RequestHandler,
        \core\traits\validators\Capcha;

	protected $permissibleActions = array(
		'ajaxGetQuickOrderBlock',
		'ajaxSendQuickOrderForm',
		'getOrdersByClientIdAndArchiveStatus',
		'getOrderByNr',
        'orderSpare',
        'contactsQuestion',
        'repairsQuestion',
        'orderMashine'
	);

	public function  __construct()
	{
		$this->_config = new \modules\orders\lib\OrderConfig();
		$this->objectClass = $this->_config->getObjectClass();
		$this->objectsClass = $this->_config->getObjectsClass();
	}

	protected function baseAddOrder($data)
	{
		$post = new \core\ArrayWrapper($data);
		$objectId =  $this->setObject($this->_config->getObjectsClass())->modelObject->add($post, $this->modelObject->getConfig()->getObjectFields());
		return $objectId;
	}

	protected function addOrderGood($data)
	{
		$orderGoodConfig = new \modules\orders\orderGoods\lib\OrderGoodConfig();
		$post = new \core\ArrayWrapper($data);
		return  $this->setObject($orderGoodConfig->getObjectsClass())->modelObject->add($post, $this->modelObject->getConfig()->getObjectFields());
	}

	public function ajaxGetQuickOrderBlock()
	{
		$this->getQuickOrderBlock($this->getPOST()['goodId']);
	}

	protected function getQuickOrderBlock($goodId)
	{
		$good = \modules\catalog\CatalogFactory::getInstance()->getGoodById($goodId);
		$this->setContent('object', $good)
			 ->includeTemplate('/order/quickOrder');
	}

	protected function printSmallParams($params)
	{
		if (is_array($params))
			$this->setContent('params', $params)
				 ->includeTemplate('catalog/smallParamsBlock');
		else
			echo $params;
		return $this;
	}

	protected function ajaxSendQuickOrderForm()
	{
		$feedback = new \modules\mailers\QuickFormFeedback($this->getPOST());
		$this->setObject($feedback)->ajax($this->modelObject->sendMail(), 'ajax');
	}

	protected function getOrdersByClientIdAndArchiveStatus($clientId, $archiveStatus=null)
	{
		$orders = $this->getObject($this->getObjectsClass());

		$filters = new \core\FilterGenerator();
		$filters->setSubquery('AND `clientId` = ?d', $clientId);

		$domain = $this->getController('ModulesDomain')->getValidDomain($_SERVER['HTTP_HOST']);
		$filters->setSubquery('AND `domain` = \'?s\'', $domain);

		$statusesArray = $archiveStatus ? 'archiveOrdersId' : 'currentOrdersId';
		$filters->setSubquery('AND `statusId` IN ('.implode(',', $this->getConfig()->$statusesArray).')');

		$filters->setOrderBy('`date` DESC, `id` DESC');

		return $orders->setFilters($filters);
	}

	private function getConfig()
	{
		return $this->_config;
	}

	private function getObjectsClass()
	{
		return $this->getConfig()->getObjectsClass();
	}

	private function getObjectClass()
	{
		return $this->getConfig()->getObjectClass();
	}

	protected function getOrderByNr($nr)
	{
		$this->setObject( $this->getObject($this->getObjectsClass()) );
		$orderId = $this->modelObject->getFieldWhereCriteria('id', $nr, 'nr', $this->getCurrentDomainAlias(), 'domain');
		return $orderId  ?  $this->getObject($this->getObjectClass(), $orderId)  :  false;
	}

    protected function add()
    {
        $mail = new \modules\shopcart\lib\MailShopcart($this->getController('shopcart')->getShopcart());

        $res = $this->setObject($mail)
            ->modelObject->MailShopcartToAdmin();

        if($res == 1){
            $this->getController('shopcart')->resetShopcart();
            return $this->ajaxResponse(1);
        }

        return $this->ajaxResponse($this->modelObject->getErrors());
    }

	protected function sendOrderByOneClick ()
	{
        $mail = new \modules\mailers\OrderByOneClickMail();
        $res = $this->setObject($mail)
            ->modelObject->sendPhoneNumberToManagers();
        return $this->ajaxResponse($res ? $res : $this->modelObject->getErrors());
	}

	private function getContent($template, $data = null)
	{
		if($data)
			$this->setContent('data', $data);
		ob_start();
		$this->includeTemplate('/order/'.$template);
		$contents = ob_get_contents();
		ob_end_clean();
		return $contents;
	}

    protected function orderSpare()
    {
        $mail = new \modules\mailers\OrderSpareMail();
        $res = $this->setObject($mail)
                    ->modelObject->sendToManagers();
        return $this->ajaxResponse($res ? $res : $this->modelObject->getErrors());
    }

    protected function contactsQuestion()
    {
        $mail = new \modules\mailers\ContactsQuestionMail();
        $res = $this->setObject($mail)
            ->modelObject->sendToManagers();
        return $this->ajaxResponse($res ? $res : $this->modelObject->getErrors());
    }

    protected function repairsQuestion()
    {
        $mail = new \modules\mailers\RepairsQuestionMail();
        $res = $this->setObject($mail)
            ->modelObject->sendToManagers();
        return $this->ajaxResponse($res ? $res : $this->modelObject->getErrors());
    }

    protected function orderMashine()
    {
        $mail = new \modules\mailers\OrderMashineMail();
        $res = $this->setObject($mail)
            ->modelObject->sendToManagers();
        return $this->ajaxResponse($res ? $res : $this->modelObject->getErrors());
    }
}
