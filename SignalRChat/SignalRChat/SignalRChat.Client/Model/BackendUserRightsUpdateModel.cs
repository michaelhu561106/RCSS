namespace SignalRChat.Client.Model
{
    public class BackendUserRightsUpdateModel
    {
        public int backend_user_id { get; set; }
        public int backend_right_group_id { get; set; } 
        public int backend_right_id { get; set; }
    }
}
