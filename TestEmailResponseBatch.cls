@isTest
private class TestEmailResponseBatch {

    /*//test Email Response Batch
    static testMethod void testBatchResponse() {
       Messaging.InboundEmail email = new Messaging.InboundEmail();
       Messaging.InboundEnvelope envelope = new Messaging.InboundEnvelope();
       
       email.fromAddress = 'bhavika.pandya@gmail.com';
       email.Subject = 'Testmail';
       email.plainTextBody = '(Hello)';
       email.fromName = 'Bhavika Pandya';
       
       Contact con = new Contact(LastName='Pandya',Email='bhavika.pandya@gmail.com');
       insert con;
       
       Test.setMock(HttpCalloutMock.class,new MockResponseTest());
       EmailService mailObject = new EmailService();
       //mailObject.handleInboundEmail(email, envelope);
       EmailResponseBatch batchObj = new EmailResponseBatch();
       
       Test.startTest();
       Database.executeBatch(batchObj);       
       Test.stopTest();
       
       List<Email__c> ListInstance = [SELECT
                id,
                Mail_Body__c,
                Mail_Subject__c,
                ContactName__c,
                Email_ID__c
            FROM
                Email__c 
            WHERE
                Mail_Subject__c = 'Testmail'
            AND
                Email_ID__c = 'bhavika.pandya@gmail.com'
        ];
       System.assertEquals(1,ListInstance.size());
       
      Test.startTest();
      Database.executeBatch(batchObj);
      Email__c emailobj = new Email__c(Mail_Subject__c='Testmail',ContactName__c=con.Id);
      insert emailobj;
      Test.stopTest();
      //System.assertEquals(1,emailobj.size());
    }*/
}