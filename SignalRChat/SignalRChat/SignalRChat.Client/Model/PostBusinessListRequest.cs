namespace SignalRChat.Client.Model
{
    public class PostBusinessListRequest
    {
        public int business_id { get; set; }
        public int business_type_id { get; set; }
        public string business_url { get; set; }
        public string email { get; set; }
        public string phone { get; set; }
        public string address { get; set; }
    }
}
