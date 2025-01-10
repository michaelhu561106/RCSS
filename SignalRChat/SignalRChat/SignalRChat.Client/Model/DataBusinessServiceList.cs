namespace SignalRChat.Client.Model
{
    public class DataBusinessServiceList
    {
        public int business_id {  get; set; }
        public string business_service_name { get; set; }
        public DateTime created_date { get; set; }
        public DateTime updated_date { get; set; }
        public int backend_user_id { get; set; }
        public string backend_user_name { get; set; }
    }
}
