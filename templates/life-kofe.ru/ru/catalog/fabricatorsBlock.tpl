<?if($allFabricators->count()):?>
    <section id="search-for-spare-parts-by-manufacturer">
        <div class="container text-center">
            <ul class="row list-unstyled list-of-brands">
                <?foreach ($allFabricators as $allFabricator):?>
                    <li class="col-lg-2 col-md-3 col-sm-4">
                        <a href="<?=$allFabricator->getPath()?>" class="thumbnail">
                            <img src="<?=$allFabricator->getMainImage('141x29')?>" alt="<?=$allFabricator->getName()?>">
                        </a>
                    </li>
                <?endforeach?>
            </ul>
        </div>
    </section>
<?endif?>