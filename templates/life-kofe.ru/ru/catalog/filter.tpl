<!-- Filters -->
<section id="filter" class="filter bg-warning">
    <div class="container">
        <form action="/search/" method="GET" role="form" class="row">
            <div class="col-sm-3 hidden-sm">
                <label class="form-name">Быстрый поиск</label>
            </div>
            <div class="col-md-6 col-sm-8">
                <ul class="row list-unstyled">
                    <?$fabricators = $this->getController('Catalog')->getFabricators()?>
                    <?if($fabricators->count()):?>
                    <li class="col-sm-4">
                        <select name="fabricator" class="form-control input">
                            <option value="">Производитель:</option>
                            <?foreach($fabricators as $fabricator):?>
                            <option value="<?=$fabricator->alias?>" <?=$fabricator->alias==$this->getGet()['fabricator'] ? 'selected' : ''?>><?=$fabricator->getName()?></option>
                            <?endforeach?>
                        </select>
                    </li>
                    <?endif?>
                    <!--                        <li class="col-sm-3">-->
                    <!--                            <select name="" id="model" class="form-control" required="required">-->
                    <!--                                <option value="">Модель</option>-->
                    <!--                            </select>-->
                    <!--                        </li>-->
                    <?$categories = $this->getController('Catalog')->getMainCategories()?>
                    <?if($categories->count()):?>
                    <li class="col-sm-4">
                        <select name="category" class="form-control">
                            <option value="">Группа товаров:</option>
                            <?foreach($categories as $categoryObject):?>
                            <option value="<?=$categoryObject->alias?>"><?=$categoryObject->getName()?></option>
                                <?if($categoryObject->getChildren()): foreach($categoryObject->getChildren() as $children):?>
                                    <option value="<?=$children->alias?>" <?=($children->alias==$this->getGet()['category']) ? 'selected' : ''; ?>>&nbsp;&nbsp;|-&nbsp;<?=$children->name?></option>
                                    <?if ($children->getChildren()): foreach($children->getChildren() as $children2):?>
                                        <option value="<?=$children2->alias?>" <?=($children2->alias==$this->getGet()['category']) ? 'selected' : ''; ?>>&nbsp;&nbsp;&nbsp;&nbsp;|-&nbsp;<?=$children2->name?></option>
                                    <?endforeach; endif;?>
                                <?endforeach; endif;?>
                            <?endforeach?>
                        </select>
                    </li>
                    <?endif?>
                    <li class="col-sm-2">
                        <button type="submit" class="btn btn-primary btn-block">Найти</button>
                    </li>
                </ul>
            </div>
            <div class="col-md-3 col-sm-4 filter-serach-box">
                <div class="form-group has-feedback">
                    <script src="/js/searchBySpareName.js"></script>
                    <div role="form" class="row">
                        <input type="text" id="spareName" class="form-control filter-search"
                               placeholder="Введите артикули или название"
                               value="<?= $this->getGet()['spareName'] ? $this->getGet()['spareName'] : ''?>"
                        >
                        <span id="searchBySpareNameSubmit" class="glyphicon glyphicon-search form-control-feedback" aria-hidden="true"></span>
                        <span id="inputSuccess5Status" class="sr-only">(success)</span>
                    </div>
                </div>
            </div>
        </form>
    </div>
</section>
<!-- /Filters -->