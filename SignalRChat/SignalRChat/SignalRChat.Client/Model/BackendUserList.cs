namespace SignalRChat.Client.Model
{
    public class BackendUserList: ResponseStanderd
    {
        public DataBackendUserList[]? data { get; set; }
        public int dataBackendUsersCount { get; set; } = default;
    }
}