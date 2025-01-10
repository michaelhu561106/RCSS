namespace SignalRChat.Client.Model
{
    public class BackendUserRightList:ResponseStanderd
    {
        public DataRight[]? dataRight { get; set; }
        public DataTalksRight[]? dataTalksRight { get; set; }
        public int businessServiceTalksIsNotReadCount { get; set; }
        public int business_id { get; set; }
        public int backend_user_id { get; set; }
        public string backend_user_name { get; set; }
    }
}
