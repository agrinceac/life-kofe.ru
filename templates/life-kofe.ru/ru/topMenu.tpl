<?if($topMenu->count()):?>
<nav class="navbar navbar-inverse" role="navigation">
    <div class="container-fluid">
        <button type="button" class="navbar-toggle bg-primary-dark" data-toggle="collapse"
                data-target=".navbar-main-menu">
            <span class="sr-only">Toggle navigation</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
        </button>
        <a class="navbar-brand visible-xs text-white" href="#">Навигация по сайту</a>
    </div>
    <!-- Collect the nav links, forms, and other content for toggling -->
    <div class="collapse navbar-collapse navbar-main-menu">
        <nav id="navbar">
            <div class="container">
                <ul class="nav nav-justified">
                    <?foreach ($topMenu as $article):?>
                    <li class="<?= $this->getRequest()['action']==str_replace("/","",$article->getPath()) ? 'active' : ''?>">
                        <a <?= $this->getRequest()['action']==str_replace("/","",$article->getPath()) ? '' : 'href="'.$article->getPath().'"'?>>
                            <?=$article->getName()?>
                        </a>
                    </li>
                    <?endforeach?>
                </ul>
            </div>
        </nav>
    </div><!-- /.navbar-collapse -->
</nav>
<?endif;?>