public with sharing class HistoryController {
    
    public Id idOfQuery;
    public boolean rend4 {get; set;}
    public boolean rend2 {get; set;}
    public boolean rend3 {get; set;}
    public List<Email__c> searchList;
    public List<Response_Of_Query__c> resList {get; set;}
    //public List<String> subjectList {get;set;}
    public boolean renClear {get; set;}
    
    public HistoryController(){
        rend2 = false;
        rend3 = false;
        rend4 = false;
        renClear = false;
    }
    
    public void showHistory(){
        rend2 = true;
        rend4 = true;
        renClear = true;
    }

   public List<Email__c> getsearchList(){
       //searchList = [SELECT Mail_Subject__c FROM Email__c];
       return querySet.getRecords(); 
   }
   
     public void showResults(){
        rend3 = true;
        idOfQuery = ApexPages.currentPage().getParameters().get('queryId');
        resList = [SELECT Title__c, Snippet__c, Links__c FROM Response_Of_Query__c WHERE Query__c =:idOfQuery]; 
        PageReference resultPage = Page.History;
       // return resultPage;
   }
   
   public void clearAll(){
       rend2 = false;
       rend3 = false;
       rend4 = false;
   }
   
   public ApexPages.StandardSetController querySet {
        get {
            if(querySet == null) {
                querySet = new ApexPages.StandardSetController(Database.getQueryLocator([Select Mail_Body__c  FROM Email__c]));
                // sets the number of records in each page set
                querySet.setPageSize(5);
            }
            return querySet;
        }
        set;
    }
    
    public Boolean hasNext {
        get {
            return querySet.getHasNext();
        }
        set;
    }
   
    public Boolean hasPrevious {
        get {
            return querySet.getHasPrevious();
        }
        set;
    }
   
    public Integer pageNumber {
        get {
            return querySet.getPageNumber();
        }
        set;
    }
   
    public void first() {
        querySet.first();
    }
   
    public void last() {
        querySet.last();
    }

    public void previous() {
        querySet.previous();
    }
    
    public void next() {
        querySet.next();
    } 
}