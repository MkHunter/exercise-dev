trigger PaymentTrigger on Payments__c (after insert, after update, after delete) {
    new PaymentTriggerHandler().run();
}