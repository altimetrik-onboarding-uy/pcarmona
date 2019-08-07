public class MarkdownContentController {
    
    @AuraEnabled
    public static Boolean updatePost(Id postId, String newContent) {
        if(newContent != null && newContent != '') {
            Post__c currentPost = new Post__c();
            
            try {
                currentPost = [SELECT Id, Name, Content__c, Status__c, Published_Date__c, Tags__c, Author_Writer__c FROM Post__c WHERE Id = : postId];
                currentPost.Content__c = newContent;
                update currentPost;
                
            } catch(DmlException e) {
                System.debug('An unexpected error has occurred: ' + e.getMessage());
                return false;
            }
            
            return true;
        }
        
        return false;
    }
    
    @AuraEnabled
    public static String submitForReview(Id postId) {
        Post__c currentPost = new Post__c();
        String result = 'Now your post is under review';
        
        try {
            currentPost = [SELECT Id, Name, Status__c, Published_Date__c, Tags__c, Author_Writer__c FROM Post__c WHERE Id = : postId];
            if(currentPost.Status__c == 'Draft') {
                currentPost.Status__c = 'Under Review';
                update currentPost;
                return result;
            }
            else {
                System.debug('Only post with status "Draft" can be set under review.');
                result = 'Only post with status "Draft" can be set under review.';
                return result;
            }
            
        } catch(DmlException e) {
            System.debug('An unexpected error has occurred: ' + e.getMessage());
            result = 'Error when trying to update post status.';
            return result;
        }
    }

}