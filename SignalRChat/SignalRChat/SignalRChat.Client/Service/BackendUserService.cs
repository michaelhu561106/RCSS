using SignalRChat.Client.Utility;
using System.Text.Json;
using SignalRChat.Client.Model;
using System.Text;
using static System.Net.WebRequestMethods;


namespace SignalRChat.Client.Service
{
    public class BackendUserService
    {
        private readonly HttpClient _httpClient;
        private readonly IConfiguration _configuration;
        public BackendUserService(HttpClient httpClient, IConfiguration configuration)
        {
            _httpClient = httpClient;
            _configuration = configuration;
        }
        public async Task<BackendUserList> GetBackendUserList(string backend_user_name, string email, int count_per_page, int page)
        {
            string err = "";
            try
            {
                var basePath = $"{_configuration["BaseUri"]}backendusers";  // "http://10.10.10.207:3000/api/businessList";
                var uri = ParameterHelper.BuildUrlWithQueryStringUsingStringConcat(basePath, new Dictionary<string, string>
                {
                    { "page",page.ToString()},
                    { "count_per_page",count_per_page.ToString()},
                    { "backend_user_name",backend_user_name},
                    { "email",email}
                }
                );
                var response = await _httpClient.GetAsync(uri);

                if (response.IsSuccessStatusCode)
                {
                    string data = await response.Content.ReadAsStringAsync();
                    BackendUserList jsonData = JsonSerializer.Deserialize<SignalRChat.Client.Model.BackendUserList>(data);
                    return jsonData;
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine($"錯誤: {ex.Message}");
                err = ex.Message;
            }
            return new SignalRChat.Client.Model.BackendUserList
            {
                data = null,
                code = "-1",
                message = $"錯誤: {err}"
            };
        }
        public async Task<BackendUserRights> GetUserRights(int backend_user_id)
        {
            string err = "";
            try
            {
                var basePath = $"{_configuration["BaseUri"]}backendrights/{backend_user_id}";  // "http://10.10.10.207:3000/api/businessList";
                var uri = basePath;
                var response = await _httpClient.GetAsync(uri);
                if (response.IsSuccessStatusCode)
                {
                    string data = await response.Content.ReadAsStringAsync();
                    BackendUserRights jsonData = JsonSerializer.Deserialize<SignalRChat.Client.Model.BackendUserRights>(data);
                    return jsonData;
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine($"錯誤: {ex.Message}");
                err = ex.Message;
            }
            return new BackendUserRights
            {
                dataBackendUserRights=null,
                code = "-1",
                message = $"錯誤: {err}"
            };
        }
        public async Task<BackendRights> GetBackendRights()
        {
            string err = "";
            try
            {
                var basePath = $"http://10.10.10.207:3000/api/backendrights";  // $"{_configuration["BaseUri"]}backendrights";  // "http://10.10.10.207:3000/api/businessList";
                var uri = basePath;
                var response = await _httpClient.GetAsync(uri);
                if (response.IsSuccessStatusCode)
                {
                    string data = await response.Content.ReadAsStringAsync();
                    BackendRights jsonData = JsonSerializer.Deserialize<SignalRChat.Client.Model.BackendRights>(data);
                    return jsonData;
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine($"錯誤: {ex.Message}");
                err = ex.Message;
            }
            return new BackendRights
            {
                dataBackendRights = null,
                code = "-1",
                message = $"錯誤: {err}"
            };
        }
        public async Task<ResponseStanderd> PostBackendUserList(string backend_user_name, string email, string password, int business_id, string phone, string phone_country, string country_id, int update_backend_user_id)
        {
            string err = "";
            try
            {
                var basePath = $"{_configuration["BaseUri"]}backendusers";  // "http://10.10.10.207:3000/api/businessList";
                var uri = basePath;
                using StringContent jsonContent = new(
                    JsonSerializer.Serialize(new
                    {
                        backend_user_name = backend_user_name,
                        email = email,
                        password = password,
                        business_id = business_id,
                        phone = phone,
                        phone_country = phone_country,
                        country_id = country_id,
                        update_backend_user_id = update_backend_user_id
                    }),
                    Encoding.UTF8,
                    "application/json");
                var response = await _httpClient.PostAsync(uri, jsonContent);
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
        public async Task<UpdateBackendUserList> GetUpdateBackendUserList(int backend_user_id)
        {
            string err = "";
            try
            {
                var basePath = $"{_configuration["BaseUri"]}backendusers/{backend_user_id}";  // "http://10.10.10.207:3000/api/BackendUserList";
                var uri = basePath;
                var response = await _httpClient.GetAsync(uri);

                if (response.IsSuccessStatusCode)
                {
                    string data = await response.Content.ReadAsStringAsync();
                    UpdateBackendUserList jsonData = JsonSerializer.Deserialize<UpdateBackendUserList>(data);
                    return jsonData;
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine($"錯誤: {ex.Message}");
                err = ex.Message;
            }
            return new UpdateBackendUserList
            {
                data = null,
                code = "-1",
                message = $"錯誤: {err}"
            };
        }
        public async Task<ResponseStanderd> PutBackendUserList(int backend_user_id, string backend_user_name, string email, string password, int business_id, string phone, string phone_country, string country_id, int update_backend_user_id)
        {
            string err = "";
            try
            {
                var basePath = $"{_configuration["BaseUri"]}backendusers";  // "http://10.10.10.207:3000/api/businessList";
                var uri = basePath;
                using StringContent jsonContent = new(
                    JsonSerializer.Serialize(new
                    {
                        backend_user_id = backend_user_id,
                        backend_user_name = backend_user_name,
                        email = email,
                        password = password,
                        business_id = business_id,
                        phone = phone,
                        phone_country = phone_country,
                        country_id = country_id,
                        update_backend_user_id = update_backend_user_id
                    }),
                    Encoding.UTF8,
                    "application/json");
                var response = await _httpClient.PutAsync(uri, jsonContent);
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
        public async Task<ResponseStanderd> DeleteBackendUserList(int backend_user_id)
        {
            string err = "";
            try
            {
                var basePath = $"{_configuration["BaseUri"]}backendusers/{backend_user_id}";  // "http://10.10.10.207:3000/api/businessList";
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
        public async Task<ResponseStanderd> PostBackendUserRights(int backend_user_id,List<BackendUserRightsUpdateModel> backendUserRightsUpdateModel)
        {
            string err = "";
            try
            {
                var basePath = $"{_configuration["BaseUri"]}backendrights/{backend_user_id}";  // "http://10.10.10.207:3000/api/businessList";
                var uri = basePath;
                using StringContent jsonContent = new(
                    JsonSerializer.Serialize(new
                    {
                        data = backendUserRightsUpdateModel.ToArray(),
                    }),
                    Encoding.UTF8,
                    "application/json");
                var response = await _httpClient.PostAsync(uri, jsonContent);
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
    }
}
