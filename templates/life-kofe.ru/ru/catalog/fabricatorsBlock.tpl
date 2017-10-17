<?if($allFabricatorsWithoutCofe->count()):?>
    <section id="search-for-spare-parts-by-manufacturer">
        <div class="container text-center">
            <ul class="row list-unstyled list-of-brands">
                <?foreach ($allFabricatorsWithoutCofe as $allFabricator):?>
                    <li class="col-lg-2 col-md-3 col-sm-4">
                        <a
                                <?if($allFabricator->$pathMethod()):?>
                                href="<?=$allFabricator->$pathMethod()?>"
                                <?endif;?>
                                class="thumbnail"
                        >
                            <img src="<?=$allFabricator->getMainImage('141x29')?>" alt="<?=$allFabricator->getName()?>">
                        </a>
                    </li>
                <?endforeach?>
            </ul>
        </div>
    </section>
<?endif?>