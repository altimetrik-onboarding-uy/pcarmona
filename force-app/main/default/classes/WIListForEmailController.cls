public class WIListForEmailController {
    private final List<Work_Item__C> wItems;
    
    public WIListForEmailController() {
        
        wItems = [SELECT Id, Name, Difficulty_Level__c, RecordType.Name, Status__c, Estimated_End_date__c From Work_Item__c where Estimated_End_date__c < : Date.today() AND Status__c != 'Done'];
    }
    
    public List<Work_Item__C> getwItems() {
        return wItems;
    }

}