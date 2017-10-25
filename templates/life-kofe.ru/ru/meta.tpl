<!DOCTYPE html>
<html lang="ru">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>

        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
		<link rel="icon" type="image/png" href="/favicon.ico" />
		<link rel="shortcut icon" type="image/png" href="/favicon.ico" />
		<title><?=$this->getMetaTitle();?></title>
		<meta name="description" content="<?=$this->getMetaDescription();?>" />
		<meta name="keywords" content="<?=$this->getMetaKeywords();?>" />

        <?if(isset($_GET['page'])  &&  !empty($_GET['page'])):?>
        <link rel="canonical" href="http://<?=$_SERVER['HTTP_HOST'].\core\utils\Utils::ragp($_SERVER['REQUEST_URI'])?>" />
        <?endif?>

        <link rel="stylesheet" type="text/css" href="/css/<?=$this->getCurrentDomainAlias()?>/bootstrap/bootstrap.min.css">
		<?
		$this->getController('imploder')
			->css()
            ->add('global.css', '/css/'.$this->getCurrentDomainAlias().'/')
            ->add('homePageStyleOverrides.css', '/css/'.$this->getCurrentDomainAlias().'/')
//			->add('jquery-ui-1.10.1.custom.min.css','/js/extensions/ui/')
			->add('errors.css', '/admin/js/base/actions/styles/')
//			->add('loaderBlock.css', '/admin/js/base/actions/styles/')
			->printf('compact');
		?>

		<script type="text/javascript">
			var date_format = '<?=DATE_FORMAT?>';
			var dir_https   = '<?=DIR_HTTPS?>';
			var dir_http    = '<?=DIR_HTTP?>';
			var part        = '<?//=($this->isPart($this->getPart())) ? $this->getPart() : '';?>';
			var controller  = '<?=$this->getMainController()?>';
			var action      = '<?=$this->action?>';
		</script>


<!--        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>-->


		<?
		$js = $this->getController('imploder')->js();
		$js
            ->add('jquery.min.js', 'https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/')
//            ->add('jquery.js')
//			->add('jquery.deparam.js', '/admin/js/jquery/extensions/')
//			->add('jquery.htmlFromServer.js', '/admin/js/jquery/extensions/')
			->add('jquery.autoScroll-1.0.js', '/admin/js/jquery/extensions/')
//			->add('loaderBlock.class.js', '/admin/js/base/actions/')
//			->add('jquery-ui-1.10.1.custom.min.js','/js/extensions/ui/')
			->add('ajaxLoader.class.js')
            ->add('textareaIncluder.js', '/js/')
			->add('loaderLight.class.js', '/admin/js/base/actions/')
			->add('errors.class.js','/admin/js/base/actions/')
			->add('error.class.js','/admin/js/base/actions/')
			->add('form.class.js','/admin/js/base/actions/')
//			->add('buttons.class.js','/admin/js/base/actions/')
//			->add('jquery.inputmask.js','/admin/js/jquery/extensions/')
			->add('loader.class.js','/admin/js/base/actions/')
			->add('shopcartHandler.js', '/js/shopcart/')
			->add('shopcart.class.js', '/js/shopcart/')
//            ->add('catalog.js', '/js/catalog/')
            ->add('browserMsieAdapter.js', '/js/')
            ->add('pageHeightAdjuster.js', '/js/')
			->tagsPrint();
		?>

        <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
        <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
        <![endif]-->

	</head>

<?if($this->isDeveloperDomain()):?>
<div style="position: absolute;margin: 60px 0px 0px 0px;background: red;float: left;">ТЕСТОВЫЙ ДОМЕН</div>
<? endif; ?>