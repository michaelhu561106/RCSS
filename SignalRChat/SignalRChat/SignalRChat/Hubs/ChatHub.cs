using Microsoft.AspNetCore.SignalR;
using ClassLibrary.Service;
using FirebaseAdmin.Messaging;

namespace SignalRChat.Hubs
{
    public class ChatHub : Hub
    {
        private ChatService chatService = new ChatService();

        public async Task JoinGroup(string groupName, string userName)
        {       
            Console.WriteLine($"{userName} 已加入群組 {groupName}");
            await Groups.AddToGroupAsync(Context.ConnectionId, groupName);
            await Clients.Group(groupName).SendAsync("JoinGroupMsg", 
                $"{userName} 已加入群組 {groupName}");
        }

        public async Task SendMessageToGroup(string groupName, string userName, string message, 
            int businessId, string uuid, bool isUserTalk, int backendUserId, bool isUserRead, bool isBackendUserRead,string backend_user_name)
        {
            try
            {
                await chatService.CreateServiceTalkMessage(businessId, groupName.Split('^')[0], uuid, DateTime.UtcNow,
                isUserTalk, backendUserId, message, isUserRead, isBackendUserRead);

                string timestamp = DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss.ffffff");

                await Clients.Group(groupName).SendAsync("SendGroupMsg", groupName, backend_user_name, message, timestamp);

                var notificationMessage = new Message()
                {
                    Notification = new Notification 
                    {
                        Title = "註冊寶",
                        Body = "您有新的訊息"
                    },
                    Token = "ezPJKHKXR722S5_zgMZkoU:APA91bHahC-xACjAvnw30Kc22lAZUSMjtYLiYP1GmqW2eylFFA32nAdoqiuRgSe1Mb4JWtOimy5eRA45GbHcwlSgeTiZfuqhrFgqFKo_BgJ0rrv6cLZ0_Wc"
                };

                var messaging = FirebaseMessaging.DefaultInstance;
                string result = await messaging.SendAsync(notificationMessage);
            }
            catch (Exception ex) 
            {
                Console.WriteLine($"錯誤: {ex.Message}");
            }
            // Console.WriteLine($"[{groupName}] --- {userName}: {message}");
            
        }
    }
}
