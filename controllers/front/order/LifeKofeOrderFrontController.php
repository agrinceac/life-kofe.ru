<?php
namespace controllers\front\order;

class LifeKofeOrderFrontController extends \controllers\front\order\MainOrderFrontController
{
    protected $permissibleActions = array(
        'add',
        'sendOrderByOneClick',
        'orderSpare',
        'contactsQuestion',
        'repairsQuestion',
        'orderMashine'
    );

    protected function add()
    {
        $shopcart = $this->getController('shopcart')->getShopcart();

        $mail = new \modules\shopcart\lib\MailShopcart($shopcart);

        $res = $this->setObject($mail)
            ->modelObject->MailShopcartToAdmin();

        if($res == 1){
            $this->getController('shopcart')->resetShopcart();
            return $this->ajaxResponse($res);
        }

        return $this->ajaxResponse($this->modelObject->getErrors());
    }
}
