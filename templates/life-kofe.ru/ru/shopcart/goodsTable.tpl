<div class="shopcartContent">

    <?if($this->getShopcart()->count()):?>

    <section id="basket" class="shopcartContent">
        <div class="panel basket table-responsive">
            <table class="table table-bordered table-hover">
                <colgroup>
                    <col>
                    <col>
                    <col width="150">
                    <col>
                    <col width="150">
                    <col width="50">
                </colgroup>
                <thead>
                <tr>
                    <th>Фото</th>
                    <th>Наименование</th>
                    <th>Цена</th>
                    <th>Кол-во</th>
                    <th>Стоимость</th>
                    <th></th>
                </tr>
                </thead>
                <tbody>

                <?foreach($this->getShopcart()->getSortedByIndexArray() as $object):?>
                <tr>
                    <td>
                        <a href="<?=$object->getPath()?>" target="_blank">
                            <img src="<?=$object->getFirstPrimaryImage()->getImage('115x115')?>" alt="Наименование продукта">
                        </a>
                    </td>
                    <td>
                        <h4><a href="<?=$object->getPath()?>" target="_blank"><?=$object->getName()?></a></h4>
                        <p class="model"><?=$object->getFabricator()->getName()?></p>
                        <?if($object->getArticul()):?>
                        <p class="model">Артикул <?=$object->getArticul()?></p>
                        <?endif?>
                    </td>
                    <td>
                        <strong class="price">
                            <var><?=number_format( $object->getShowPrice($object->getQuantity()), 2, '.', ' ' )?></var>
                            <label>р.</label>
                        </strong>
                    </td>
                    <td>
                        <select
                            name=""
                            class="form-control changeQuantity"
                            required="required"
                            data-objectId="<?=$object->id?>"
                            data-goodClass="<?=$object->getClass()?>"
                            data-goodCode="<?=$object->getCode()?>"
                            data-goodId="<?=$object->id?>"
                        >
                            <?for($i=1; $i<$this->getController('Catalog')->getItemsInSelect()+1; $i++):?>
                                <option
                                    value="<?=$i?>"
                                    <?= $object->getQuantity()==$i ? 'selected' : ''?>
                                ><?=$i?></option>
                            <?endfor?>
                        </select>
                    </td>
                    <td>
                        <strong class="price">
                            <var><?=number_format( $object->getTotalPrice(), 2, '.', ' ' )?></var>
                            <label>р.</label>
                        </strong>
                    </td>
                    <td>
                        <a
                            role="button" class="removeFromShopcart"
                            data-goodId="<?=$object->id?>"
                            data-goodClass="<?=$object->getClass()?>"
                            data-goodCode="<?=$object->getCode()?>"
                        >
                            <img src="/images/bg/pages/basket/remove.svg" alt="Удалить">
                        </a>
                    </td>
                </tr>
                <?endforeach?>

                </tbody>
                <tfoot>
                <tr>
                    <td colspan="3"></td>
                    <td><strong class="h3">Итого:</strong></td>
                    <td>
                        <strong class="price">
                            <var><?=number_format( $this->getShopcart()->getTotalPrice(), 2, '.', ' ' )?></var>
                            <label>р.</label>
                        </strong>
                    </td>
                    <td></td>
                </tr>
                <tr class="deliveryInTableTr">
                    <td></td>
                    <td colspan="4"><strong class="h5">Доставка:&nbsp;&nbsp;&nbsp;&nbsp;</strong><span class="deliveryInTable"></span></td>
                </tr>
                </tfoot>
            </table>
        </div>
        <div class="actions text-center">
            <a class="btn btn-primary showDeliveryInTable" role="button" data-toggle="collapse" href="#order-form" aria-expanded="false"
                aria-controls="order-form">Оформить заказ
            </a>
        </div>
        <br>
    </section>


    <form id="sendOrderBlock">
        <section id="order-form" class="collapse has-padding shopcartContent">
            <h2 class="text-uppercase text-center">Оформление заказа</h2>
            <div class="row">
                <div class="col-md-6 col-sm-8 col-md-offset-3 col-sm-offset-2">
                    <ul class="row list-unstyled">
                        <li class="col-sm-6">
                            <div class="form-group">
                                <label class="h5" for="customerFirstName">Имя</label>
                                <input type="text" class="form-control" name="name" placeholder="">
                            </div>
                        </li>
                        <li class="col-sm-6">
                            <div class="form-group">
                                <label class="h5" for="customerSecondName">Фамилия</label>
                                <input type="text" class="form-control" name="family" placeholder="">
                            </div>
                        </li>
                        <li class="col-sm-6">
                            <div class="form-group">
                                <label class="h5" for="customerPhone">Телефон</label>
                                <input type="tel" class="form-control" name="phone" placeholder="">
                            </div>
                        </li>
                        <li class="col-sm-6">
                            <div class="form-group">
                                <label class="h5" for="customerEmail">Email</label>
                                <input type="email" class="form-control" name="email" placeholder="">
                            </div>
                        </li>
                        <li class="col-sm-12">
                            <div class="form-group deliveryTypes">
                                <label class="h5" for="customerSecondName">Доставка</label>
                                <div class="radio">
                                    <label>
                                        <input type="radio" name="deliveryType" class="toggleDeliveryBlock" checked
                                            value="<?=\modules\shopcart\lib\ShopcartSources::getInstance()->getSource('delivery', 'courierMoscow')?>"
                                        >
                                        <span>
                                            <strong><?=\modules\shopcart\lib\ShopcartSources::getInstance()->getSource('delivery', 'courierMoscow')?>
                                                (<?= $this->getMoscowDeliveryCost()  ?  $this->getMoscowDeliveryCost().'р.'  :  'бесплатно'?>)
                                            </strong>
                                            <br>
                                            Курьерская доставка осуществляется курьерами по городу Москве в рабочие дни с 10.00 до 20.00., иное время доставки необходимо согласовать с менеджером.
                                            Стоимость доставки: при заказе товаров на сумму до 1000р. - 400р., при заказе товаров на сумму от 1000р. до 4000р. - 300р., при заказе товаров на сумму свыше 4000р. - бесплатно.
                                        </span>
                                    </label>
                                </div>
                                <ul class="row list-unstyled deliveryBlock">
                                    <li class="col-sm-6">
                                        <div class="form-group">
                                            <label class="h5" for="cityOfDelivery">Город доставки</label>
                                            <input type="text" class="form-control" name="city" placeholder="">
                                        </div>
                                    </li>
                                    <li class="col-sm-6">
                                        <div class="form-group">
                                            <label class="h5" for="street">Улица</label>
                                            <input type="text" class="form-control" name="street" placeholder="">
                                        </div>
                                    </li>
                                    <li class="col-sm-4">
                                        <div class="form-group">
                                            <label class="h5" for="houseNumber">Номер дома</label>
                                            <input type="text" class="form-control" name="home" placeholder="">
                                        </div>
                                    </li>
                                    <li class="col-sm-2">
                                        <div class="form-group">
                                            <label class="h5" for="apartament">Квартира</label>
                                            <input type="text" class="form-control" name="flat" placeholder="">
                                        </div>
                                        <br><br>
                                    </li>
                                </ul>
                                <div class="radio">
                                    <label>
                                        <input type="radio" name="deliveryType"
                                            value="<?=\modules\shopcart\lib\ShopcartSources::getInstance()->getSource('delivery', 'bySelfFreeCharge')?>"
                                        >
                                        <span>
                                            <strong><?=\modules\shopcart\lib\ShopcartSources::getInstance()->getSource('delivery', 'bySelfFreeCharge')?></strong>
                                            <br>
                                            Самовывоз возможен по адресу <strong><a href="/contacts/#driving-directions" target="_blank">Москва, ул. Профсоюзная д. 93</a></strong>. Уважаемые покупатели, обращаем Ваше внимание на то, что самовывоз товара осуществляется только на основании раннее оформленного заказа на сайте, или по телефону, так как наличие товара гарантировано в течении трех дней с момента оформления заказа.
                                        </span>
                                    </label>
                                </div>
                                <div class="radio">
                                    <label>
                                        <input type="radio" name="deliveryType" class="toggleDeliveryBlock"
                                           value="<?=\modules\shopcart\lib\ShopcartSources::getInstance()->getSource('delivery', 'expressInRussia')?>"
                                        >
                                        <span>
                                            <strong><?=\modules\shopcart\lib\ShopcartSources::getInstance()->getSource('delivery', 'expressInRussia')?></strong>
                                            <br>
                                            Внимание! Стоимость доставки может изменится, в зависимости от веса посылки и удаленности населенного пункта от областного центра. Точную стоимость доставки уточняйте у менеджеров или на сайте <a href="http://www.edostavka.ru/calculator.html" target="_blank">http://www.edostavka.ru/calculator.html</a>
                                            и <a href="https://www.ponyexpress.ru/support/servisy-samoobsluzhivaniya/tariff/" target="_blank">www.ponyexpress.ru/support/servisy-samoobsluzhivaniya/tariff/.</a>
                                        </span>
                                    </label>
                                </div>
                                <div class="radio">
                                    <label>
                                        <input type="radio" name="deliveryType" class="toggleDeliveryBlock"
                                           value="<?=\modules\shopcart\lib\ShopcartSources::getInstance()->getSource('delivery', 'toTerminal')?>"
                                        >
                                        <span>
                                            <strong><?=\modules\shopcart\lib\ShopcartSources::getInstance()->getSource('delivery', 'toTerminal')?></strong>
                                            <br>
                                            Удобный и быстрый способ доставки в крупные города России. Посылка доставляется в терминал ТК "ПЭК" в Вашем городе. Для получения необходимо предъявить паспорт (для физ. лиц) и номер грузовой декларации (сообщит наш менеджер после отправки).  Срок доставки и стоимость Вы можете рассчитать на сайте компании. (Доставка до ТК ПЭК в г. Москве бесплатна при заказе от 3000р.)
                                            Внимание!
                                            При заказе товаров на сумму менее 4000р., стоимость доставки до терминала в г. Москва составляет 300р., ДОСТАВКА ЗАКАЗА НА СУММУ МЕНЕЕ 1000р. НЕ ОСУЩЕСТВЛЯЕТСЯ)
                                        </span>
                                    </label>
                                </div>
                                <div class="radio">
                                    <label>
                                        <input type="radio" name="deliveryType" class="toggleDeliveryBlock"
                                           value="<?=\modules\shopcart\lib\ShopcartSources::getInstance()->getSource('delivery', 'postInRussia')?>"
                                        >
                                        <span>
                                            <strong><?=\modules\shopcart\lib\ShopcartSources::getInstance()->getSource('delivery', 'postInRussia')?></strong>
                                            <br>
                                            Доставка отправления в отделение Почты России в г. Москва - бесплатно, срок отправки товара в отделение Почты России г. Москвы, с момента поступления денежных средств на счет поставщика 1-3 дня. Отправление осуществляется 1 классом, стоимость доставки ОТ 250р., включая транспортную упаковку.
                                        </span>
                                    </label>
                                </div>
                            </div>
                        </li>
                        <li class="col-sm-12">
                            <div class="form-group paymentTypes">
                                <label class="h5" for="customerSecondName">Способ оплаты</label>
                                <div class="radio">
                                    <label>
                                        <input type="radio" name="paymentType" checked
                                           value="<?=\modules\shopcart\lib\ShopcartSources::getInstance()->getSource('payment', 'cashCourier')?>"
                                        >
                                        <span><strong><?=\modules\shopcart\lib\ShopcartSources::getInstance()->getSource('payment', 'cashCourier')?></strong></span>
                                    </label>
                                </div>
                                <div class="radio">
                                    <label>
                                        <input type="radio" name="paymentType"
                                           value="<?=\modules\shopcart\lib\ShopcartSources::getInstance()->getSource('payment', 'ticketInBank')?>"
                                        >
                                        <span><strong><?=\modules\shopcart\lib\ShopcartSources::getInstance()->getSource('payment', 'ticketInBank')?></strong></span>
                                    </label>
                                </div>

                                <div class="radio">
                                    <label>
                                        <input type="radio" name="paymentType" class="togglePaymentBlock"
                                           value="<?=\modules\shopcart\lib\ShopcartSources::getInstance()->getSource('payment', 'cashless')?>"
                                        >
                                        <span><strong><?=\modules\shopcart\lib\ShopcartSources::getInstance()->getSource('payment', 'cashless')?></strong></span>
                                    </label>
                                </div>
                                <div class="paymentBlock">
                                    <p>Пожалуйста, прикрепите реквизиты</p>
                                    <script src="/js/addMoreFileBlock.js"></script>
                                    <script>addMoreFileBlockInit('#sendOrderBlock');</script>
                                    <div class="fileform fileformDotted" id="fileform">
                                        <div class="selectbutton"><p>Загрузить файл</p></div>
                                        <input class="upload" type="file" name="upload[0]" />
                                    </div>
                                    <div class="fileform fileformNotDotted">
                                        <div class="selectbutton add_more_file addMoreFileBlock"><p>+ еще файл</p></div>
                                    </div>
                                </div>

                                <div class="radio">
                                    <label>
                                        <input type="radio" name="paymentType"
                                           value="<?=\modules\shopcart\lib\ShopcartSources::getInstance()->getSource('payment', 'cards')?>"
                                        >
                                        <span><strong><?=\modules\shopcart\lib\ShopcartSources::getInstance()->getSource('payment', 'cards')?></strong></span>
                                    </label>
                                </div>
                            </div>
                        </li>
                    </ul>
                    <div class="actions text-center">
                        <button class="btn btn-primary sendOrderGetSuccessBlock" type="button">Отправить</button>
                    </div>
                </div>
            </div>
        </section>
    </form>

    <?else:?>

    <section id="order-is-processed" class="-hidden container has-padding">
        <figure class="text-center text-warning">
            <img src="/images/bg/pages/basket/check.svg" alt="Отметка">
            <figcaption class="text-uppercase">
                <h4><strong>Ваша корзина пуста</strong></h4>
                <p>Пожалуйста, выберите понравившиеся <strong><a href="/spare_parts/">товары</a></strong></p>
            </figcaption>
            <p>&nbsp;</p>
            <div class="actions">
                <a href="/" class="btn btn-primary">Перейти на главную</a>
            </div>
        </figure>
    </section>

    <?endif?>

</div>

<section id="order-is-processed" class="-hidden container has-padding hide successBlockHybrid">
    <figure class="text-center text-warning">
        <img src="/images/bg/pages/basket/check.svg" alt="Отметка">
        <figcaption class="text-uppercase">
            <h4><strong>ЗАКАЗ ОФОРМЛЕН</strong></h4>
            <p><strong>Спасибо за оформленный заказ. <br>Наш менеджер свяжется с вами в ближайшее время.</strong></p>
        </figcaption>
        <p>&nbsp;</p>
        <div class="actions">
            <a href="/" class="btn btn-primary">Перейти на главную</a>
        </div>
    </figure>
</section>