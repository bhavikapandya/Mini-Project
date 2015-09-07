public with sharing class EmailHandler {
    public static void checkEmail(List<Email__c> emailList){
        
        for(Email__c emailInstance : emailList) {
             callToGoogle(emailInstance.Mail_Body__c, emailInstance.id, emailInstance.Email_ID__c, emailInstance.ContactName__c);
             
        }
    }
    @future (callout=true)
    public static void callToGoogle(String queryString, Id idOfQuery, String sender,Id contact) {
        HttpRequest req = new HttpRequest();
        String query = queryString;
        req.setEndpoint('https://www.google.com/search?q='+EncodingUtil.urlEncode(query, 'UTF-8'));
        req.setMethod('GET');
        req.setHeader('Content-Type', 'text/plain');
        Http http = new Http();
        HttpResponse res = http.send(req);
        system.debug('  rsponse '+res.getBody());
        //return res;
        
        string str = res.getBody() ;
        str = str.replace('<cite>',' LinkStart[ ');
        str = str.replace('</cite>',' ]LinkEnd DescStart[ '); 
        str = str.replace('</div></li>', ' ]DescEnd ');
        System.debug('#### String replaceAll   #####'+str);

        String str1 = str.stripHtmlTags();
        System.debug('#### String stripHtmlTags   #####'+str1);
        List<String> strList = new List<String>();
        List<String> strListUpdated = new List<String>();
        strList = str1.split('DescEnd');
        strList.remove(0);
        strList.remove(strList.size()-1);
        
        System.debug('#### String strList   #####'+strList);
        List<Response_Of_Query__c> resResultList = new List<Response_Of_Query__c>();
        for(String strItem : strList){
            String title = strItem.substringBefore('LinkStart[');
            String link = strItem.substringBetween('LinkStart[', ']LinkEnd');
            String description = strItem.substringBetween('DescStart[ ', ']');
            resResultList.add(new Response_Of_Query__c(Title__c = title, Links__c = link, Snippet__c = description, Query__c = idOfQuery, RelatedContact__c = contact, Sendmail__c = sender));
        }
        insert resResultList;
    } 
}