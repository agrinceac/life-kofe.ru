<?include(TEMPLATES_ADMIN.'top.tpl');?>
		<script type="text/javascript" src="/admin/js/base/system/sorting.js"></script>
		<script type="text/javascript" src="/admin/js/base/system/groupActions.js"></script>
		<div class="main single">
			<div class="max_width">
				<div class="action_buts">
					<a href="/admin/clients/client/"><img src="/admin/images/buttons/add.png" alt="" /> Создать</a>
					<a class="filters pointer"><img src="/admin/images/buttons/search.png" alt="" /> Фильтрация</a>
				</div>
				<p class="speedbar"><a href="/admin/">Главная</a> <span>></span>
					Клиенты
				</p>
				<div class="clear"></div>
				<!-- Start: Filetrs Block -->
				<div id="filter-form"  style="<?=(isset($_REQUEST['form_in_use'])?'display:block;':'display:none;')?>">
					<form id="search" action="" method="get">
						<input type="hidden" name="form_in_use" value="true" />
						<table>
							<tr>
								<td class="right">ФИО:</td>
								<td><input class="filterInput" type="text" name="allName" value="<?=$this->getGET()['allName']?>" /></td>
								<td class="right">Организация:</td>
								<td><input class="filterInput" type="text" name="company" value="<?=$this->getGET()['company']?>" /></td>
								<td class="right">Статус:</td>
								<td><select class="filterInput" name="statusId">
										<option value="">&nbsp;</option>
										<?php foreach ($clients->getStatuses() as $status):?>
										<option value="<?=$status->id?>" <?=($this->getGET()['statusId']==$status->id)?'selected':''?>><?=$status->name?></option>
										<?php endforeach;?>
									</select>
								</td>
								<td class="right">ID:</td>
								<td><input class="filterInput" type="text" name="id" value="<?=$this->getGET()['id']?>" /></td>

							</tr>
							<tr>
								<td class="right">Заметки:</td>
								<td><textarea style="width: 171px" name="description" cols="60"><?=$this->getGET()['description']?></textarea></td>
								<td class="right">Клиент:</td>
								<td>
									<script type="text/javascript" src="/modules/orders/js/autosuggest/autosuggestListPage.js"></script>
									<script type="text/javascript" src="/modules/orders/js/autosuggest/jquery.autoSuggest.js"></script>
									<link rel="stylesheet" type="text/css" href="/modules/orders/css/autoSuggest.css" />
									<input type="text" class="inputClient">
									<input type="hidden" class="getClientId" value="<?= $this->getGet()['clientId'] ? $this->getGet()['clientId'] : ''?>">
									<input type="hidden" class="getClientName" value="<?=   $this->getGet()['clientId']   ?   $this->getController('Orders')->getClientById($this->getGet()['clientId'])->getAllName().' - '.$this->getController('Orders')->getClientById($this->getGet()['clientId'])->city.' ('.$this->getController('Orders')->getClientById($this->getGet()['clientId'])->getLogin().')'   :   ''?>">
								</td>
								<td colspan="4">
									<div class="action_buts">
										<a class="pointer" onclick="$('#search').submit()"><img src="/admin/images/buttons/search.png" /> Поиск</a>
										<a class="resetFilters" href="/admin/<?=$_REQUEST['controller']?>/"><img src="/admin/images/buttons/delete.png" /> Сбросить фильтры</a>
									</div>
								</td>
							<tr>
						</table>
					</form>
				</div>
				<!-- End: Filters Block -->
				<div class="table_edit">
				    <? //echo count($clients);die; ?>
					<?if(count($clients) == 0): echo 'No Data'; else:?>
					<table  id="objects-tbl" data-sortUrlAction="/admin/clients/changePriority/?" width="100%">
						<tr>
							<th colspan="2" class="first">id</th>
							<th>Клиент (организация)</th>
							<th>Город</th>
							<th>Статус</th>
							<th class="last" colspan="4">Приоритет</th>
						</tr>
						<?foreach ($clients as $client):?>
							<tr id="id<?=$client->id?>" class="dblclick" data-url="/admin/clients/client/<?= $client->id?>" data-id="<?= $client->id?>" data-priority="<?= $client->priority?>">
								<td><input type="checkbox"  class="groupElements" /></td>
								<td><?=$client->id?></td>
								<td>
									<p class="name">
										<?=$client->surname?> <?=$client->name?> <?=$client->patronimic?>
										<?if($client->company):?>
										(<?=$client->company?>)
										<?endif?>
									</p>
								</td>
								<td><?=$client->city?></td>
								<td><p class="status" style="color:<?=$client->getStatus()->color?>"><?=$client->getStatus()->name?></p></td>
								<td class="td_bord sortHandle header"><?= $client->priority?></td>
								<td><a href="/admin/clients/client/<?=$client->id?>" class="pen"></a></td>
								<td><a data-confirm= "Remove the item?" data-action="/admin/clients/remove/<?=$client->id?>/"
								       data-callback="postRemoveFromDetails" data-post-action="/admin/clients/" class="del button confirm pointer"></a></td>
							</tr>
						<?endforeach?>
					</table>
					<?endif?>
				</div>

				<?$this->printPager($pager, 'pager')?>

				<div class="action_edit">
					<form id="groupArray" action="/admin/clients/groupActions/" class="groupArray" method="post" data-callback="reloadPage">
						<table>
							<tr>
								<td><a href="javascript:" class="check_all"><span>Выделить все</span></a></td>
								<td>
									<select class="groupActionSelect">
										<option value="">- С выделенными -</option>
										<option value="statusId">Назначить статус</option>
										<option value="groupRemove">Удалить</option>
									</select>
								</td>
							</tr>
							<tr class="groupAction statusId">
								<td class="first"><strong></strong></td>
								<td>
									<select id="statusId" name="categoryId">
										<option value="">- Статусы -</option>
										<?php foreach ($clients->getStatuses() as $status):?>
										<option value="<?=$status->id?>" <?=($this->getGET()['statusId']==$status->id)?'selected':''?>><?=$status->name?></option>
										<?php endforeach;?>
									</select>
								<td>
									<button  class="ok groupArraySubmit" name="actionButton">
										<span>ок</span>
									</button>
								</td>
							</tr>
							<tr class="groupAction groupRemove" name="removeButton">
								<td class="first"></td>
								<td>
									<button class="remove button confirm active" data-confirm="Удалить объекты?" data-action="/admin/clients/groupRemove/" data-data="input[name*=group]" data-callback="reloadPage">ок</button>
								</td>
							</tr>
						</table>
					</form>
				</div>
			</div>
		</div><!--main-->
		<div class="vote"></div>
	</div><!--root-->
<?include(TEMPLATES_ADMIN.'footer.tpl');?>