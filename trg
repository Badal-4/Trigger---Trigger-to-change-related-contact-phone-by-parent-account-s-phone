//trigger to change related contact phone by parent account phone
trigger trg1 on Account(after Update)
{
    Map<Id,Account> accMap = new Map<Id,Account>();
    if(trigger.isAfter && trigger.isUpdate)
    {
        for(Account ac : trigger.new)
        {
            if(trigger.newMap.get(ac.Id).Phone != trigger.oldMap.get(ac.Id).Phone)
            {
                accMap.put(ac.Id,ac);
            }
        }
    }
    List<Contact> conList = [Select Id,Phone,AccountId from Contact where AccountId IN : accMap.keySet()];
    List<Contact> contList = new List<Contact>();
    for(Contact con : conList)
    {
        Account acc = accMap.get(con.AccountId);
        con.Phone = acc.Phone;
        contList.add(con);
    }
    if(contList.size() != null)
    {
    update contList;
    }
}
