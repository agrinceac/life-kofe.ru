<? include ('headerOneClick.tpl'); ?>
	<table>
		<tr>
			<td>
				<p>Клиент просит подобрать запчасть.</p>
                <br><br>
                <strong>Данные:</strong>
                <br>
                Название: <?=$data['sparePartName']?>
                <br>
                Марка: <?=$data['brand']?>
                <br>
                Имя клиента: <?=$data['customerName']?>
                <br>
                Телефон клиента: <?=$data['customerPhone']?>
                <?if(isset($data['comment']) && $data['comment']):?>
                <br>
                Телефон клиента: <?=$data['comment']?>
                <?endif?>
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