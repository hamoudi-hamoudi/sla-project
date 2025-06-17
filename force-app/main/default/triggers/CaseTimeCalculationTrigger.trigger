trigger CaseTimeCalculationTrigger on Case (before Update) {
for (Case c : Trigger.new) {
        Case oldCase = Trigger.oldMap.get(c.Id);

  
        if (oldCase.Status == 'New' && c.Status == 'In Progress' && c.Response_Time__c == null) {
            Decimal responseHours = (System.now().getTime() - c.CreatedDate.getTime()) / 1000 / 60 / 60;
            c.Response_Time__c = responseHours;
        }


        if (oldCase.Status != 'Resolved' && c.Status == 'Resolved' && c.Resolution_Time__c == null) {
            Decimal resolutionHours = (System.now().getTime() - c.CreatedDate.getTime()) / 1000 / 60 / 60;
            c.Resolution_Time__c = resolutionHours;
        }
    }
}