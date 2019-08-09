@isTest
public class PostControllersTest {
    
    @testSetup
    static void testSetup() {
        
        User myUser = [select id, Name, Alias, Email, EmailEncodingKey, LastName, LanguageLocaleKey, LocaleSidKey, ProfileId, TimeZoneSidKey, UserName 
                       from user 
                       where name = 'pablo carmona'];
        
        myUser.IsTesting__c = true;
        
        update myUser;
        
        System.runAs(myUser) {
            
            Profile mockUserProfile = [SELECT Id FROM Profile WHERE Name='System Administrator'];
            
            List<User> mockedUsers = new List<User>();
            
            for(Integer x=0;x<199;x++) {
                
                mockedUsers.add( new User(Alias = 'tUser' + x, Email='dennisnedry@jpark.com',
                                          EmailEncodingKey='UTF-8', LastName='testUser' + x, LanguageLocaleKey='en_US',
                                          LocaleSidKey='en_US', ProfileId = mockUserProfile.Id,
                                          TimeZoneSidKey='America/Los_Angeles', UserName='tUser' + x + '@somedomain.com'
                                         ));
                
            }
            
            insert mockedUsers;
            
            List<Contact> mockedAuthors = new List<Contact>();
            
            for(Integer x=0;x<199;x++) {
                mockedAuthors.add(new Contact(
                    FirstName = 'Test ' + x,
                    LastName = 'Contact ' + x,
                    Email = 'somedude' + x + '@somedomain.com',
                    OwnerId = mockedUsers[x].Id
                ));
            }
            
            insert mockedAuthors;
            
            Post__c singlePost =  new Post__c(Name = 'Single Test Post',
                                              Content__c = 'Single Test Content ',
                                              Tags__c = 'test, post ',
                                              Status__c = 'Draft',
                                              Approved__c = false,
                                              Author_Writer__c = mockedAuthors[0].Id
                                             );
            
            insert singlepost;
            
            List<Post__c> mockedPosts = new List<Post__c>();
            
            for(Integer x=0;x<199;x++) {
                
                mockedPosts.add(new Post__c(
                    Name = 'Test Post ' + x,
                    Content__c = 'Test Content '+ x,
                    Tags__c = 'test, post ',
                    Status__c = 'Under Review',
                    Approved__c = false,
                    Author_Writer__c = mockedAuthors[x].Id
                ));
            }
            
            insert mockedPosts;
            
        }
        
    }
    
    @isTest
    static void SendPostForReviewEmailsTest() {
        
        test.startTest();
        SendPostForReviewEmails contr = new SendPostForReviewEmails();
        contr.sendPostsEmails();
        Id myBatchId = contr.batchId;
        test.stopTest();
        
        AsyncApexJob job2 = [SELECT Id, Status, NumberOfErrors, 
                            JobItemsProcessed,
                            TotalJobItems, CreatedBy.Email
                            FROM AsyncApexJob
                            WHERE Id = : myBatchId];
        
        System.assertEquals(1, job2.JobItemsProcessed, 'Emails not sent');
        System.assertEquals(1, job2.TotalJobItems, 'Emails not sent');
        System.assertEquals('Completed', job2.Status, 'Job not completed');
        System.assertEquals(0, job2.NumberOfErrors, 'Errors encountered in the job');
        
    }
    
    
    @isTest
    static void MarkdownContentControllerTest() {
        
        Post__c post = [SELECT Id FROM Post__c WHERE name = 'Single Test Post' LIMIT 1];
        string content = 'some new content to test';
        test.startTest();
        MarkdownContentController.updatePost(post.Id, content);
        MarkdownContentController.submitForReview(post.Id);
        test.stopTest();
        
        Post__c updPost = [SELECT Id, Content__c, Status__c FROM Post__c WHERE name = 'Single Test Post' LIMIT 1];
        
        System.assertEquals(updPost.Content__c, content,'Post content was not updated');
        System.assertEquals(updPost.Status__c, 'Under Review','Post status was not updated');
    }
    
}