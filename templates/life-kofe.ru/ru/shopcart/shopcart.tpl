<?$this->includeTemplate('meta')?>
<?$this->includeTemplate('header')?>

<div class="container">

    <link rel="stylesheet" href="/css/<?=$this->getCurrentDomainAlias()?>/pages/basket.css">

    <header class="has-padding">
        <h1>Корзина</h1>
    </header>

    <?include('goodsTable.tpl')?>

</div>

<?$this->includeTemplate('footer')?>