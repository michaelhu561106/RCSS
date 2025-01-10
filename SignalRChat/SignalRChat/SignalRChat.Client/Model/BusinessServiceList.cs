namespace SignalRChat.Client.Model
{
    public class BusinessServiceList: ResponseStanderd
    {
        public DataBusinessServiceList[]? data { get; set; }
        public int dataBusinessServiceListCount { get; set; }
    }
}
