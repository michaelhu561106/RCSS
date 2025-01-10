namespace SignalRChat.Client.Model
{
    public class BusinessList: ResponseStanderd
    {
        public DataBusinessType[]? dataBusinessType { get; set; }
        public DataBusinessList[]? dataBusinessList { get; set; }    
        public int dataBusinessListCount { get; set; }  
    }
}
