<?php
namespace modules\shopcart\lib;
class ShopcartSources
{
    private static $instance;

    private static $delivery = array(
        'courierMoscow' => 'Курьерская доставка по Москве',
        'bySelfFreeCharge' => 'Самовывоз со склада (бесплатно)',
        'expressInRussia' => 'Экспресс доставка по России СДЭК, ПОНИЭКСПРЕСС от (380р.)',
        'toTerminal' => 'Доставка до терминала ТРАНСПОРТНЫХ КОМПАНИЙ по г. Москва (бесплатно)',
        'postInRussia' => 'Почта России (от 200р.)'
    );

    private $payment = array(
        'cashCourier' => 'Наличными курьеру',
        'ticketInBank' => 'По квитанции в банке',
        'cashless' => 'Безналичный расчет',
        'cards' => 'VISA MASTERCARD (только после подтверждения менеджером)'
    );

    private function __construct(){}
    private function __clone(){}

    public static function getInstance()
    {
        if(!isset(self::$instance))
            self::$instance = new self;
        return self::$instance;
    }

    public function getSource($source, $key)
    {
        return get_class_vars(__CLASS__)[$source][$key];
    }
}