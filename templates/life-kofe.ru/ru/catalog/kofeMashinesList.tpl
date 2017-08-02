<section id="list-of-coffeemachines" class="container has-padding" xmlns="http://www.w3.org/1999/html">
<!--    <h2 class="text-uppercase text-center">Наш модельный ряд</h2>-->

    <?if($objects->count()):?>
    <?foreach($objects as $object):?>
    <div class="row">
        <div class="col-lg-7 col-sm-6">
            <!-- Options box -->
            <figure class="row options-box">
                <picture class="col-lg-6 col-md-3 hidden-sm text-center">
                    <img src="/images/bg/pages/rent_a_coffee_machine_for_an_exhibition/Saeco_Spidem_Villa.jpg" alt="Saeco Spidem Villa" class="img-responsive">
                </picture>
                <figcaption class="col-lg-6 col-md-9">
                    <h3 class="h4 text-uppercase"><?=$object->getInfo()->getName()?></h3>
                    <?=$object->getInfo()->getText()?>
                </figcaption>
            </figure>
            <!-- /Options box -->
        </div>
        <div class="col-lg-5 col-sm-6">
            <?=$object->getInfo()->getDescription()?>
        </div>
    </div>
    <div class="actions text-center orderMashine">
        <button
            type="button"
            class="btn btn-primary orderCofeMashineButton"
            data-goodId="<?=$object->id?>"
            data-name="<?=$object->getInfo()->getName()?>"
        >Заказать</button>
    </div>
    <?endforeach;?>
    <?endif?>

</section>

<div id="modalOrderMashine" class="modal fade " role="dialog">
    <div class="modal-dialog">
        <div class="modal-content">
            <form class="orderMashineForm" enctype="multipart/form-data">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title orderType"></h4>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <div class="form-group col-xs-12">
                            <p>Аренда кофемашины <span class="mashineName"></span></p>
                            <input type="hidden" name="goodId">
                            <input type="hidden" name="orderType">
                        </div>
                        <div class="form-group col-xs-12 col-sm-6">
                            <input type="text" name="name" class="form-control" placeholder="Имя (или навзание организации)">
                        </div>
                        <div class="form-group col-xs-12 col-sm-6">
                            <input type="text" name="email" class="form-control" placeholder="Email">
                        </div>
                        <div class="form-group col-xs-12 col-sm-6">
                            <input type="text" name="phone" class="form-control" placeholder="Телефон">
                        </div>
                        <div class="form-group col-xs-12 col-sm-6">
                            <input type="text" name="address" class="form-control" placeholder="Адрес">
                        </div>
                        <div class="form-group col-xs-6">
                            <select name="qnt" class="form-control">
                                <option value="1" selected>1 шт.</option>
                                <?for($i=2;$i<11;$i++):?>
                                <option value="<?=$i?>"><?=$i?> шт.</option>
                                <?endfor?>
                            </select>
                        </div>
                        <div class="form-group col-xs-6">
                            <select name="days" class="form-control">
                                <option value="1" selected>1 день.</option>
                                <?for($i=2;$i<31;$i++):?>
                                <option value="<?=$i?>"><?=$i?> <?=\core\utils\Utils::declension($i, ['день', 'дня', 'дней'])?></option>
                                <?endfor?>
                            </select>
                        </div>
                        <div class="form-group col-xs-12">
                            <p>Пожалуйста прикрепите необходимые сканы или фотографии</p>
                            <div class="form-group col-xs-6">
                                <p>
                                    Физическое лицо:
                                    <ul>
                                        <li>1 стр. паспорта</li>
                                        <li>стр. паспорта с регистрацией</li>
                                    <ul>
                                </p>
                            </div>
                            <div class="form-group col-xs-6">
                                <p>
                                    Юридическое лицо:
                                    <ul>
                                        <li>свидетельство о регистрации</li>
                                        <li>карта клиента</li>
                                    <ul>
                                </p>
                            </div>

                            <script src="/js/addMoreFileBlock.js"></script>
                            <script>addMoreFileBlockInit('.orderMashineForm');</script>
                            <div class="fileform fileformDotted" id="fileform">
                                <div class="selectbutton"><p>Загрузить файл</p></div>
                                <input class="upload" type="file" name="upload[0]" />
                            </div>
                            <div class="fileform fileformNotDotted">
                                <div class="selectbutton add_more_file addMoreFileBlock"><p>+ еще файл</p></div>
                            </div>

                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <div class="modal-body OkMessage hide">
                        <div class="alert alert-success">
                            <p>Спасибо</p>
                            <p>Ваш заказ принят</p>
                            <p>Наши менеджеры свяжутся с вами в ближайшее время</p>
                        </div>
                        <button type="button" data-dismiss="modal" class="btn btn-default">Закрыть</button>
                    </div>
                    <button type="button" class="btn btn-default submit">Отправить заказ</button>
                </div>
            </form>
        </div>

    </div>
</div>