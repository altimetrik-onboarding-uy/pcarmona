global class SendPostForReviewEmailsBatch implements Database.Batchable<sObject>, Database.Stateful {
    
    @TestVisible
    global Integer emailsSent = 0;
    
    global List<Id> managers = new List<Id>();
    
    global Database.QueryLocator start(Database.BatchableContext bc) {
        system.debug('reached batch');
        return Database.getQueryLocator('SELECT Id, Author_Writer__c, Author_Writer__r.OwnerId FROM Post__c WHERE Status__c = \'Under Review\'');
    }
                                        
    global void execute(Database.BatchableContext bc, List<Post__c> scope) {
        system.debug('reached execute with: ' + scope.size());
        for(Post__c pendingPost : scope) {
            if(!managers.contains(pendingPost.Author_Writer__r.OwnerId)) {
                managers.add(pendingPost.Author_Writer__r.OwnerId);
            }
        }
        system.debug('authors with owner: ' + managers.size());
        List<Messaging.Email> emailMessages = new List<Messaging.Email>();
        
        For(Id manager : managers) {
            
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
            mail.setTargetObjectId(manager);
            mail.setTemplateId('00X3i000000h0b9EAA');
            mail.setTreatTargetObjectAsRecipient(true);
            mail.setSaveAsActivity(false);
            
            emailMessages.add(mail);
        }
        system.debug('emails sent: ' + emailMessages.size());
        emailsSent = emailMessages.size();
        Messaging.sendEmail(emailMessages);
        
    }
    
    global void finish(Database.BatchableContext bc) {
        
        AsyncApexJob job = [SELECT Id, Status, NumberOfErrors, 
            JobItemsProcessed,
            TotalJobItems, CreatedBy.Email
            FROM AsyncApexJob
            WHERE Id = :bc.getJobId()];
        
        System.debug('Emails sent: ' + emailsSent + ' Job: ' + job);
        
    }

}