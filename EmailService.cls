global class EmailService implements Messaging.InboundEmailHandler {
    global Messaging.InboundEmailResult handleInboundEmail(Messaging.InboundEmail email, Messaging.InboundEnvelope envelope) {

       //Check contact is present or not if not create new contact
        Contact contact = new Contact();
        Messaging.InboundEmailResult result = new Messaging.InboundEmailresult();
        String str = email.plainTextBody;
        str = str.substringbetween('(',')');
        if (String.isNotBlank(str)) {
            if ([SELECT count() 
                   FROM Contact 
                  WHERE LastName = :email.fromname] == 0) {
                
                contact.FirstName = email.fromname.substring(0,email.fromname.indexOf(' '));
                contact.LastName = email.fromname.substring(email.fromname.indexOf(' '));
                contact.Email = envelope.fromAddress;
                insert contact;
                System.debug('====> Created contact '+contact.Id);

                //Assign the fields to that object
                Email__c emailInstance = new Email__c();
                emailInstance.ContactName__c = contact.Id;
                emailInstance.Mail_Body__c = str;
                emailInstance.Mail_Subject__c = email.Subject;
                emailInstance.Email_ID__c = email.fromAddress;//emailInstance.Name = email.body;
                insert emailInstance;
                System.debug('====> emailInstance '+emailInstance);
            }

            else {
                //contact = [select Id from Contact where Email = :email.fromname];
                Email__c emailInstance = new Email__c();
                Contact conInstance = [
                    SELECT Id,
                           LastName 
                      FROM Contact 
                      WHERE LastName = :email.fromname
                    ];
                emailInstance.ContactName__c = conInstance.Id;
                emailInstance.Email_ID__c = email.fromAddress;
                emailInstance.Mail_Body__c = str;
                emailInstance.Mail_Subject__c = email.Subject;
                insert emailInstance;
                System.debug('====> emailInstance '+emailInstance);
            }
        }
        else {
            result.success = false;
            result.message = 'OOPS Sorry!!!'
                           + '\nPlease Send Your Query In The Mail Body.'
                           + '\nThank you!!!\nGoobleForce.com';
        }
        return result;
    }
}