namespace SignalRChat.Client.Model
{
    public class DataBusinessMessagePushList
    {
        public int business_id {  get; set; }
        public int business_message_push_id { get; set; }
        public string message_title { get; set; }
        public string message_content { get; set; }
        public string message_image { get; set; }   
        public string message_url { get; set; }
        public DateTime push_start_date { get; set; }
        public DateTime push_end_date   { get;set; }
        public DateTime created_date { get;set;}
        public DateTime updated_date { get;set;}
        public int backend_user_id { get; set; }
        public string business_name { get; set; }
        public string backend_user_name { get; set; }




    }
}
