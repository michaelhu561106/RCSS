using SignalRChat.Client.Utility;
using System.Text.Json;
using SignalRChat.Client.Model;
using System.Text;

namespace SignalRChat.Client.Service;
public class AuthService
{
    private readonly HttpClient _httpClient;
    private readonly IConfiguration _configuration;
    public AuthService(HttpClient httpClient, IConfiguration configuration)
    {
        _httpClient = httpClient;
        _configuration = configuration;
    }
    public async Task<BackendUserRightList> BackendUserLogin(BackendLoginModel model)
    {
        string err = "";
        try
        {
            var basePath = $"{_configuration["BaseUri"]}backendlogin";  // "http://10.10.10.207:3000/api/businessList";
            var uri = basePath;
            using StringContent jsonContent = new(
                JsonSerializer.Serialize(new
                {
                    email = model.email,
                    password = model.password
                }),
                Encoding.UTF8,
                "application/json");
            var response = await _httpClient.PostAsync(uri, jsonContent);
            if (response.IsSuccessStatusCode)
            {
                string data = await response.Content.ReadAsStringAsync();
                BackendUserRightList jsonData = JsonSerializer.Deserialize<BackendUserRightList>(data);
                return jsonData;
            }
        }
        catch (Exception ex)
        {
            Console.WriteLine($"錯誤: {ex.Message}");
            err = ex.Message;
        }
        return new BackendUserRightList
        {
            dataRight =null,
            dataTalksRight=null,
            businessServiceTalksIsNotReadCount=0,
            business_id=-1,
            backend_user_id=-1,
            code = "-1",
            message = $"錯誤: {err}"
        };
    }
}
