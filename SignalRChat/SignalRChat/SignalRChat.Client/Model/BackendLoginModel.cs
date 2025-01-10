using System.ComponentModel.DataAnnotations;

namespace SignalRChat.Client.Model
{
    public class BackendLoginModel
    {
        [Required(ErrorMessage = "eMail(帳號)必填")]
        public string email { get; set; }
        [Required(ErrorMessage = "密碼必填")]
        public string password { get; set; }
    }
}
