using System.ComponentModel.DataAnnotations;

namespace SignalRChat.Client.Model
{
    public class BackendUserListUpdateModel
    {
        [Required(ErrorMessage = "後台用戶名稱必填")]
        [StringLength(20, MinimumLength = 2, ErrorMessage = "後台用戶名稱長度為2~20個文字")]
        public string backend_user_name { get; set; }

        [Required(ErrorMessage = "eMail必填")]
        [EmailAddress(ErrorMessage = "eMai格式不符")]
        public string email { get; set; }

        [StringLength(20, ErrorMessage = "密碼長度必須為8~20個文字")]
        [RegularExpression(@"^[a-zA-Z0-9]*$", ErrorMessage = "密碼只能是英數字")]
        public string password { get; set; }

        [Compare("password", ErrorMessage = "兩次輸入密嗎內容必須相同")]
        public string passwordAgain { get; set; }

        [Required(ErrorMessage = "商家id必填")]
        public int business_id { get; set; }

        [Required(ErrorMessage = "電詁必填")]
        [StringLength(14, MinimumLength = 9, ErrorMessage = "電話必須是9~14位數字")]
        public string phone { get; set; }

        [Required(ErrorMessage = "電話國碼必填")]
        public string phone_country { get; set; }
    }
}
