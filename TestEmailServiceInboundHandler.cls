@isTest
public class TestEmailServiceInboundHandler {

    static testmethod void CheckIfConditionTest(){
        Messaging.InboundEmail email = new Messaging.InboundEmail() ;
        Messaging.InboundEnvelope env = new Messaging.InboundEnvelope();

        email.fromname = 'First Last';
        email.subject ='Rose';
        email.plainTextBody = '(Rose)';
        env.fromaddress = 'pandya.bhavika@gmail.com';

        Test.setMock(HttpCalloutMock.class,new MockResponseTest());
        Test.startTest();
        EmailService mailInstance = new EmailService();
        Messaging.InboundEmailResult result = mailInstance.handleInboundEmail(email,env);

        Test.stopTest();
        system.debug('***********************');
        List<Contact> con = [
            SELECT FirstName, 
                   LastName, 
                   Email 
              FROM Contact 
             WHERE Email = 'pandya.bhavika@gmail.com'
        ];
        system.debug('***********************'+con);
        system.assertEquals(1,con.size());
        system.assertEquals('First',con[0].FirstName);
        system.assertEquals('Last',con[0].LastName);
        system.assertEquals('pandya.bhavika@gmail.com',con[0].Email);

        Email__c emailInfoInstance = [
            SELECT
                id,
                Mail_Body__c,
                Mail_Subject__c,
                ContactName__c,
                Email_ID__c 
            FROM
                Email__c 
            WHERE
                Mail_Subject__c='Rose'
        ];
        system.assertEquals('Rose',emailInfoInstance.Mail_Body__c);
        system.assertEquals(con[0].Id,emailInfoInstance.ContactName__c);
        system.assertEquals(true,result.success);
    }

     static testmethod void CheckElseConditionTest(){
        Contact contactTestInstance = 
            new Contact(LastName = 'Bhavi Pandya', Email = 'pandya.bhavika@gmail.com');
        insert contactTestInstance;

        Test.setMock(HttpCalloutMock.class,new MockResponseTest());
        Test.startTest();
        Messaging.InboundEmail email = new Messaging.InboundEmail();
        Messaging.InboundEnvelope envelope = new Messaging.InboundEnvelope();
       
        Test.stopTest();
        email.fromAddress = 'pandya.bhavika@gmail.com';
        email.Subject = 'Testmail';
        email.plainTextBody = '(hello)';
        email.fromName = 'Bhavi Pandya';

        EmailService mailInstance = new EmailService();
        Messaging.InboundEmailResult result = mailInstance.handleInboundEmail(email, envelope);

        List<Contact> contactTestListInstance = [
            SELECT id, 
                   LastName
              FROM Contact
             WHERE LastName = 'Bhavi Pandya'
        ];
       System.assertEquals(1,contactTestListInstance.size());
       system.assertEquals(True,result.success);
    }

    static testmethod void withoutBodyTest(){
        Messaging.InboundEmail email = new Messaging.InboundEmail() ;
        Messaging.InboundEnvelope env = new Messaging.InboundEnvelope();

        email.fromname = 'Third Test';
        email.subject ='Subject1';
        email.plainTextBody = '';
        env.fromaddress = 'test@gooble.com';

        Test.startTest();
        EmailService mailInstance = new EmailService();
        Messaging.InboundEmailResult result = mailInstance.handleInboundEmail(email,env);
        system.assertEquals(false,result.success);
        Test.stopTest();
    }
}