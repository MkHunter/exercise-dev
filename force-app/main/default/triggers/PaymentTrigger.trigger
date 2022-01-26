trigger PaymentTrigger on Payments__c (before insert, before update, before delete) {
    new PaymentTriggerHandler().run();
}