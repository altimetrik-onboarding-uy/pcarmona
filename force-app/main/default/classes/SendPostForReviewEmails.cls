public class SendPostForReviewEmails implements Schedulable {
    
    public void execute(SchedulableContext SC) {
        
        sendPostsEmails();
        
    }
    
    @TestVisible
    public Id batchId;
    
    public void sendPostsEmails() {
        SendPostForReviewEmailsBatch postsBatchJob = new SendPostForReviewEmailsBatch(); 
        batchId = Database.executeBatch(postsBatchJob);
    }
    
}