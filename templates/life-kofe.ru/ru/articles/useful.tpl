<?$this->includeTemplate('meta')?>
<?$this->includeTemplate('header')?>

<link rel="stylesheet" href="/css/life-kofe.ru/pages/news.css">

<section id="useful-news" class="has-padding">
    <div class="container">
        <h1>Полезные статьи</h1>
        <div class="row">
            <?foreach($objects as $object):?>
            <div class="search_result">
                <p class="name"><a href="<?=$object->getPath()?>"><?=$object->name?></a></p>
                <p>
                    <?//$pureText = preg_replace( '/'.preg_quote($object->name, '/').'/', '', $object->text, 1)?>
                    <?= $object->description
                        ? $object->description
                        : mb_substr(strip_tags(\core\utils\Utils::strReplaceFirst($object->name, '', $object->text)), 0, 300, 'UTF-8').'...'
                    ?>
                </p>
            </div>
            <?  endforeach;?>
            <?=$this->printPager($objects->getPager(), 'articles/news-pager')?>
        </div>
    </div>
</section>

<?$this->includeTemplate('footer')?>