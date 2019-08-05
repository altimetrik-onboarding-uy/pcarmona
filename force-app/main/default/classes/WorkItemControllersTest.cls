@isTest
public class WorkItemControllersTest {
    
    @testSetup
    static void testSetup() {
        
        List<Work_Item__c> mockedWItems = new List<Work_Item__C>();
        List<Contact> mockedTMembers = new List<Contact>();
        
        for(Integer i=0;i<5;i++) {
            mockedTMembers.add(new Contact(
                FirstName = 'Test',
                LastName = 'Contact ' + i,
                Email = 'pcarmona@altimetrik.com'
            ));
        }
        
        insert mockedTMembers;
        
        for(Integer i=0;i<16;i++) {
            if(i<9) {
                mockedWItems.add(new Work_Item__C(
                    Name = 'Test WI ' + i,
                    Assignee__c = i < 4 ? mockedTMembers.get(0).Id : mockedTMembers.get(1).Id,
                    Description__c = 'Test Desc ' + i,
                    Difficulty_Level__c = i < 4 ? '8' : '5',
                    RecordTypeId = '0123i000000LZ9tAAG',
                    Start_Date__c = i < 4 ? date.today().addDays(-40) : date.today().addDays(-20),
                    Estimated_End_date__c = i < 4 ? date.today().addDays(-2) : date.today().addDays(2),
                    Status__c = i < 1 ? 'Done' : 'New'
                ));
            }
            else {
                mockedWItems.add(new Work_Item__C(
                    Name = 'Test WI ' + i,
                    Assignee__c = i < 12 ? mockedTMembers.get(2).Id : mockedTMembers.get(3).Id,
                    Description__c = 'Test Desc ' + i,
                    Difficulty_Level__c = i < 12 ? '3' : '1',
                    RecordTypeId = i < 12 ? '0123i000000LZ9yAAG' : '0123i000000LZA3AAO',
                    Start_Date__c = i < 4 ? date.today().addDays(-20) : date.today().addDays(-10),
                    Estimated_End_date__c = i < 13 ? date.today().addDays(-4) : date.today().addDays(4),
                    Status__c = i == 11 ? 'Done' : 'New'
                ));
            }
            
        }
        
        insert mockedWItems;
        
    }
    
    @isTest
    static void workItemBoardControllerTest() {
        
        test.startTest();
        WorkItemBoardController.dataResult dResult = new WorkItemBoardController.dataResult();
        dResult = WorkItemBoardController.retrieveWIData();
        test.stopTest();
        
        system.assertEquals(Work_Item__c.Status__c.getDescribe().getPicklistValues().size(), dResult.statusColumns.size(), 'The number of columns should match Status available options number.');
        system.assertEquals(12, dResult.wItems.size(), 'Only work items of the last 30 days should be retrieved.');
        
    }
    
    @isTest
    static void WIListForEmailControllerTest() {
        
        test.startTest();
        WIListForEmailController controller = new WIListForEmailController();
        test.stopTest();
        
        system.assertEquals(6, controller.wItems.size(), 'Only overdue work items should be retrieved.');
        system.assertEquals(6, controller.getwItems().size(), 'Only overdue work items should be retrieved.');
        
    }
    
    @isTest
    static void ContactWIListControllerTest() {
        
        Contact testContact = [SELECT Id FROM CONTACT WHERE FirstName = 'Test' AND LastName = 'Contact 1'];
        
        test.startTest();
        ContactWIListController controller = new ContactWIListController();
        List<Work_Item__c> wItemsForContact = ContactWIListController.getWIs(testContact.Id);
        test.stopTest();
        
        system.assertEquals(5, wItemsForContact.size(), 'Only work items for selected contact should be retrieved.');
    }
    
    @isTest
    static void SendOverdueEmailsTest() {
        
        test.startTest();
        SendOverdueEmails contr = new SendOverdueEmails();
        contr.sendOverdueWIEmail();
        Integer invocations = Limits.getEmailInvocations();
        System.assertEquals(1, invocations, 'The email has not been sent');
    }

}