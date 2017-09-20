<?$this->includeTemplate('meta')?>
<?$this->includeTemplate('header')?>
        <link rel="stylesheet" href="/css/<?=$this->getCurrentDomainAlias()?>/pages/about.css">
        <article>
            <header id="page-header">
                <div class="container">
                    <div class="row">
                        <section class="col-sm-6 text-center has-padding">
                            <h1>Запчасти</h1>
                            <p>и комплектующие для кофе машин</p>
                            <a
                                href="/<?=$this->getController('Catalog')->_config->getSparePartsCategoryAlias()?>/"
                                class="btn btn-info"
                            >Подробнее</a></section>
                        <section class="col-sm-6 text-center has-padding">
                            <h1>Ремонт</h1>
                            <p>всех моделей кофемашин</p>
                            <a href="/repairs/" class="btn btn-info">Подробнее</a></section>
                    </div>
                </div>
            </header>
            <section id="instructions-schemas-videos" class="bg-info has-padding">
                <div class="container">
                    <ul class="list-of-media list-unstyled row">
                        <li class="col-sm-4">
                            <figure class="media panel panel-default">
                                <picture class="media-left media-middle hidden-sm">
                                    <img src="/images/bg/pages/about/instructions.svg">
                                </picture>
                                <figcation class="media-body">
                                    <h5 class="media-heading text-uppercase">инструкции</h5>
                                    <p class="text-muted">Более 20ти инструкций, для различный моделей кофемашин</p>
                                </figcation>
                            </figure>
                        </li>
                        <li class="col-sm-4">
                            <figure class="media panel panel-default">
                                <picture class="media-left media-middle hidden-sm">
                                    <img src="/images/bg/pages/about/schemas.svg">
                                </picture>
                                <figcation class="media-body">
                                    <h5 class="media-heading text-uppercase">схемы</h5>
                                    <p class="text-muted">Более 20ти схем, для различный моделей кофемашин</p>
                                </figcation>
                            </figure>
                        </li>
                        <li class="col-sm-4">
                            <figure class="media panel panel-default">
                                <picture class="media-left media-middle hidden-sm">
                                    <img src="/images/bg/pages/about/video.svg">
                                </picture>
                                <figcation class="media-body">
                                    <h5 class="media-heading text-uppercase">видео с ремонтом</h5>
                                    <p class="text-muted">Более 20ти видео, с различными разборками кофемашин</p>
                                </figcation>
                            </figure>
                        </li>
                    </ul>
                </div>
            </section>
            <section id="service-center-life-with-coffee-this" class="container has-padding">
                <h2>Сервисный центр Жизнь с Кофе, это</h2>
                <p>&nbsp;</p>
                <ul class="list-of-media list-unstyled row">
                    <li class="col-md-3 col-sm-4">
                        <figure class="thumbnail text-center">
                            <picture>
                                <img src="/images/bg/pages/about/cup-of-coffee.svg" alt="Чашечка кофе">
                            </picture>
                            <figcaption>
                                <p class="text-muted"><span class="text-primary">Сервисное <br>обслуживание</span> любых кофемашин</p>
                            </figcaption>
                        </figure>
                    </li>
                    <li class="col-md-3 col-sm-4">
                        <figure class="thumbnail text-center">
                            <picture>
                                <img src="/images/bg/pages/about/tools.svg" alt="Инструменты">
                            </picture>
                            <figcaption>
                                <p class="text-muted"><span class="text-primary">Ремонт кофемашин</span>
                                    <br>на дому и в сервисном центре</p>
                            </figcaption>
                        </figure>
                    </li>
                    <li class="col-md-3 col-sm-4">
                        <figure class="thumbnail text-center">
                            <picture>
                                <img src="/images/bg/pages/about/basket.svg" alt="Корзина">
                            </picture>
                            <figcaption>
                                <p class="text-muted"><span class="text-primary">Продажа кофемашин и средств для ухода</span>
                                    <br>в наличии и под заказ</p>
                            </figcaption>
                        </figure>
                    </li>
                    <li class="col-md-3 col-sm-4">
                        <figure class="thumbnail text-center">
                            <picture>
                                <img src="/images/bg/pages/about/settings.svg" alt="Запчасть">
                            </picture>
                            <figcaption>
                                <p class="text-muted"><span class="text-primary">Замена запчастей</span>
                                    <br>дросистемы, кофемолки, капучинатора и т. д.</p>
                            </figcaption>
                        </figure>
                    </li>
                    <li class="col-md-3 col-sm-4">
                        <figure class="thumbnail text-center">
                            <picture>
                                <img src="/images/bg/pages/about/tools-on-time.svg" alt="Аренда">
                            </picture>
                            <figcaption>
                                <p class="text-muted"><span class="text-primary">Аренда кофемашины</span>
                                    <br>на время ремонта старого аппарата</p>
                            </figcaption>
                        </figure>
                    </li>
                    <li class="col-md-3 col-sm-4">
                        <figure class="thumbnail text-center">
                            <picture>
                                <img src="/images/bg/pages/about/calendar.svg" alt="Календарь">
                            </picture>
                            <figcaption>
                                <p class="text-muted"><span class="text-primary">Долгосрочная аренда</span>
                                    <br>кофемашин для дома, офиса, кафе и т. д.</p>
                            </figcaption>
                        </figure>
                    </li>
                    <li class="col-md-3 col-sm-4">
                        <figure class="thumbnail text-center">
                            <picture>
                                <img src="/images/bg/pages/about/beans.svg" alt="Зерна">
                            </picture>
                            <figcaption>
                                <p class="text-muted"><span class="text-primary">Бесплатная аренда кофемашин</span>
                                    <br>при покупке нужного объема кофе;</p>
                            </figcaption>
                        </figure>
                    </li>
                    <li class="col-md-3 col-sm-4">
                        <figure class="thumbnail text-center">
                            <picture>
                                <img src="/images/bg/pages/about/car.svg" alt="Автомобиль">
                            </picture>
                            <figcaption>
                                <p class="text-muted"><span class="text-primary">Доставка кофе по Москве</span> (в пределах МКАД) в течение суток.</p>
                            </figcaption>
                        </figure>
                    </li>
                </ul>
            </section>
            <section class="container has-padding">
                <?=$article->getText()?>
            </section>
            <section id="serving-coffee-machines" class="bg-info has-padding">
                <div class="container text-center">
                    <h2>Обслуживание кофемашин</h2>
                    <script src="/js/fabricators.js"></script>
                    <div class="placeForFabricatorsBlock"><input type="hidden" value="getNativePath"></div>
                </div>
            </section>
        </article>

<?$this->includeTemplate('footer')?>