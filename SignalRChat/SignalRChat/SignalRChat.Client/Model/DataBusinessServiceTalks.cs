namespace SignalRChat.Client.Model
{
    public class DataBusinessServiceTalks
    {
        public int business_id {  get; set; }
        public string business_service_name { get; set; }
        public DateTime created_date { get; set; }
        public bool is_user_talk { get; set; }
        public int backend_user_id { get; set; }
        public string talk_content { get; set; }
        public bool is_user_read { get; set; }
        public bool is_backend_user_read { get; set; }
        public string backend_user_name { get; set; }
        public string user_name { get; set; }
    }
}
