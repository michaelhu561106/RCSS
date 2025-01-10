using Microsoft.AspNetCore.Connections.Features;
using System.ComponentModel.DataAnnotations;

namespace SignalRChat.Client.Model
{
    public class BusinessListCreateModel
    {
        [Required(ErrorMessage ="商家類型必填")]
        public int business_type_id {  get; set; }

        [Required(ErrorMessage = "商家名稱必填")]
        [StringLength(30,MinimumLength =2,ErrorMessage ="商家名稱長度為2~30個文字")]
        public string business_name {  get; set; }

        [Required(ErrorMessage = "eMail必填")]
        [EmailAddress(ErrorMessage ="eMai格式不符")]
        public string email {  get; set; }

        [Required(ErrorMessage = "商家電詁必填")]
        [StringLength(14,MinimumLength =9,ErrorMessage ="電話必須是9~14位數字")]
        public string phone {  get; set; }

        [Required(ErrorMessage = "商家國碼必填")]
        public string phone_country {  get; set; }

        [Required(ErrorMessage = "商家地址必填")]
        [StringLength(100, MinimumLength = 5, ErrorMessage = "地址必須是5~100位數字")]
        public string address {  get; set; }

        [Required(ErrorMessage = "url必填")]
        [Url(ErrorMessage ="url格式不符")]
        public string business_url { get; set; }
    }
}
