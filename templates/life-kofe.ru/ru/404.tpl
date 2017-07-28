<html>
<head>
    <title>Вы набрали неправильный адрес страницы</title>
    <meta charset="utf-8">

    <link rel="stylesheet" type="text/css" href="/css/<?=$this->getCurrentDomainAlias()?>/bootstrap/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="/css/<?=$this->getCurrentDomainAlias()?>/global.css">

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
    <script src="/js/pageHeightAdjuster.js"></script>
</head>

<?$this->includeTemplate('header')?>

    <link rel="stylesheet" href="/css/life-kofe.ru/pages/payment_and_delivery.css">

    <article class="container">
        <header>
            <h1>404</h1>
        </header>
        <section>
            <div class="row">
                <p class="col-md-10 col-md-offset-1 text-muted">
                    Такой страницы не существует.
                </p>
            </div>
        </section>
    </article>

<?$this->includeTemplate('footer')?>