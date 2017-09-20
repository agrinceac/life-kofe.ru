<?$this->includeTemplate('meta')?>
<?$this->includeTemplate('header')?>

<link rel="stylesheet" href="/css/life-kofe.ru/pages/news.css">

<section id="useful-news" class="has-padding">
    <div class="container">
        <div class="row">
            <?foreach($objects as $object):?>
            <div class="search_result">
                <p class="name"><a href="<?=$object->getPath()?>"><?=$object->name?></a></p>
                <p><?=$object->description ? $object->description : mb_substr(strip_tags($object->text), 0, 300, 'UTF-8').'...'?></p>
            </div>
            <?  endforeach;?>
            <?=$this->printPager($objects->getPager(), 'articles/news-pager')?>
        </div>
    </div>
</section>

<?$this->includeTemplate('footer')?>