﻿namespace ClassLibrary.Service
{
    public class ChatService
    {
        private readonly HttpClient _httpClient;

        public ChatService()
        {
            _httpClient = new HttpClient();
        }

        public class NewServiceTalkMessage
        {
            public NewServiceTalkMessage(int business_id, string business_service_name, string user_uuid, DateTime created_date, bool is_user_talk, int backend_user_id, string talk_content, bool is_user_read, bool is_backend_user_read)
            {
                this.business_id = business_id;
                this.business_service_name = business_service_name;
                this.user_uuid = user_uuid;
                this.created_date = created_date;
                this.is_user_talk = is_user_talk;
                this.backend_user_id = backend_user_id;
                this.talk_content = talk_content;
                this.is_user_read = is_user_read;
                this.is_backend_user_read = is_backend_user_read;
            }

            public int business_id { get; set; }
            public string business_service_name { get; set; }
            public string user_uuid { get; set; }
            public DateTime created_date { get; set; }
            public bool is_user_talk { get; set; }
            public int backend_user_id { get; set; }
            public string talk_content { get; set; }
            public bool is_user_read { get; set; }
            public bool is_backend_user_read { get; set; }
        }

        public async Task CreateServiceTalkMessage(int business_id, string business_service_name, string user_uuid, DateTime created_date, bool is_user_talk,
                                                    int backend_user_id, string talk_content, bool is_user_read, bool is_backend_user_read)
        {
            try
            {
                NewServiceTalkMessage data = new NewServiceTalkMessage(business_id, business_service_name, user_uuid, created_date, is_user_talk, backend_user_id,
                                                                   talk_content, is_user_read, is_backend_user_read);
                // var jsonData = JsonSerializer.Serialize<NewServiceTalkMessage>(data);

                var uri = "http://10.10.10.207:3000/api/businessServiceTalks/create";
                var response = await _httpClient.PostAsJsonAsync<NewServiceTalkMessage>(uri, data);

                Console.WriteLine(response.StatusCode);

                if (response.IsSuccessStatusCode)
                {
                    string result = await response.Content.ReadAsStringAsync();
                    Console.WriteLine(result);
                }
                else
                {
                    string errorDetails = await response.Content.ReadAsStringAsync();
                    Console.WriteLine($"Error Details: {errorDetails}");
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine($"錯誤: {ex.Message}");
            }
        }
    }
}
