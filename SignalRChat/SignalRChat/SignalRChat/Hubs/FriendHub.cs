using Microsoft.AspNetCore.SignalR;
using ClassLibrary.Service;

namespace SignalRChat.Hubs
{
    public class FriendHub : Hub
    {
        private FriendService friendService = new FriendService();

        public async Task JoinGroup(string groupName, string userName)
        {
            //Console.WriteLine("Someone joined.");
            //await Groups.AddToGroupAsync(groupName, userName);

            Console.WriteLine($"{userName} 已加入群組 {groupName}");
            await Groups.AddToGroupAsync(Context.ConnectionId, groupName);
            //await Clients.Group(groupName).SendAsync("JoinGroupMsg",
            //    $"{userName} 已加入群組 {groupName}");
        }

        public async Task SendMessageToGroup(string groupName, string userName, string message, string uuid, string friend_uuid, string sender_uuid, string talk_content)
        {
            try
            {
                await friendService.CreateFriendTalkMessage(uuid, friend_uuid, DateTime.UtcNow, sender_uuid, talk_content);

                string timestamp = DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss.ffffff");
                await Clients.Group(groupName).SendAsync("SendGroupMsgFriend", groupName, userName, message, timestamp);
            }
            catch (Exception ex)
            {
                Console.WriteLine($"錯誤: {ex.Message}");
            }
        }
    }
}
