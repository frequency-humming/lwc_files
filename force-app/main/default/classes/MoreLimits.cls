public class MoreLimits {
    
    public Integer cpuTime { get;set; }
    public Integer cpuLimit { get;set; }
    public Integer heapSize { get;set; }
    public Integer heapLimit { get;set; }

    public String titleheapSize = 'Heap Size';
    public String titleheapLimit = 'Heap Size Limit';

    
    public MoreLimits(){
        cpuTime = Limits.getCpuTime();
        cpuLimit = Limits.getLimitCpuTime();
        heapSize = Limits.getHeapSize();
        heapLimit = Limits.getLimitHeapSize();
    }

}