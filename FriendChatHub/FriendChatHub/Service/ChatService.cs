using System.Net.Http.Json;

namespace FriendChatHub.Service
{
    public class ChatService
    {
        private readonly HttpClient _httpClient;

        public ChatService()
        {
            _httpClient = new HttpClient();
        }

        public class NewFriendTalkMessage
        {
            public NewFriendTalkMessage(string uuid, string friend_uuid, DateTime created_date, string sender_uuid, string talk_content)
            {
                this.uuid = uuid;
                this.friend_uuid = friend_uuid;
                this.created_date = created_date;
                this.sender_uuid = sender_uuid;
                this.talk_content = talk_content;
            }

            public string uuid { get; set; }
            public string friend_uuid { get; set; }
            public DateTime created_date { get; set; }
            public string sender_uuid { get; set; }
            public string talk_content { get; set; }
        }

        public async Task CreateFriendTalkMessage(string uuid, string friend_uuid, DateTime created_date, string sender_uuid, string talk_content)
        {
            try
            {

                NewFriendTalkMessage data = new NewFriendTalkMessage(uuid, friend_uuid, created_date, sender_uuid, talk_content);

                var uri = "http://10.10.10.207:3000/api/userFriendTalks/create";
                var response = await _httpClient.PostAsJsonAsync<NewFriendTalkMessage>(uri, data);

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
