using Microsoft.AspNetCore.SignalR;
using FriendChatHub.Service;

namespace FriendChatHub
{
    public class ChatHub : Hub
    {
        private ChatService chatService = new ChatService();

        public async Task JoinGroup(string groupName, string userName)
        {
            Console.WriteLine("Someone joined.");
            await Groups.AddToGroupAsync(groupName, userName);
        }

        public async Task SendMessageToGroup(string groupName, string userName, string message, string uuid, string friend_uuid, string sender_uuid, string talk_content)
        {
            try
            {
                await chatService.CreateFriendTalkMessage(uuid, friend_uuid, DateTime.UtcNow, sender_uuid, talk_content);

                string timestamp = DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss.ffffff");
                await Clients.Group(groupName).SendAsync("SendGroupMsg", groupName, userName, message, timestamp);
            }
            catch (Exception ex) 
            {
                Console.WriteLine($"錯誤: {ex.Message}");
            }
        }
    }
}
