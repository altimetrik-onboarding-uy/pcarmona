({
    
    editRecord: function(component) {
        var editRecordEvent = $A.get("e.force:editRecord");
        editRecordEvent.setParams({
            "recordId": component.get("v.record.Id")
        });
        editRecordEvent.fire();
    }
    
    
})