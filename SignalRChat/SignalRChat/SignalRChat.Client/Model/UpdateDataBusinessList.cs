using Microsoft.VisualBasic;

namespace SignalRChat.Client.Model
{
    public class UpdateDataBusinessList
    {
        public int business_id { get; set; }
        public string business_name { get; set; }
        public int business_type { get; set; }
        public string business_url { get; set; }
        public string email { get; set; }
        public string phone_country { get; set; }
        public string country_id { get; set; }
        public string phone { get; set; }
        public string address { get; set; }
        public DateTime created_date { get; set; }
        public DateTime updated_date { get; set; }
        public string backend_user_name { get; set; }
    }
}
