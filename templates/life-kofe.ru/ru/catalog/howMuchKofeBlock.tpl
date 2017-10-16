<section id="how-much-coffee-do-you-need" class="bg-cover bg-primary has-padding">
    <div class="container">
        <h4>Сколько кофе вам необходимо</h4>
        <p> </p>
        <form action="" method="POST" role="form">
            <ul class="flex-list list-unstyled">
                <li>
                    <div class="form-group">
                        <label>
                            <span class="text-info">Количество</span>
                            <br>сотрудников
                        </label>
                        <div class="input-group">
                            <input
                                type="number" class="form-control input-lg"
                                name="employeesCount" value="3" required="required"
                                min="1" max="100"
                            >
                            <span class="input-group-addon">сотр.</span>
                        </div>
                    </div>
                </li>
                <li>
                    <div class="form-group" data-toggle="buttons">
                        <label>
                            <span class="text-info">Сколько чашек</span>
                            <br> на 1 человека
                        </label>
                        <div class="radio btn-group radioCupsCount">
                            <label class="btn btn-primary active">
                                <input type="radio" name="cupsCount" value="2" checked="checked">
                                <span class="h4">2</span>
                                <br>
                                <span>чашки</span>
                            </label>
                            <label class="btn btn-primary">
                                <input type="radio" name="cupsCount" value="3">
                                <span class="h4">3</span>
                                <br>
                                <span>чашки</span>
                            </label>
                        </div>
                    </div>
                </li>
                <li>
                    <div class="form-group">
                        <label>
                            <span class="text-info">Какую кофемашину</span>
                            <br> хотите взять в аренду
                        </label>
                        <select class="form-control input-lg kofeMashineName" required="required">
                            <?if($objects->count()):?>
                            <?foreach($objects as $object):?>
                            <option value="<?=$object->id?>"><?=$object->getInfo()->getName()?></option>
                            <?endforeach;?>
                            <?endif?>
                        </select>
                    </div>
                </li>
                <li>
                    <div class="form-group">
                        <label>
                            <span class="text-info">Какое кофе</span>
                            <br> хотите заказать
                        </label>
                        <select name="coffeeType" class="form-control input-lg kofeName" required="required">
                            <?if($kofe->count()):?>
                                <?foreach($kofe as $kofeObject):?>
                                    <option value="<?=$kofeObject->id?>"><?=$kofeObject->getInfo()->getName()?></option>
                                <?endforeach;?>
                            <?endif?>
                        </select>
                    </div>
                </li>
                <li>
                    <div class="form-group">
                        <label>
                            <span class="text-info">Вам необходимо</span>
                            <br> кофе в месяц*
                        </label>
                        <div class="input-group">
                            <input
                                type="number" class="form-control input-lg" name="needCoffeeCountInMonth"
                                value="1" min="1" max="100"
                            >
                            <span class="input-group-addon">кг кофе</span>
                        </div>
                    </div>
                </li>
            </ul>
            <p class="text-center">
                <small>* Вы можете увеличить или уменьшить рекомендуемое количество кофе</small>
            </p>
            <p> </p>
            <div class="row">
                <div class="col-sm-3 h4">
                    <span>1 кг. ≈ </span><span class="text-info">125 чашек   <img src="/images/bg/pages/rental_of_coffee_machines_in_the_office/cup_of_coffee.svg" alt="Чашечка кофе" class="hidden-sm"></span>
                </div>
                <div class="col-sm-6 text-center actions">
                    <button type="button" class="btn btn-info makeOrderButton"
                        data-goodId="<?=$firstObject->id?>"
                        data-name="<?=$firstObject->getInfo()->getName()?>"
                    >Сделать заказ</button>
                </div>
            </div>
        </form>
    </div>
</section>