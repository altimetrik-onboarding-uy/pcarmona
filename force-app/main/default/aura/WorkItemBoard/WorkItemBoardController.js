({
    doInit : function(component, event, helper) {
        var action = component.get("c.retrieveWIData"); //component.get("c.loadWIStatusColumns");
        
        action.setCallback(this, function(response) {
            var state = response.getState();
            
            if(state === "SUCCESS") {
                var result = response.getReturnValue();
                console.log(result.wItems);
                component.set("v.columns", result.statusColumns);
                component.set("v.rows", result.wItems);
            }
            else {
                alert("error when retrieving data");
            }
        });
        
        $A.enqueueAction(action);
    }
    
})