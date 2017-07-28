<? include ('header.tpl'); ?>
			<tr>
				<td colspan="2" style="padding-left: 10px;">
					<h2 class="subject" style="width: 100%;text-align: center;color: #24667B;">Получен новый заказ с сайта <?=SEND_FROM?></h2>
					<p>
						Здравствуйте.
						<br /><br />
						С сайта <?=SEND_FROM?> был отправлен новый заказ.
						<br /><br />
						Данные заказа:
                        <?if($data['family']):?>
						<br />
						Фамилия: <strong><?=$data['family']?></strong>
                        <?endif;?>
						<br />
						Имя: <strong><?=$data['name']?></strong>
						<br />
						Телефон: <strong><?=$data['phone']?></strong>
                        <?if($data['email']):?>
						<br />
						Email: <strong><?=$data['email']?></strong>
                        <?endif;?>
                        <?if(isset($data['city']) && $data['city']):?>
                        <br />
                        Город: <strong><?=$data['city']?></strong>
                        <?endif;?>
                        <?if(isset($data['street']) && $data['street']):?>
                        <br />
                        Город: <strong><?=$data['street']?></strong>
                        <?endif;?>
                        <?if(isset($data['home']) && $data['home']):?>
                        <br />
                        Дом: <strong><?=$data['home']?></strong>
                        <?endif;?>
                        <?if(isset($data['flat']) && $data['flat']):?>
                        <br />
                        Квартира: <strong><?=$data['flat']?></strong>
                        <?endif;?>
						<br /><br />
						Содержание заказа:
						<br />
						<table width="100%" border="1" style="border-color: grey; border-spacing: 0px; text-align: center;">
							<tr style="background-color: #DAE2FE; color: #24667B;">
								<th colspan="2" class="first"><div>Название</div></th>
								<th><div>Количество</div></th>
								<th class="last"><div>Стоимость</div></th>
							</tr>
							<?foreach($shopcart as $good):?>
							<tr>
								<td><div class="image"><a href="<?=$_SERVER['HTTP_HOST'].$good->getPath()?>"><img src="http://<?= $_SERVER['HTTP_HOST'].$good->getFirstPrimaryImage()->getFocusImage('100x0')?>" alt="" /></a></div></td>
								<td>
									<p class="name"><a href="<?=$_SERVER['HTTP_HOST'].$good->getPath()?>"><?=$good->getName()?></a></p>
									<?if($good->getSubgoods() && $good->getSubgoods()->count()):?>
									<table>
										<tr>
											<td style="text-align: left; margin-left: 20px;">Подтовары:</td>
										</tr>
										<?$i=1; foreach($good->getSubgoods() as $subGood):?>
										<tr>
											<td style="text-align: left; margin-left: 20px;">
												<?=$i?>.
												<img src="<?=$_SERVER['HTTP_HOST'].$subGood->getGood()->getFirstPrimaryImage()->getUserImage('30x0')?>" alt="">
												<a href="<?=$_SERVER['HTTP_HOST'].$subGood->getGood()->getPath()?>"><?=$subGood->getGood()->getName()?></a>
											</td>
										</tr>
										<?$i++; endforeach?>
									</table>
									<?endif?>
								</td>
								<td><p><?=$good->getQuantity()?></p></td>
								<td><p class="price"><span><span><?=$good->getTotalPrice()?></span> руб </p></td>
							</tr>
							<?  endforeach;?>
							<tr class="itog">
								<td colspan="3"><p class="sum"><strong>ИТОГО:</strong></p></td>
								<td><p class="price"><strong><span><?=$shopcart->getTotalPrice()?></span> руб.</strong></p></td>
							</tr>
						</table>
					</p>
					<br />
					<p>
						Свяжитесь с клиентом в ближайшее время. Он ожидает вашего звонка.
					</p>
				</td>
			</tr>
<? include ('footerAdmin.tpl'); ?>