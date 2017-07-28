<? include ('headerOneClick.tpl'); ?>
	<table>
		<tr>
			<td>
				<p>Клиент задал вопрос со страницы Контакты.</p>
                <br><br>
                <strong>Данные:</strong>
                <br>
                Имя: <?=$data['name']?>
                <br>
                Телефон: <?=$data['phone']?>
                <br>
                Сообщение: <?=$data['message']?>
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