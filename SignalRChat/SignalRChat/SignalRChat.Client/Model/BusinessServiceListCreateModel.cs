using System.ComponentModel.DataAnnotations;

namespace SignalRChat.Client.Model
{
    public class BusinessServiceListCreateModel
    {
        [Required(ErrorMessage = "商家id必填")]
        public int business_id { get; set; }

        [Required(ErrorMessage = "客服聊天室名稱必填")]
        [StringLength(20, MinimumLength = 2, ErrorMessage = "客服聊天室名稱長度為2~20個文字")]
        public string business_service_name { get; set; }
    }
}
