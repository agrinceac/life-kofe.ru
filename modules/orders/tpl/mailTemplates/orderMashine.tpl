<? include ('headerOneClick.tpl'); ?>
	<table>
		<tr>
			<td>
                <p><strong><?=$data['orderType']?></strong></p>
				<p>Клиент заказал аренду кофемашины.</p>
                <br><br>
                <strong>Данные:</strong>
                <br>
                Имя: <?=$data['name']?>
                <br>
                Телефон: <?=$data['phone']?>
                <br>
                Email: <?=$data['email']?>
                <br>
                Адрес: <?=$data['address']?>

                <?if(isset($data['qnt']) && $data['qnt']):?>
                <br>
                Количество машин: <?=$data['qnt']?>
                <?endif?>

                <?if(isset($data['days']) && $data['days']):?>
                <br>
                Количество дней: <?=$data['days']?>
                <?endif?>

                <?if(isset($data['details']) && $data['details']):?>
                <br>
                Дополнительные сведения: <?=$data['details']?>
                <?endif?>

                <br>
                Кофемашина:
                <a href="http://<?= $_SERVER['HTTP_HOST']?><?=$good->getAdminPath()?>" target="_blank">
                    <?=$good->getInfo()->getName()?>
                    &nbsp;&nbsp;&nbsp;
                    <img border="0" src="<?=$this->setImageHere($good->getFirstPrimaryImage()->getPath())?>" height="100" width="100">
                </a>
			</td>
			<td valign="top">
				<?if($managers):?>
				Менеджеры :&nbsp;&nbsp;&nbsp;&nbsp;
				<?foreach($managers as $manager):?>
				<?=$manager?>&nbsp;&nbsp;&nbsp;&nbsp;
				<?endforeach?>
				<br /><br />
				<?endif?>
			</td>
		</tr>
	</table>
<? include ('footerAdmin.tpl'); ?>