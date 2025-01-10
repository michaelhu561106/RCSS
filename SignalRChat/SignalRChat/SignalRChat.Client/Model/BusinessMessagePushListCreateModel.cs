using Microsoft.AspNetCore.Components.Forms;
using Microsoft.AspNetCore.Http;
using System.ComponentModel.DataAnnotations;

namespace SignalRChat.Client.Model
{
    public class BusinessMessagePushListCreateModel
    {
        [Required(ErrorMessage = "商家id必填")]
        public int business_id { get; set; }

        [Required(ErrorMessage = "活動標題必填")]
        [StringLength(28, MinimumLength = 4, ErrorMessage = "活動標題長度為4~28個文字")]
        public string message_title { get; set; }

        [Required(ErrorMessage = "活動內容必填")]
        [StringLength(510, MinimumLength = 8, ErrorMessage = "活動內容為8~510個文字")]
        public string message_content { get; set; }

        [Required(ErrorMessage = "活動網址必填")]
        [StringLength(510, MinimumLength = 8, ErrorMessage = "活動網址為8~510個文字")] 
        public string message_url { get; set; }

        [Required(ErrorMessage = "活動啟始日期必填")]
        public DateTime push_start_date { get; set; }

        [Required(ErrorMessage = "活動結束日期必填")]
        public DateTime push_end_date { get; set; }

        [Required(ErrorMessage = "變更者後台用戶id必填")]
        public int backend_user_id { get; set; }

        [Required(ErrorMessage = "活動圖檔必傳")]
        [Length(minimumLength:1,maximumLength:1024*500 ,ErrorMessage ="圖檔大小不能超過500K")]
        public IReadOnlyList<IBrowserFile> message_image_file { get; set; }
    }
}
