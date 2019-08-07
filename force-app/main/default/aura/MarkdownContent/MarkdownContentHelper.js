({
    pollAutoSave : function(component, event, helper) {
        window.setInterval(
            $A.getCallback(function() {
                helper.editRecord(component, event ,helper);
            }), 3000
        );     
    },
    
    editRecord : function(component, event, helper) {
        var editAction = component.get("c.updatePost");
        editAction.setParams({
            "postId": component.get("v.recordId"),
            "newContent": component.get("v.myText")
        });
        editAction.setCallback(this, function(response) {
            var state = response.getState();
            if(state === "SUCCESS") {
                var result = response.getReturnValue();
            }
            else {
                alert("Error when trying to update content");
            }
        });
        $A.enqueueAction(editAction);
    },
    
    submit : function(component) {
        var submitAction = component.get("c.submitForReview");
        submitAction.setParams({
            "postId": component.get("v.recordId")
        });
        submitAction.setCallback(this, function(response) {
            var state = response.getState();
            if(state === "SUCCESS") {
                var result = response.getReturnValue();
                alert(result);
            }
            else {
                alert("Error when trying to submit for review");
            }
        });
        $A.enqueueAction(submitAction);
    },
    
    convertToMarkdown : function(rawText) {
        return marked(rawText);
    },
	
})