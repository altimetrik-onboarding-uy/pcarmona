public class PostsForReviewListForEmailsControler {
    
    public Id managerId {get;set;}
    
    @testVisible
    private final List<Post__c> postsForReview;
    
    public List<Post__c> getPostsForReview() {
        return [SELECT Id, Name, Author_Writer__r.Name, Published_Date__c, Status__c From Post__c where Author_Writer__r.OwnerId = : managerId AND Status__c = 'Under Review'];
    }

}