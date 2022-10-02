public class DocInstructionsController {	
    
    public MoreLimits cpu{
        
        get{  
            MoreLimits ml = new MoreLimits();
            return ml;
        }
    }
    
    public List<System.OrgLimit> GetLimits(){
        List<System.OrgLimit> orgLimit = OrgLimits.getAll();
        return orgLimit;
    }
	
    
    
}