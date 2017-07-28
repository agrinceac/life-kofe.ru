<?if (!empty($pager)  &&  $pager->getTotalPages() > 1):?>
<div id="pagination" class="text-center">
    <ul class="pagination">

        <?if($pager->getFirstPage()):?>
        <li><a href="<?=$pager->getFirstPage()->getLink()?>">&laquo;</a></li>
        <?endif?>

        <?foreach ( $pager as $page):?>
        <?if($page->isCurrentPage()):?>
        <li class="active"><a><?=$page->getPage()?></a></li>
        <?else:?>
        <li><a href="<?=$page->getLink()?>"><?=$page->getPage()?></a><li></li>
        <?endif?>
        <?  endforeach;?>

        <?if($pager->getLastPage()):?>
        <li><a href="<?=$pager->getLastPage()->getLink()?>">&raquo;</a></li>
        <?endif?>

    </ul>
</div>
<?endif;?>