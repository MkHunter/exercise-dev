//CaseController.cls
public with sharing class ContactController {
    @AuraEnabled(cacheable=true)
    public static List<Contact> getContactPayments(){
        List<Contact> c =  [SELECT Name, Most_recent_payment_date__c, Total_Amount_of_Payments__c, 
                (SELECT Id, Name, Payment_Date__c, Amount__c from Payments__r) 
                FROM Contact WHERE Id IN (SELECT Contact__c FROM Payments__c)];
        return c;
    }
}