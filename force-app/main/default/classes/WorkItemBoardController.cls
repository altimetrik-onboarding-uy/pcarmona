public class WorkItemBoardController {
    
    @AuraEnabled
    public static dataResult retrieveWIData() {
        dataResult result = new dataResult();
        result.statusColumns = loadWIStatusColumns();
        result.wItems = getWorkItems();
        return result;
    }
    
    public class dataResult {
        
        @AuraEnabled
        public List<String> statusColumns {get; set;}
        
        @AuraEnabled
        public List<Work_Item__c> wItems {get; set;}
         
    }
    
    @AuraEnabled
    public static List<String> loadWIStatusColumns() {
        
        List<String> statusPicklistValues = new List<String>();
        
        Schema.DescribeFieldResult field = Work_Item__c.Status__c.getDescribe();
        List<Schema.PicklistEntry> entries = field.getPicklistValues();
        for(Schema.PicklistEntry entry : entries) {
            statusPicklistValues.add(entry.getLabel());
        }
        return statusPicklistValues;
    }
    
    @AuraEnabled
    public static List<Work_Item__c> getWorkItems() {
        Date beginDate = Date.today().addDays(-30);
        List<Work_Item__c> wItems = [SELECT Id, Name, Difficulty_Level__c, RecordType.Name, Status__c From Work_Item__c where Start_Date__c >= :beginDate];
        return wItems;
    }

}