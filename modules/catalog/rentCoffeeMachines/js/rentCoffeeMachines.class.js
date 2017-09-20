var rentCoffeeMachines = function()
{
    this.errors = new errors({
        'form' : '.addCoffeeBlock',
        'submit' : '#addCoffeeMachine',
        'message' : '#message',
        'error' : '.hint',
        'showMessage' : true
    });

    this.actions = {
        'addCoffeeMachine' : '/admin/rentCoffeeMachines/ajaxAddCoffeeMachine/',
        'getCoffeeMachinesTable' : '/admin/rentCoffeeMachines/ajaxGetCoffeeMachinesTable/',
        'deleteCoffeeMachine' : '/admin/rentCoffeeMachines/ajaxDeleteCoffeeMachine/'
    };

    this.handler = new rentCoffeeMachinesHandler;

    this.addCoffeeMachine = function(button)
    {
        var that = this;
        var articleId = $(button).attr('data-mainGoodId');
        var data = {
            'rentPageId' : articleId,
            'catalogItemId' : $(that.handler.sources.coffeeMachineId).val()
        };
        $.ajax({
            before: that.handler.ajaxLoader.setLoader(that.handler.sources.addCoffeeMachineButton),
            url: that.actions.addCoffeeMachine,
            type: 'POST',
            dataType: 'json',
            data: data,
            success: function(data){
                that.handler.ajaxLoader.getElement();
                if($.isNumeric(data)){
                    that.errors.reset();
                    that.resetCoffeeMachinesTable(articleId);
                }
                else{
                    that.errors.show(data);
                }
            }
        });
    }

    this.resetCoffeeMachinesTable = function(articleId)
    {
        var that = this;
        var data = {
            'rentPageId' : articleId
        };

        $.ajax({
            url: that.actions.getCoffeeMachinesTable,
            type: 'POST',
            dataType: 'html',
            data: data,
            success: function(data){
                $(that.handler.sources.coffeeMachinesBlock).replaceWith(data);
                that.handler.initCoffeeAutosuggest();
            }
        });
    }

    this.deleteCoffeeMachine = function(deleteButton)
    {
        if (confirm('Удалить подтовар?')){
            var that = this;
            var data ={
                'catalogItemId' : $(deleteButton).attr('data-id')
            };

            $.ajax({
                before: that.handler.ajaxLoader.setLoader(deleteButton),
                url: that.actions.deleteCoffeeMachine,
                type: 'POST',
                dataType: 'json',
                data: data,
                success: function(data){
                    that.handler.ajaxLoader.getElement();
                    if($.isNumeric(data)){
                        that.errors.reset();
                        that.resetCoffeeMachinesTable($(that.handler.sources.addCoffeeMachineButton).attr('data-mainGoodId'));
                    }
                    else{
                        that.errors.show(data);
                    }
                }
            });
        }
    };
};