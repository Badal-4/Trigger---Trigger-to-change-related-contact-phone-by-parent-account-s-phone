//trigger to change related contact phone by parent account phone
//trigger to change related contact's phone when parent's phone is changed
trigger trg1 on Account(after Update)
{
   Map<Id,Account> accMap = new Map<Id,Account>();
    
    if(trigger.isAfter && trigger.isUpdate))
    {
        if(!trigger.new.isEmpty())
        {
            for(Account ac : trigger.new)
            {
                if(trigger.newMap.get(ac.Id).Phone != trigger.oldMap.get(ac.Id).Phone)
                {
                    accMap.put(ac.Id,ac);
                }
            }
        }
    }
    
    List<Contact> conList = [Select Id,AccountId,Phone from Contact where AccountId IN : accMap.keyset()];
    List<Contact> contList = new List<Contact>();
    
    if(!conList.isEmpty())
    {
        for(Contact con : conList)
        {
            con.Phone = accMap.get(con.AccountId).Phone;
            contList.add(con);
        }
    }
    
    if(!contList.isEmpty())
    {
        update contList;
    }
}
