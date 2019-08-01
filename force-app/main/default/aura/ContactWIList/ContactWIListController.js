({
	doInit : function(component, event, helper) {
        var rId = component.get("v.recordId"); //'0033i000001l4NpAAI';
        console.log(rId);
		var action = component.get("c.getWIs");
        action.setParams({ contactId : rId });
        
        action.setCallback(this, function(response) {
            var state = response.getState();
            
            if(state === "SUCCESS") {
                var result = response.getReturnValue();
                component.set("v.rows", result);
                
            }
            else {
                alert("error when retrieving data");
            }
        });
        
        $A.enqueueAction(action);
	}
})