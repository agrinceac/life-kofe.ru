$(function(){
    (new rentCoffeeMachinesHandler())
        .clickAddACoffeeMachineButton()
        .clickDeleteAdditionalGoodButton()
        .initCoffeeAutosuggest();
});

var rentCoffeeMachinesHandler = function()
{
    this.sources = {
        'addCoffeeMachineButton' : '#addCoffeeMachine',
        'coffeeMachineId' : 'input[name=inputCoffeeMachineId]',
        'coffeeMachinesBlock' : '.coffeeMachinesTable',
        'deleteCoffeeMachineButton' : '.deleteCoffeeMachine'
    };

    this.ajaxLoader = new ajaxLoader();

    this.clickAddACoffeeMachineButton = function()
    {
        var that = this;
        $(that.sources.addCoffeeMachineButton).live('click',function(){
            (new rentCoffeeMachines).addCoffeeMachine(this);
        });
        return this;
    };

    this.clickDeleteAdditionalGoodButton = function()
    {
        var that = this;
        $(that.sources.deleteCoffeeMachineButton).live('click',function(){
            (new rentCoffeeMachines).deleteCoffeeMachine(this);
        });
        return this;
    };

    this.initCoffeeAutosuggest = function()
    {
        $('.inputCoffeeMachineId').autoSuggest('/admin/orderGoods/ajaxGetAutosuggestGoodsById/', {
            selectedItemProp: "name",
            searchObjProps: "name",
            targetInputName: 'inputCoffeeMachineId',
            secondItemAtribute: 'code',
            thirdItemAtribute: 'price',
            fifthItemAtribute: 'availability'
        });
        return this;
    }
};