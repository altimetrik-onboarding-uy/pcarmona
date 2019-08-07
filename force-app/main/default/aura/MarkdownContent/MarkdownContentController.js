({
    init: function(component, event, helper) {
        helper.pollAutoSave(component, event, helper);
        window.addEventListener('keydown', function(e){
            if(e.ctrlKey && String.fromCharCode(e.which).toLowerCase() === 'b') {
                var text = component.get('v.myText');
                text = text != null ? text + '****' : '****';
                component.set('v.myText', text);
            }
            if(e.ctrlKey && String.fromCharCode(e.which).toLowerCase() === 'i') {
                var text = component.get('v.myText');
                text = text != null ? text + '**' : '**';
                component.set('v.myText', text);
            }
            if(e.ctrlKey && String.fromCharCode(e.which).toLowerCase() === 'l') {
                var text = component.get('v.myText');
                text = text != null ? text + '``' : '``';
                component.set('v.myText', text);
            }
            if(e.ctrlKey && e.shiftKey && String.fromCharCode(e.which).toLowerCase() === 'b') {
                var text = component.get('v.myText');
                text = text != null ? text + '```' : '```';
                component.set('v.myText', text);
            }
        });
    },
    
    submitReview: function(component, event, helper) {
        helper.submit(component);
    },
    
    convertText : function(component, event, helper) {
        component.set('v.markdownText', helper.convertToMarkdown(component.get('v.myText')));
    }
})