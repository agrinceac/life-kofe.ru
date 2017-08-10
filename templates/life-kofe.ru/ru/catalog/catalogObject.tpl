<?$this->includeTemplate('meta')?>
<?$this->includeTemplate('header')?>

    <link rel="stylesheet" href="/css/<?=$this->getCurrentDomainAlias()?>/pages/products_category.css">

    <section id="product">

        <?if($this->getController('Authorization')->isAdminAuthorizated()):?>
        <a class="adminShow" href="<?=$object->getAdminPath()?>" target="_blank" title="Эта ссылка видна только авторизованному в админской части пользователю">
            Редактировать [id = <?=$object->id?>]
        </a>
        <?endif?>

        <div class="container">
            <div class="row">
                <section class="col-md-5">
                    <?$objectImages = $object->getImagesByObjectId($object->id)?>
                    <?if($objectImages->count()):?>
                    <div id="carousel-id" class="carousel slide" data-ride="carousel">
                        <ol class="carousel-indicators">
                            <? $i=0; foreach ($objectImages as $image):?>
                            <li data-target="#carousel-id" data-slide-to="<?=$i?>" class="<?= $i==0 ? 'active' : ''?>"></li>
                            <? $i++; endforeach;?>
                        </ol>
                        <div class="carousel-inner">
                            <? $i=0; foreach ($objectImages as $image):?>
                            <div class="item <?= $i==0 ? 'active' : ''?>">
                                <img src="<?=$image->getImage('325x325')?>" alt="<?=$object->getInfo()->getName()?>">
                            </div>
                            <? $i++; endforeach;?>
                        </div>
                        <a class="left carousel-control" href="#carousel-id" data-slide="prev"><span
                                class="glyphicon glyphicon-chevron-left"></span></a>
                        <a class="right carousel-control" href="#carousel-id" data-slide="next"><span
                                class="glyphicon glyphicon-chevron-right"></span></a>
                    </div>
                    <?endif;?>
                </section>
                <section class="col-md-7">
                    <h1 class="h2 text-left"><?=$object->getInfo()->getName()?></h1>
                    <div class="row text-warning">
                        <div class="col-sm-6">
                            <table class="product-options">
                                <tbody>
                                    <tr>
                                        <td width="170"><h5 class="media-heading">Производитель:</h5></td>
                                        <td><?=$object->getFabricator()->getName()?></td>
                                    </tr>
                                    <?if($object->getArticul()):?>
                                    <tr>
                                        <td><h5 class="media-heading">Артикул:</h5></td>
                                        <td><?=$object->getArticul()?></td>
                                    </tr>
                                    <?endif;?>
                                </tbody>
                            </table>
                            <p>&nbsp;</p>
                            <span class="h1 product-price">
                                <var><?=number_format( $object->getShowPrice(), 0, ',', ' ' )?></var>
                                <label>р.</label>
                            </span>
                            <p>&nbsp;</p>
                            <form action="" method="POST" class="form-inline" role="form">
                                <div class="form-group">
                                    <label class="h5">Количество:&nbsp;&nbsp;&nbsp;</label>
                                    <select
                                        name=""
                                        class="form-control input-sm byeMoreQuantity"
                                        required="required"
                                        data-objectId="<?=$object->id?>"
                                    >
                                        <?for($i=1; $i<$itemsInSelect+1; $i++):?>
                                        <option value="<?=$i?>"><?=$i?></option>
                                        <?endfor?>
                                    </select>
                                </div>
                            </form>
                        </div>
                        <div class="col-sm-6">
                            <figure class="media">
                                <picture class="pull-left">
                                    <img class="media-object" src="/images/bg/pages/product/car.svg" alt="Автомобиль">
                                </picture>
                                <div class="media-body">
                                    <h5 class="media-heading">Доставка по Москве:</h5>
                                    <p>Бесплатно</p>
                                </div>
                            </figure>
                            <figure class="media">
                                <picture class="pull-left">
                                    <img class="media-object" src="/images/bg/pages/product/map.svg" alt="Карта">
                                </picture>
                                <div class="media-body">
                                    <h5 class="media-heading">Доставка по России:</h5>
                                    <p>Договорная</p>
                                </div>
                            </figure>
                        </div>
                    </div>
                    <p>&nbsp;</p>
                    <div class="product-actions">
                        <button
                            type="button"
                            class="btn btn-primary addToShopcart"
                            data-objectId="<?=$object->id?>" data-objectClass="<?=$object->getClass()?>"
                        >
                            Добавить в корзину</button>
                        <button type="button" class="btn btn-default showModalSendOrderByOneClick" data-toggle="modal" data-target="#myModal">Купить в один клик</button>
                    </div>
                    <p>&nbsp;</p>

                    <?=$object->getInfo()->getText()?>

                </section>
            </div>
        </div>
    </section>

    <script type="text/javascript" src="/js/catalog/orderByOneClick.js"></script>
    <div id="myModal" class="modal fade " role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="sendOrderByOneClick">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title">Купить в один клик - <?=$object->getInfo()->getName()?></h4>
                    </div>
                    <div class="modal-body">
                        <p>Укажите свой номер телефона и наши менеджеры свяжутся с вами в ближайшее время.</p>
                        <p>
                            <input type="text" name="phoneNumber" class="form-control" placeholder="">
                            <input class="oneClickGoodId" name="goodId" type="hidden" value="<?=$object->id?>"/>
                            <br>
                            <button class="btn btn-default sendOrderByOneClickSubmit">Отправить</button>
                        </p>
                    </div>
                    <div class="modal-body sendOrderByOneClickOkMessage hide">
                        <p>Спасибо</p>
                        <p>Ваш заказ принят</p>
                        <p>Наши менеджеры свяжутся с вами в ближайшее время</p>
                        <button type="button" data-dismiss="modal" class="btn btn-default">Закрыть</button>
                    </div>
    <!--                <div class="modal-footer"></div>-->
                </div>
            </div>

        </div>
    </div>

<?$this->includeTemplate('footer')?>