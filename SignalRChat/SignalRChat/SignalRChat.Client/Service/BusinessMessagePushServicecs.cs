using Microsoft.AspNetCore.Components.Forms;
using SignalRChat.Client.Model;
using SignalRChat.Client.Utility;
using System.Net.Http.Headers;
using System.Net.Mime;
using System.Text;
using System.Text.Json;

namespace SignalRChat.Client.Service;
public class BusinessMessagePushService
{
    private readonly HttpClient _httpClient;
    private readonly IConfiguration _configuration;
    public BusinessMessagePushService(HttpClient httpClient, IConfiguration configuration)
    {
        _httpClient = httpClient;
        _configuration = configuration;
    }
    public async Task<BusinessMessagePushList> GetBusinessMessagePushList(int business_id,string message_title, string push_start_date_s, string push_start_date_e,int count_per_page, int page)
    {
        string err = "";
        try
        {
            var basePath = $"{_configuration["BaseUri"]}businessmessagepush";  // "http://10.10.10.207:3000/api/businessList";
            var uri = ParameterHelper.BuildUrlWithQueryStringUsingStringConcat(basePath, new Dictionary<string, string>
            {
                { "page",page.ToString()},
                { "count_per_page",count_per_page.ToString()},
                { "business_id",business_id.ToString()},
                { "message_title",message_title},
                { "push_start_date_s",push_start_date_s},
                { "push_start_date_e",push_start_date_e},
            }
            );
            var response = await _httpClient.GetAsync(uri);

            if (response.IsSuccessStatusCode)
            {
                string data = await response.Content.ReadAsStringAsync();
                BusinessMessagePushList jsonData = JsonSerializer.Deserialize<SignalRChat.Client.Model.BusinessMessagePushList>(data);
                return jsonData;
            }
        }
        catch (Exception ex)
        {
            Console.WriteLine($"錯誤: {ex.Message}");
            err = ex.Message;
        }
        return new SignalRChat.Client.Model.BusinessMessagePushList
        {
            data = null,
            code = "-1",
            message = $"錯誤: {err}"
        };
    }
    public async Task<ResponseStanderd> DeleteBusinessMessagePushList(int business_id, int business_message_push_id)
    {
        string err = "";
        try
        {
            var basePath = $"{_configuration["BaseUri"]}businessmessagepush/{business_id}/{business_message_push_id}";  // "http://10.10.10.207:3000/api/businessList";
            var uri = basePath;
            var response = await _httpClient.DeleteAsync(uri);
            if (response.IsSuccessStatusCode)
            {
                string data = await response.Content.ReadAsStringAsync();
                ResponseStanderd jsonData = JsonSerializer.Deserialize<ResponseStanderd>(data);
                return jsonData;
            }
        }
        catch (Exception ex)
        {
            Console.WriteLine($"錯誤: {ex.Message}");
            err = ex.Message;
        }
        return new ResponseStanderd
        {
            code = "-1",
            message = $"錯誤: {err}"
        };
    }
    public async Task<ResponseStanderd> PostBusinessMessagePushList(BusinessMessagePushListCreateModel model)
    {
        string err = "";
        try
        {
            var basePath = $"{_configuration["BaseUri"]}businessmessagepush";  // "http://10.10.10.207:3000/api/businessList";
            var uri = basePath;
            var imageContent = new StreamContent(model.message_image_file[0].OpenReadStream(1024*500));
            //imageContent.Headers.ContentType = MediaTypeHeaderValue.Parse(MediaTypeNames.Image.Jpeg);
            using MultipartFormDataContent multipartContent = new();
            multipartContent.Add(imageContent, "message_image_file", model.message_image_file[0].Name);
            multipartContent.Add(new StringContent(model.business_id.ToString(), Encoding.UTF8, MediaTypeNames.Text.Plain), "business_id");
            multipartContent.Add(new StringContent(model.message_title, Encoding.UTF8, MediaTypeNames.Text.Plain), "message_title");
            multipartContent.Add(new StringContent(model.message_content, Encoding.UTF8, MediaTypeNames.Text.Plain), "message_content");
            multipartContent.Add(new StringContent(model.message_url, Encoding.UTF8, MediaTypeNames.Text.Plain), "message_url");
            multipartContent.Add(new StringContent(model.push_start_date.ToString("yyyy-MM-dd hh:mm:ss.fffffff"), Encoding.UTF8, MediaTypeNames.Text.Plain), "push_start_date");
            multipartContent.Add(new StringContent(model.push_end_date.ToString("yyyy-MM-dd hh:mm:ss.fffffff"), Encoding.UTF8, MediaTypeNames.Text.Plain), "push_end_date");
            multipartContent.Add(new StringContent(model.backend_user_id.ToString(), Encoding.UTF8, MediaTypeNames.Text.Plain), "backend_user_id");
            var response = await _httpClient.PostAsync(uri, multipartContent);
            if (response.IsSuccessStatusCode)
            {
                string data = await response.Content.ReadAsStringAsync();
                ResponseStanderd jsonData = JsonSerializer.Deserialize<ResponseStanderd>(data);
                return jsonData;
            }
        }
        catch (Exception ex)
        {
            Console.WriteLine($"錯誤: {ex.Message}");
            err = ex.Message;
        }
        return new ResponseStanderd
        {
            code = "-1",
            message = $"錯誤: {err}"
        };
    }
    public async Task<UpdateMessagePush> GetUpdateMessagePush(int business_id, int business_message_push_id)
    {
        string err = "";
        try
        {
            var basePath = $"{_configuration["BaseUri"]}businessmessagepush/{business_id}/{business_message_push_id}";  // "http://10.10.10.207:3000/api/businessList";
            var uri = basePath;
            var response = await _httpClient.GetAsync(uri);

            if (response.IsSuccessStatusCode)
            {
                string data = await response.Content.ReadAsStringAsync();
                UpdateMessagePush jsonData = JsonSerializer.Deserialize<UpdateMessagePush>(data);
                return jsonData;
            }
        }
        catch (Exception ex)
        {
            Console.WriteLine($"錯誤: {ex.Message}");
            err = ex.Message;
        }
        return new UpdateMessagePush
        {
            data = null,
            code = "-1",
            message = $"錯誤: {err}"
        };
    }
    public async Task<ResponseStanderd> PutBusinessMessagePushList(BusinessMessagePushListUpdateModel model,int business_id, int business_message_push_id)
    {
        string err = "";
        try
        {
            var basePath = $"{_configuration["BaseUri"]}businessmessagepush";  // "http://10.10.10.207:3000/api/businessList";
            var uri = basePath;
            using MultipartFormDataContent multipartContent = new();
            if (model.message_image_file != null)
            {
                var imageContent = new StreamContent(model.message_image_file[0].OpenReadStream(1024 * 500));
                //imageContent.Headers.ContentType = MediaTypeHeaderValue.Parse(MediaTypeNames.Image.Jpeg);
                multipartContent.Add(imageContent, "message_image_file", model.message_image_file[0].Name);
            }
            multipartContent.Add(new StringContent(business_id.ToString(), Encoding.UTF8, MediaTypeNames.Text.Plain), "business_id");
            multipartContent.Add(new StringContent(business_message_push_id.ToString(), Encoding.UTF8, MediaTypeNames.Text.Plain), "business_message_push_id");
            multipartContent.Add(new StringContent(model.message_title, Encoding.UTF8, MediaTypeNames.Text.Plain), "message_title");
            multipartContent.Add(new StringContent(model.message_content, Encoding.UTF8, MediaTypeNames.Text.Plain), "message_content");
            if(model.message_image == null)
            {
                model.message_image = "";
            }
            multipartContent.Add(new StringContent(model.message_image, Encoding.UTF8, MediaTypeNames.Text.Plain), "message_image");
            multipartContent.Add(new StringContent(model.message_url, Encoding.UTF8, MediaTypeNames.Text.Plain), "message_url");
            multipartContent.Add(new StringContent(model.push_start_date.ToString("yyyy-MM-dd hh:mm:ss.fffffff"), Encoding.UTF8, MediaTypeNames.Text.Plain), "push_start_date");
            multipartContent.Add(new StringContent(model.push_end_date.ToString("yyyy-MM-dd hh:mm:ss.fffffff"), Encoding.UTF8, MediaTypeNames.Text.Plain), "push_end_date");
            multipartContent.Add(new StringContent(model.backend_user_id.ToString(), Encoding.UTF8, MediaTypeNames.Text.Plain), "backend_user_id");
            var response = await _httpClient.PutAsync(uri, multipartContent);
            if (response.IsSuccessStatusCode)
            {
                string data = await response.Content.ReadAsStringAsync();
                ResponseStanderd jsonData = JsonSerializer.Deserialize<ResponseStanderd>(data);
                return jsonData;
            }
            else
            {

            }
        }
        catch (Exception ex)
        {
            Console.WriteLine($"錯誤: {ex.Message}");
            err = ex.Message;
        }
        return new ResponseStanderd
        {
            code = "-1",
            message = $"錯誤: {err}"
        };
    }
}
