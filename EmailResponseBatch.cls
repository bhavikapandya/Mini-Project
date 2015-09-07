global with sharing class EmailResponseBatch implements  Database.Batchable<sObject>{

    Set<String> sendList = new Set<String>();
    //map<string,list<Response_Of_Query__c>> mapOfSendMailToResponse = new map<string,list<Response_Of_Query__c>>();
    	
    global Database.QueryLocator start(Database.BatchableContext BC){
    	return Database.getQueryLocator ([
    	       SELECT Email_ID__c, 
    	              ContactName__c 
    	         FROM Email__c 
    	        WHERE CreatedDate = TODAY]);
    }
    
    global void execute(Database.BatchableContext bc, List<Email__c> resList){
        for(Email__c response : resList){
            //sendList.add(response.RelatedContact__c,response.Id);

            Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
            email.setTargetObjectId(response.ContactName__c);
            email.setTemplateId('00X28000000IDLf');

            email.setWhatId(response.Id);
            email.setReplyTo('bhavikapandya16@gmail.com');
            email.setSenderDisplayName('GoobleForce Email Service');
            email.setSaveAsActivity(false);

            Messaging.sendEmail(new Messaging.SingleEmailMessage[] { email });
        }
    }
    
    global void finish(Database.BatchableContext BC){
    	system.debug('----------Finish----------');
     }
}