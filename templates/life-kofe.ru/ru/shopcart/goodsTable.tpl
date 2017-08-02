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
                    </td>
                    <td>
                        <strong class="price">
                            <var><?=number_format( $object->getShowPrice(), 2, '.', ' ' )?></var>
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
                </tfoot>
            </table>
        </div>
        <div class="actions text-center">
            <a class="btn btn-primary" role="button" data-toggle="collapse" href="#order-form" aria-expanded="false"
                aria-controls="order-form">Оформить заказ
            </a>
        </div>
        <br>
    </section>


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
                    <li class="col-sm-6">
                        <div class="checkbox">
<!--                            <label data-toggle="collapse" href="#order-form--delivery" aria-expanded="false"-->
<!--                                   aria-controls="order-form--delivery">-->
                                <input type="checkbox" name="delivery"> — Доставка домой
<!--                            </label>-->
                        </div>
                    </li>
                </ul>
                <ul class="row list-unstyled hide deliveryBlock">
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
                            <input type="number" class="form-control" name="flat" placeholder="">
                        </div>
                    </li>
                </ul>
                <div class="actions text-center">
                    <button class="btn btn-primary sendOrderGetSuccessBlock">Отправить</button>
                </div>
            </div>
        </div>
    </section>

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