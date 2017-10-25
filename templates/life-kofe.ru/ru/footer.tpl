<?//$this->getController('Article')->getFooterMenu()?>

    </main>

    <footer id="footer" class="bg-primary-dark">
        <div class="container">
            <ul class="list-unstyled row">
                <li class="col-md-3 col-sm-4">
                    <h5>Контакты</h5>
                    <ul class="list-unstyled contact-box">
                        <li>
                            <figure class="media">
                                <div class="pull-left">
                                    <i class="glyphicon glyphicon-phone-alt"></i>
                                </div>
                                <figcaption class="media-body">
                                    <ul class="list-unstyled">
                                        <li><a>+7 (495) 507-7317</a>
                                    </ul>
                                </figcaption>
                            </figure>
                        </li>
                        <li>
                            <figure class="media">
                                <div class="pull-left">
                                    <i class="glyphicon glyphicon-envelope"></i>
                                </div>
                                <figcaption class="media-body">
                                    <a href="email:info@life-kofe.ru">info@life-kofe.ru</a>
                                </figcaption>
                            </figure>
                        </li>
                        <li>
                            <figure class="media">
                                <div class="pull-left">
                                    <i class="glyphicon glyphicon-map"></i>
                                </div>
                                <figcaption class="media-body">
                                        <address>117279, Москва, ул. Профсоюзная д. 93</address>
                                </figcaption>
                            </figure>
                        </li>
                    </ul>
                </li>
                <li class="col-md-3 col-sm-4">
                    <?$topMenuArtilces = $this->getController('Article')->getFooterMenuArticles()?>
                    <?if($topMenuArtilces->count()):?>
                    <h5>Меню</h5>
                    <nav>
                        <ul class="list-unstyled">
                            <?foreach($topMenuArtilces as $topMenuArtilce):?>
                            <li><a href="<?=$topMenuArtilce->getPath()?>"><?=$topMenuArtilce->getName()?></a></li>
                            <?endforeach;?>
                            <!--<li><a href="/rashodnye_materialy">Расходные материалы</a></li>
                            <li><a href="/kofe">Кофе</a></li>-->
                        </ul>
                    </nav>
                    <?endif?>
                </li>
                <li class="col-md-3 col-sm-4">
                    <?$mainCategories = $this->getController('Catalog')->getMainCategories()?>
                    <?if($mainCategories->count()):?>
                    <!--                  <h5>&nbsp;<span class="visible-xs"></span></h5>-->
                    <h5>Полезные ссылки</h5>
                    <nav>
                        <ul class="list-unstyled">
                            <li><a href="/useful/">Полезные статьи</a></li>
                            <li><a href="/docs/">Инструкции</a></li>
                            <li><a href="/schemes/">Схемы кофемашин</a></li>
                        </ul>
                    </nav>
                    <?endif?>
                </li>
                <li class="col-md-3 hidden-sm hidden-xs logo-box">
                    <img src="/images/bg/logo-footer.svg" alt="Логотип сайта">
                    <p>Life-Kofe. 1997-2017 г.</p>
                    <p>

                        <!-- Yandex.Metrika informer -->
                        <a href="https://metrika.yandex.ru/stat/?id=22001263&amp;from=informer"
                           target="_blank" rel="nofollow"><img src="https://informer.yandex.ru/informer/22001263/3_1_FFFFFFFF_EFEFEFFF_0_pageviews"
                                                               style="width:88px; height:31px; border:0;" alt="Яндекс.Метрика" title="Яндекс.Метрика: данные за сегодня (просмотры, визиты и уникальные посетители)" /></a>
                        <!-- /Yandex.Metrika informer -->

                        <!-- Yandex.Metrika counter -->
                        <script type="text/javascript" >
                            (function (d, w, c) {
                                (w[c] = w[c] || []).push(function() {
                                    try {
                                        w.yaCounter22001263 = new Ya.Metrika({
                                            id:22001263,
                                            clickmap:true,
                                            trackLinks:true,
                                            accurateTrackBounce:true,
                                            webvisor:true
                                        });
                                    } catch(e) { }
                                });

                                var n = d.getElementsByTagName("script")[0],
                                    s = d.createElement("script"),
                                    f = function () { n.parentNode.insertBefore(s, n); };
                                s.type = "text/javascript";
                                s.async = true;
                                s.src = "https://mc.yandex.ru/metrika/watch.js";

                                if (w.opera == "[object Opera]") {
                                    d.addEventListener("DOMContentLoaded", f, false);
                                } else { f(); }
                            })(document, window, "yandex_metrika_callbacks");
                        </script>
                        <!-- /Yandex.Metrika counter -->

                    </p>
                </li>
            </ul>
        </div>
    </footer>
    <!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
<!--    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>-->
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>
    <!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
    <script src="http://getbootstrap.com/assets/js/ie10-viewport-bug-workaround.js"></script>
    </body>
</html>