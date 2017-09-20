<div class="coffeeMachinesTable">
    <p class="title">Список кофе-машин:</p>
    <?if ($coffeeMachines->count()):?>
    <table class="goodsList">
        <tr class="top">
            <td>&nbsp;#&nbsp;</td>
            <td class="borderLeft">Подтовар</td>
            <td class="borderLeft"><img src="/admin/images/bg/trash.png" alt="Удалить" /></td>
        </tr>
        <? $i=1; foreach($coffeeMachines as $coffeeMachine):?>
        <tr class="line">
            <td class="center"><?=$i?></td>
            <td>
                <a href="<?=$coffeeMachine->getGood()->getAdminUrl()?>" target="blank">
                    <?=$coffeeMachine->getGood()->getName()?> (<?=$coffeeMachine->getGood()->getCode()?>)
                </a>
            </td>
            <td  class="center">
                <div><a class="pointer delete deleteCoffeeMachine" data-id="<?=$coffeeMachine->id?>"  title="Удалить подтовар"></a></div>
            </td>
        </tr>
        <? $i++; endforeach?>
    </table>
    <?else:?>
    <i>Не добавлено ни одного товара.</i>
    <? endif;?>
    <br /><br />
    <p class="title">Добавить дополнительные товары:</p>
    <div class="addCoffeeBlock">
        <table width="100%">
            <tr>
                <td class="first">Дополнительный товар:</td>
                <td>
                    <input type="text" class="inputCoffeeMachineId">
                    <img class="inputGoodLoader" style="margin: 5px 0px -10px 140px; display: none;" src="/images/loaders/loading-small.gif" />
                </td>
            </tr>
            <tr>
                <td class="first"></td>
                <td><a id="addCoffeeMachine" class="add-bottom pointer" data-mainGoodId="<?=$article->id?>" style="margin: 0px 0px 0px -20px; ">Добавить</a></td>
            </tr>
        </table>
    </div>
</div>