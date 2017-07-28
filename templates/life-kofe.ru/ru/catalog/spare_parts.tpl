<?$this->includeTemplate('meta')?>
<?$this->includeTemplate('header')?>

    <link rel="stylesheet" href="/css/life-kofe.ru/pages/repair_parts.css">
    <header id="page-header">
        <h1 class="container"><?=$category->getH1()?></h1>
    </header>

    <?$this->getController('Catalog')->getFilter()?>

    <br><br>
    <h2>Производители</h2>
    <link rel="stylesheet" href="/css/life-kofe.ru/pages/repairs.css">
    <script src="/js/fabricators.js"></script>
    <div class="placeForFabricatorsBlock"></div>
    <br><br>

    <?if($subCategories->count()):?>
    <section id="search-for-spare-parts-for-type" class="has-padding">
        <div class="container">
            <h2>Искать запчасти по типу</h2>
            <nav>
                <ul class="row">
                    <?foreach ($subCategories as $subCategory):?>
                    <li class="col-md-4 col-sm-6">
                        <a href="<?=$subCategory->getPath()?>"><?=$subCategory->getName()?></a>
                    </li>
                    <?endforeach?>
                </ul>
            </nav>
        </div>
    </section>
    <?endif?>

    <?=$category->getText()?>

    <script src="/js/orderSpare.js"></script>
    <div class="col-sm-7">
        <div class="orderSpare" role="form">
            <h2 class="text-left">Не нашли нужную запчасть?</h2>
            <p>У нас большая база поставщиков запчастей, и в случае если нет запчастей в нашем каталоге мы сможем помочь вам найти необходимые вам запчасти.</p>
            <ul class="list-unstyled row">
                <li class="col-sm-6">
                    <div class="form-group">
                        <input type="text" name="sparePartName" id="sparePartName" class="form-control" value="" required="required" pattern="" placeholder="Название запчасти">
                    </div>
                </li>
                <li class="col-sm-6">
                    <div class="form-group">
                        <input type="text" name="brand" id="brand" class="form-control" value="" required="required" placeholder="Марка кофемашины">
                    </div>
                </li>
                <li class="col-sm-6">
                    <div class="form-group">
                        <input type="text" name="customerName" id="customerName" class="form-control" value="" required="required" pattern="" placeholder="Ваше имя">
                    </div>
                </li>
                <li class="col-sm-6">
                    <div class="form-group">
                        <input type="tel" name="customerPhone" id="customerPhone" class="form-control" value="" required="required" placeholder="Ваш телефон">
                    </div>
                </li>
                <li class="col-xs-12">
                    <div class="form-group">
                        <textareajsincluderalias name="comment" class="form-control" name="customerComment" id="customerComment" placeholder="Комментарий (не обязательно)"></textareajsincluderalias>
                    </div>
                </li>
                <li class="col-xs-12 hide orderSpareOkMessage hide">
                    <div class="form-group">
                        Спасибо.
                        <br>
                        Ваше сообщение принято.
                        <br>
                        Наши менеджеры свяжутся с вами в ближайшее время.
                    </div>
                </li>
            </ul>
            <button class="btn btn-info orderSpareSubmit">Отправить</button>
        </div>
    </div>
    </div>
    </div>
    </section>

<?$this->includeTemplate('footer')?>