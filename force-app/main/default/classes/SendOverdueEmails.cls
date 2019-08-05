public class SendOverdueEmails implements Schedulable {
    
    public void execute(SchedulableContext SC) {
        sendOverdueWIEmail();
    }
    
    public void sendOverdueWIEmail() {
        List<Messaging.Email> emailMessages = new List<Messaging.Email>();
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        mail.setTargetObjectId('0053i000000bTwNAAU');
        mail.setTemplateId('00X3i000000gxFWEAY');
        mail.setTreatTargetObjectAsRecipient(true);
        mail.setSaveAsActivity(false);
        
        emailMessages.add(mail);
        
        Messaging.sendEmail(emailMessages);

    }

}