namespace SignalRChat.Client.Model
{
    public class UpdateDataBackendUserList
    {
        public int backend_user_id { get; set; }
        public string backend_user_name { get; set; }
        public string email { get; set; }
        public string phone { get; set; }
        public string phone_country { get; set; }
        public string country_id { get; set; }
        public int business_id { get; set; }
        public DateTime created_date { get; set; }
        public DateTime updated_date { get; set; }
        public int update_backend_user_id { get; set; }
    }
}
