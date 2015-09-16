public with sharing class ExpenseController {
	@AuraEnabled
    public static List<rohitrdev2__Expense__c> getExpenses() {
        // Perform isAccessible() check here
        return [SELECT Id, Name, rohitrdev2__Amount__c, rohitrdev2__Client__c, rohitrdev2__Date__c,
        		rohitrdev2__Reimbursed__c, CreatedDate FROM rohitrdev2__Expense__c];
    }
}