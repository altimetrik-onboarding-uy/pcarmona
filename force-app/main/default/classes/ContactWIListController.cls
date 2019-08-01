public class ContactWIListController {
    
    @AuraEnabled
    public static List<Work_Item__c> getWIs(Id contactId) {
        return new List<Work_Item__c>([SELECT Id, Name, Difficulty_Level__c, RecordType.Name, Status__c From Work_Item__c where Assignee__c = : contactId]);
    }

}