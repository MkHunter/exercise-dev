# Exercise-Dev
* Data Model/Objects
* Trigger
* LWC

## Installation instructions
1. Authorize an Org
2. Right click force-app/ & Deploy Source to Org

## Change List

| Metadata Entity | Object                                 | Change Type | Details |   |
|-----------------|----------------------------------------|-------------|---------|---|
| CustomObject    | Payments__c                            | Create      |         |   |
| CustomObject    | Project__c                             | Create      |         |   |
| CustomObject    | Contact                                | Update      |         |   |
| CustomField     | Project__c.Total_Amount_of_Payments__c | Create      |         |   |
| CustomField     | Contact.Total_Amount_of_Payments__c    | Create      |         |   |
| App             | Project_Payments                       | Create      |         |   |
| Tab             | Payments__c                            | Create      |         |   |
| Tab             | Project__c                             | Create      |         |   |

## Deployment Tasks
### Pre-installation

### Post-installation
* Assign a Profile to the Project_Payments App.