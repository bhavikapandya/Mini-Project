@isTest
public with sharing class HistoryControllerTest {
    static testMethod void testPage(){
      List<Email__c> emailList = new List<Email__c>();
      Email__c email1 = new Email__c(Mail_Body__c='Test1');
      Email__c email2 = new Email__c(Mail_Body__c='Test2');
      emailList.add(email1);
      emailList.add(email2);
      insert emailList;
      
      //Creating controller instance
      Test.setMock(HttpCalloutMock.class,new MockResponseTest());
      Test.startTest();
      HistoryController controllerInstance = new HistoryController();
      boolean test1 = controllerInstance.hasNext;
      boolean test2 = controllerInstance.hasPrevious;
      integer test3 = controllerInstance.pageNumber; 
      
      controllerInstance.next();
      controllerInstance.previous();
      controllerInstance.first();
      controllerInstance.last();
      
      Test.stopTest();
      List<Email__c> expectedList = controllerInstance.getsearchList();
      system.assertEquals(2,expectedList.size());
      
      //Test showresults Method
      PageReference pageRef = Page.History;
      pageRef.getParameters().put('queryId',email1.Id);
      Test.setCurrentPage(pageRef);
      
      controllerInstance.showResults();
      system.assert(controllerInstance.resList.size() <> NULL); 
      
      //test clear method
      controllerInstance.rend2 = true;
      controllerInstance.rend3 = true;
      controllerInstance.rend4 = true;
      controllerInstance.clearAll();
      system.assertEquals(false,controllerInstance.rend2);
      system.assertEquals(false,controllerInstance.rend3);
      system.assertEquals(false,controllerInstance.rend4);
      
      //test ShowHistory Method
      controllerInstance.rend2 = false;
      controllerInstance.rend4 = false;
      controllerInstance.renClear = false;
      controllerInstance.showHistory();
      system.assertEquals(true,controllerInstance.rend2);
      system.assertEquals(true,controllerInstance.rend4);
      system.assertEquals(true,controllerInstance.renClear);
    }

}