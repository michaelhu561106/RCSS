namespace SignalRChat.Client.Model
{
    public class BusinessMessagePushList:ResponseStanderd
    {
        public DataBusinessMessagePushList[]? data { get; set; }
        public int dataMessagePushCount { get; set; } = default;
    }
}
