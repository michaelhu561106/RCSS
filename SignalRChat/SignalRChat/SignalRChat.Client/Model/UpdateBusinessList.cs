namespace SignalRChat.Client.Model
{
    public class UpdateBusinessList: ResponseStanderd
    {
        public DataBusinessType[]? dataBusinessType { get; set; }
        public UpdateDataBusinessList dataBusinessList { get; set; }    
    }
}
