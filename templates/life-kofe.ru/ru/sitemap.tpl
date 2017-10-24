<?$this->includeTemplate('meta')?>
<?$this->includeTemplate('header')?>
    <main id="main">
        <nav class="container">
            <ol class="breadcrumb">
                <li>
                    <a href="/">Главная</a>
                </li>
                <li class="active">Карта сайта</li>
            </ol>
        </nav>
        <article class="container">
            <header>
                <h1>Карта сайта</h1>
                <div class="row">

                    <h3 class="col-md-10 col-md-offset-1 text-muted">Статьи</h3>
                    <p class="col-md-10 col-md-offset-1 text-muted">
                        <? foreach ($this->getController('Article')->getFooterMenuArticles() as $article): ?>
                        <a href="<?=$article->getPath()?>" target="_blank"><?=$article->getName()?></a>
                        <br>
                        <? endforeach; ?>
                    </p>

                    <br>
                    <h3 class="col-md-10 col-md-offset-1 text-muted">Полезные ссылки</h3>
                    <p class="col-md-10 col-md-offset-1 text-muted">
                        <a href="/useful/" target="_blank">Полезные статьи</a>
                        <br>
                        <a href="/docs/" target="_blank">Инструкции</a>
                        <br>
                        <a href="/schemes/" target="_blank">Схемы кофемашин</a></li>
                    </p>

                    <br>
                    <h3 class="col-md-10 col-md-offset-1 text-muted">Производители</h3>
                    <p class="col-md-10 col-md-offset-1 text-muted">
                        <? foreach ($this->getController('Catalog')->getAllFabricatorsWithoutKofe() as $fabricator): ?>
                            <?if($fabricator->getNativePath()):?>
                            <a href="<?=$fabricator->getNativePath()?>" target="_blank"><?=$fabricator->getName()?></a>
                            <br>
                            <?endif?>
                        <? endforeach; ?>
                    </p>

                    <br>
                    <h3 class="col-md-10 col-md-offset-1 text-muted">Запчасти по производителям</h3>
                    <p class="col-md-10 col-md-offset-1 text-muted">
                        <? foreach ($this->getController('Catalog')->getAllFabricatorsWithoutKofe() as $fabricator): ?>
                        <?if($fabricator->getPath()):?>
                            <a href="<?=$fabricator->getPath()?>" target="_blank"><?=$fabricator->getName()?></a>
                            <br>
                                <?
                                    $categories = $this->getController('Catalog')->getCategoriesByFabricatorId($fabricator->id);
                                    if($categories):
                                    foreach($categories as $category):
                                ?>
                                &nbsp;&nbsp;|-
                                <a href="<?=$category->getPath($fabricator->alias)?>" target="_blank">
                                    <?=$category->getName()?>
                                </a>
                                <br>
                                    <?
                                    $objects = $this->getController('Catalog')->getObjectsByCategory($category, $fabricator->id);
                                    if($objects->count()):
                                    foreach($objects as $object):
                                    ?>
                                    &nbsp;&nbsp;&nbsp;&nbsp;|-
                                    <a href="<?=$object->getPath()?>" target="_blank">
                                        <?=$object->getName()?>
                                    </a>
                                    <br>
                                    <?endforeach;endif?>
                                <br>
                                <?endforeach;endif?>
                        <?endif?>
                        <? endforeach; ?>
                    </p>
                </div>
            </header>
        </article>
    </main>
<?$this->includeTemplate('footer')?>