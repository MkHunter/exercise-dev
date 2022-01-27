public class PaymentTriggerHandler extends TriggerHandler {
    private List<Payments__c> newPaymentsList;
    private List<Payments__c> oldPaymentsList;

    public PaymentTriggerHandler() {
        this.newPaymentsList = Trigger.New;
        this.oldPaymentsList = Trigger.Old;
    }

    // Update Contact & Project field data given a Payment triggerAction
    private void updateAmounts(List<Payments__c> paymentsList,String triggerAction){
        // TODO: Query Factory
        Map<Id,Contact> contacts = new Map<Id,Contact>([SELECT Id, Total_Amount_of_Payments__c, Most_recent_payment_date__c FROM Contact]);
        Map<Id,Project__c> projects = new Map<Id,Project__c>([SELECT Id, Total_Amount_of_Payments__c FROM Project__c]);
            
        List<SObject> updatedObjs = new List<SObject>();
        
        for (Payments__c payment : paymentsList) {
            Contact ct = contacts.get(payment.Contact__c);
            Project__c pj = projects.get(payment.Project__c);

            switch on triggerAction {
                when 'insert' {
                    // Increment Total Amaunt of Payments & rewrite payment date
                    ct.Total_Amount_of_Payments__c += payment.Amount__c;
                    pj.Total_Amount_of_Payments__c += payment.Amount__c;
                    ct.Most_recent_payment_date__c = payment.Payment_Date__c;
                }
                when 'delete' {
                    // Decrement Total Amaunt of Payments
                    ct.Total_Amount_of_Payments__c -= payment.Amount__c;
                    pj.Total_Amount_of_Payments__c -= payment.Amount__c;
                }
                when 'update' {
                    // Get the old Payment Amount
                    Map<Id, Payments__c> oldPaymentsMap = new Map<Id, Payments__c>(oldPaymentsList);
                    Decimal oldPaymentAmount = oldPaymentsMap.get(payment.Id).Amount__c;

                    // Add up the Amount difference
                    ct.Total_Amount_of_Payments__c += payment.Amount__c - oldPaymentAmount;
                    pj.Total_Amount_of_Payments__c += payment.Amount__c - oldPaymentAmount;
                }
            }

            updatedObjs.add(ct);
            updatedObjs.add(pj);
        }
        update updatedObjs;
    }

    public override void afterInsert() {
        updateAmounts(newPaymentsList, 'insert');
    }

    public override void afterUpdate() {
        updateAmounts(newPaymentsList, 'update');
    }

    public override void afterDelete() {
        updateAmounts(oldPaymentsList, 'delete');
    }
}