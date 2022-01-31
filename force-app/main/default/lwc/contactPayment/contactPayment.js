//myTreeGrid.js
import { LightningElement, wire, track } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';

import getContacts from '@salesforce/apex/ContactController.getContactPayments'

const actions = [
    { label: 'Edit', name: 'edit_record' }
];

const COLS = [{
    fieldName: 'Name',
    label: 'Contact Payments'
},
{
    fieldName: 'Payment_Date__c',
    label: 'Payment Date',
    type: 'date',
    cellAttributes : {
        iconName: 'standard:date_time',
        iconLabel: { fieldName: 'Most_recent_payment_date__c', type: 'currency' }
    }
},
{
    fieldName: 'Amount__c',
    label: 'Payments',
    type: 'currency',
    cellAttributes : {
        iconName: 'custom:custom41',
        iconLabel: { fieldName: 'Total_Amount_of_Payments__c' },
        alignment: 'left'
    }
},
{ 
    type: 'action',
    label: 'Edit Record',
    typeAttributes: { 
      rowActions: actions,
      menuAlignment: 'right' 
    } 
}];

export default class MyTreeGrid extends NavigationMixin(LightningElement) {
    @track myData = [];
    columns = COLS;
    error;
    
    @wire(getContacts)
    wiredContacts({error, data}) {
        if (error) {
            // Handle error
            this.error = error;
        } else if (data) {
            // Process record data
            var strData = JSON.parse( JSON.stringify( data ) );
            console.log(strData);
            strData.map((row, index) => {
                if (row['Payments__r']) {
                    row._children = row['Payments__r']; //define rows with children 
                    delete row.Payments__r;

                    let iconKey = "iconName";
                    row[iconKey] = 'custom:custom41';
                }     
            });
            this.myData = strData;
        }
    }
    
    handleRowAction(event) {
        const action = event.detail.action;
        const row = event.detail.row;
        switch (action.name) {
            case 'edit_record':
                this[NavigationMixin.Navigate]({
                    type: 'standard__objectPage',
                    attributes: {
                        objectApiName: 'Contact',
                        actionName: 'edit',
                        recordId: row.Id
                    }
                });
                break;
        }
    }
}