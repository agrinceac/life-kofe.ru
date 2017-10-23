<body>
    <header id="header">
        <div class="container text-center">
            <div class="row">
                <div class="col-md-2 col-sm-3 col-xs-4 text-left logo">
                    <a href="/"><img src="/images/bg/logo.svg" alt="Логотип сайта"></a>
                </div>
                <div class="col-lg-8 col-md-7 col-sm-5 col-xs-8 contact-links contact-links-fix">
                    <div class="row">
                        <div class="col-lg-4 col-md-6 col-sm-12">
                            <figure class="media">
                                <picture class="media-left">
                                    <i class="glyphicon glyphicon-map-marker"></i>
                                </picture>
                                <figcaption class="media-body text-left">
                                    <address>Москва,<br>ул. Профсоюзная д. 93,<br>м. Беляево</address>
                                    <a href="/contacts/#driving-directions" class="text-orange">Схема проезда</a>
                                </figcaption>
                            </figure>
                        </div>
                        <div class="col-sm-4 hidden-md hidden-sm hidden-xs">
                            <a href="/contacts/#contact-form" class="btn btn-primary">Задать вопрос</a>
                        </div>
                        <div class="col-lg-4 col-md-6 text-left tel-num-head-fix">
                            <i class="glyphicon glyphicon-earphone"></i> <a href="tel:+74955077317" class="h3">+7 (495) 507-7317</a>
                        </div>
                    </div>
                </div>

                <div class="col-lg-2 col-md-3 col-sm-4 basket-btn-box shopcartBarPlace">
                    <?$this->getController('Shopcart')->getShopcartBar()?>
                </div>

            </div>
        </div>
        <?$this->getController('Article')->getTopMenu()?>
    </header>
    <main id="main">

        <?$this->includeBreadcrumbs()?>