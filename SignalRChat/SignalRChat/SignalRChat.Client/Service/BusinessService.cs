using Microsoft.Extensions.Configuration;
using SignalRChat.Client.Model;
using SignalRChat.Client.Utility;
using System.Linq;
using System.Net.Http.Json;
using System.Text;
using System.Text.Json;
using System.Text.Json.Serialization;
using static System.Net.WebRequestMethods;

namespace SignalRChat.Client.Service
{
    public class BusinessService
    {
        private readonly HttpClient _httpClient;
        private readonly IConfiguration _configuration;

        public BusinessService(HttpClient httpClient, IConfiguration configuration)
        {
            _httpClient = httpClient;
            _configuration = configuration;
        }

        public class BusinessServiceData
        {
            public bool is_backend_user_read { get; set; }
            public string user_uuid { get; set; }
            public int business_id { get; set; }
            public string business_name { get; set; }
            public string business_service_name { get; set; }
            public string user_name { get; set; }
            public string business_service_talks_is_not_read_count { get; set; }
        }
        public class BusinessServiceList
        {
            public BusinessServiceData[] data { get; set; }
            public int code { get; set; }
            public string message { get; set; }
        }

        public async Task<BusinessServiceList> GetBusinessServiceChatRoomList(int backendUserId)
        {
            try
            {
                var uri = $"http://10.10.10.207:3000/api/businessServiceListAndIsNotReadCountBack/{backendUserId}";
                var response = await _httpClient.GetAsync(uri);

                if (response.IsSuccessStatusCode)
                {
                    string data = await response.Content.ReadAsStringAsync();
                    BusinessServiceList jsonData = JsonSerializer.Deserialize<BusinessServiceList>(data);

                    foreach (var businessServiceData in jsonData.data)
                    {
                        Console.WriteLine(businessServiceData.business_name);
                    }

                    return jsonData;
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine($"錯誤: {ex.Message}");
            }

            return new BusinessServiceList();
        }
        //public async Task<BusinessList> GetBusinessList(string address, string phone, string email, string business_name, int business_type_id, int count_per_page, int page)
        //{
        //    string err = "";
        //    try
        //    {
        //        var basePath = $"{_configuration["BaseUri"]}businessList";  // "http://10.10.10.207:3000/api/businessList";
        //        var uri = ParameterHelper.BuildUrlWithQueryStringUsingStringConcat(basePath, new Dictionary<string, string>
        //        {
        //            { "page",page.ToString()},
        //            { "count_per_page",count_per_page.ToString()},
        //            { "business_type_id",business_type_id.ToString()},
        //            { "business_name",business_name},
        //            { "email",email},
        //            { "phone",phone},
        //            { "address",address},
        //        }
        //        );
        //        var response = await _httpClient.GetAsync(uri);

        //        if (response.IsSuccessStatusCode)
        //        {
        //            string data = await response.Content.ReadAsStringAsync();
        //            BusinessList jsonData = JsonSerializer.Deserialize<BusinessList>(data);

        //            //foreach (var businessServiceData in jsonData.dataBusinessList)
        //            //{
        //            //    Console.WriteLine(businessServiceData.business_name);
        //            //}

        //            return jsonData;
        //        }
        //    }
        //    catch (Exception ex)
        //    {
        //        Console.WriteLine($"錯誤: {ex.Message}");
        //        err = ex.Message;
        //    }
        //    return new BusinessList
        //    {
        //        dataBusinessList = null,
        //        dataBusinessType = null,
        //        code = "-1",
        //        message = $"錯誤: {err}"
        //    };
        //}
        //public async Task<SignalRChat.Client.Model.BusinessServiceList> GetBusinessServiceList(string business_service_name, int business_id, int count_per_page, int page)
        //{
        //    string err = "";
        //    try
        //    {
        //        var basePath = $"{_configuration["BaseUri"]}businessServiceList";  // "http://10.10.10.207:3000/api/businessList";
        //        var uri = ParameterHelper.BuildUrlWithQueryStringUsingStringConcat(basePath, new Dictionary<string, string>
        //        {
        //            { "page",page.ToString()},
        //            { "count_per_page",count_per_page.ToString()},
        //            { "business_id",business_id.ToString()},
        //            { "business_service_name",business_service_name}
        //        }
        //        );
        //        var response = await _httpClient.GetAsync(uri);

        //        if (response.IsSuccessStatusCode)
        //        {
        //            string data = await response.Content.ReadAsStringAsync();
        //            SignalRChat.Client.Model.BusinessServiceList jsonData = JsonSerializer.Deserialize<SignalRChat.Client.Model.BusinessServiceList>(data);
        //            return jsonData;
        //        }
        //    }
        //    catch (Exception ex)
        //    {
        //        Console.WriteLine($"錯誤: {ex.Message}");
        //        err = ex.Message;
        //    }
        //    return new SignalRChat.Client.Model.BusinessServiceList
        //    {
        //        data = null,
        //        code = "-1",
        //        message = $"錯誤: {err}"
        //    };
        //}
        //public async Task<SignalRChat.Client.Model.BackendUserList> GetBackendUserList(string backend_user_name, string email, int count_per_page, int page)
        //{
        //    string err = "";
        //    try
        //    {
        //        var basePath = $"{_configuration["BaseUri"]}backendusers";  // "http://10.10.10.207:3000/api/businessList";
        //        var uri = ParameterHelper.BuildUrlWithQueryStringUsingStringConcat(basePath, new Dictionary<string, string>
        //        {
        //            { "page",page.ToString()},
        //            { "count_per_page",count_per_page.ToString()},
        //            { "backend_user_name",backend_user_name},
        //            { "email",email}
        //        }
        //        );
        //        var response = await _httpClient.GetAsync(uri);

        //        if (response.IsSuccessStatusCode)
        //        {
        //            string data = await response.Content.ReadAsStringAsync();
        //            SignalRChat.Client.Model.BackendUserList jsonData = JsonSerializer.Deserialize<SignalRChat.Client.Model.BackendUserList>(data);
        //            return jsonData;
        //        }
        //    }
        //    catch (Exception ex)
        //    {
        //        Console.WriteLine($"錯誤: {ex.Message}");
        //        err = ex.Message;
        //    }
        //    return new SignalRChat.Client.Model.BackendUserList
        //    {
        //        data = null,
        //        code = "-1",
        //        message = $"錯誤: {err}"
        //    };
        //}
        //public async Task<List<DataBusinessType>?> GetBusinessType()
        //{
        //    string err = "";
        //    try
        //    {
        //        var basePath = $"{_configuration["BaseUri"]}businessType"; //"http://10.10.10.207:3000/api/businessType";
        //        var uri = basePath;
        //        var response = await _httpClient.GetAsync(uri);

        //        if (response.IsSuccessStatusCode)
        //        {
        //            string data = await response.Content.ReadAsStringAsync();
        //            BusinessType jsonData = JsonSerializer.Deserialize<BusinessType>(data);
        //            return jsonData.data;
        //        }
        //    }
        //    catch (Exception ex)
        //    {
        //        Console.WriteLine($"錯誤: {ex.Message}");
        //        err = ex.Message;
        //    }
        //    return new List<DataBusinessType>();
        //}
        public async Task<List<DataCountryCode>?> GetCountryCode()
        {
            string err = "";
            try
            {
                var basePath = $"{_configuration["BaseUri"]}countrycode"; //"http://10.10.10.207:3000/api/businessType";
                var uri = basePath;
                var response = await _httpClient.GetAsync(uri);

                if (response.IsSuccessStatusCode)
                {
                    string data = await response.Content.ReadAsStringAsync();
                    CountryCode jsonData = JsonSerializer.Deserialize<CountryCode>(data);
                    return jsonData.data.ToList<DataCountryCode>();
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine($"錯誤: {ex.Message}");
                err = ex.Message;
            }
            return new List<DataCountryCode>();
        }
        //public async Task<ResponseStanderd> PostBusinessList(string address, string phone, string email, string business_name, int business_type_id, int backend_user_id, string business_url)
        //{
        //    string err = "";
        //    try
        //    {
        //        var basePath = $"{_configuration["BaseUri"]}businessList";  // "http://10.10.10.207:3000/api/businessList";
        //        var uri = basePath;
        //        using StringContent jsonContent = new(
        //            JsonSerializer.Serialize(new
        //            {
        //                business_name = business_name,
        //                business_type = business_type_id,
        //                business_url = business_url,
        //                email = email,
        //                phone= phone,
        //                address= address,
        //                backend_user_id= backend_user_id
        //            }),
        //            Encoding.UTF8,
        //            "application/json");                
        //        var response = await _httpClient.PostAsync(uri, jsonContent);
        //        if (response.IsSuccessStatusCode)
        //        {
        //            string data = await response.Content.ReadAsStringAsync();
        //            ResponseStanderd jsonData = JsonSerializer.Deserialize<ResponseStanderd>(data);



        //            return jsonData;
        //        }
        //    }
        //    catch (Exception ex)
        //    {
        //        Console.WriteLine($"錯誤: {ex.Message}");
        //        err = ex.Message;
        //    }
        //    return new ResponseStanderd
        //    {
        //        code = "-1",
        //        message = $"錯誤: {err}"
        //    };
        //}
        //public async Task<ResponseStanderd> PostBusinessServiceList(int business_id, string business_service_name, int backend_user_id)
        //{
        //    string err = "";
        //    try
        //    {
        //        var basePath = $"{_configuration["BaseUri"]}businessservicelist";  // "http://10.10.10.207:3000/api/businessList";
        //        var uri = basePath;
        //        using StringContent jsonContent = new(
        //            JsonSerializer.Serialize(new
        //            {
        //                business_id = business_id,
        //                business_service_name = business_service_name,
        //                backend_user_id = backend_user_id
        //            }),
        //            Encoding.UTF8,
        //            "application/json");
        //        var response = await _httpClient.PostAsync(uri, jsonContent);
        //        if (response.IsSuccessStatusCode)
        //        {
        //            string data = await response.Content.ReadAsStringAsync();
        //            ResponseStanderd jsonData = JsonSerializer.Deserialize<ResponseStanderd>(data);
        //            return jsonData;
        //        }
        //    }
        //    catch (Exception ex)
        //    {
        //        Console.WriteLine($"錯誤: {ex.Message}");
        //        err = ex.Message;
        //    }
        //    return new ResponseStanderd
        //    {
        //        code = "-1",
        //        message = $"錯誤: {err}"
        //    };
        //}
        //public async Task<ResponseStanderd> PostBackendUserList(string backend_user_name, string email, string password, int business_id, string phone, string phone_country, string country_id, int update_backend_user_id)
        //{
        //    string err = "";
        //    try
        //    {
        //        var basePath = $"{_configuration["BaseUri"]}backendusers";  // "http://10.10.10.207:3000/api/businessList";
        //        var uri = basePath;
        //        using StringContent jsonContent = new(
        //            JsonSerializer.Serialize(new
        //            {
        //                backend_user_name = backend_user_name,
        //                email = email,
        //                password = password,
        //                business_id = business_id,
        //                phone = phone,
        //                phone_country = phone_country,
        //                country_id = country_id,
        //                update_backend_user_id = update_backend_user_id
        //            }),
        //            Encoding.UTF8,
        //            "application/json");
        //        var response = await _httpClient.PostAsync(uri, jsonContent);
        //        if (response.IsSuccessStatusCode)
        //        {
        //            string data = await response.Content.ReadAsStringAsync();
        //            ResponseStanderd jsonData = JsonSerializer.Deserialize<ResponseStanderd>(data);
        //            return jsonData;
        //        }
        //    }
        //    catch (Exception ex)
        //    {
        //        Console.WriteLine($"錯誤: {ex.Message}");
        //        err = ex.Message;
        //    }
        //    return new ResponseStanderd
        //    {
        //        code = "-1",
        //        message = $"錯誤: {err}"
        //    };
        //}
        //public async Task<UpdateBusinessList> GetUpdateBusinessList(int business_id)
        //{
        //    string err = "";
        //    try
        //    {
        //        var basePath = $"{_configuration["BaseUri"]}businesslist/{business_id}";  // "http://10.10.10.207:3000/api/businessList";
        //        var uri = basePath;
        //        var response = await _httpClient.GetAsync(uri);

        //        if (response.IsSuccessStatusCode)
        //        {
        //            string data = await response.Content.ReadAsStringAsync();
        //            UpdateBusinessList jsonData = JsonSerializer.Deserialize<UpdateBusinessList>(data);
        //            return jsonData;
        //        }
        //    }
        //    catch (Exception ex)
        //    {
        //        Console.WriteLine($"錯誤: {ex.Message}");
        //        err = ex.Message;
        //    }
        //    return new UpdateBusinessList
        //    {
        //        dataBusinessList = null,
        //        dataBusinessType = null,
        //        code = "-1",
        //        message = $"錯誤: {err}"
        //    };
        //}
        //public async Task<UpdateBackendUserList> GetUpdateBackendUserList(int backend_user_id)
        //{
        //    string err = "";
        //    try
        //    {
        //        var basePath = $"{_configuration["BaseUri"]}backendusers/{backend_user_id}";  // "http://10.10.10.207:3000/api/BackendUserList";
        //        var uri = basePath;
        //        var response = await _httpClient.GetAsync(uri);

        //        if (response.IsSuccessStatusCode)
        //        {
        //            string data = await response.Content.ReadAsStringAsync();
        //            UpdateBackendUserList jsonData = JsonSerializer.Deserialize<UpdateBackendUserList>(data);
        //            return jsonData;
        //        }
        //    }
        //    catch (Exception ex)
        //    {
        //        Console.WriteLine($"錯誤: {ex.Message}");
        //        err = ex.Message;
        //    }
        //    return new UpdateBackendUserList
        //    {
        //        data = null,
        //        code = "-1",
        //        message = $"錯誤: {err}"
        //    };
        //}
        //public async Task<ResponseStanderd> PutBusinessList(int business_id, string address, string phone, string email, string business_name, int business_type_id, int backend_user_id, string business_url)
        //{
        //    string err = "";
        //    try
        //    {
        //        var basePath = $"{_configuration["BaseUri"]}businessList";  // "http://10.10.10.207:3000/api/businessList";
        //        var uri = basePath;
        //        using StringContent jsonContent = new(
        //            JsonSerializer.Serialize(new
        //            {
        //                business_name = business_name,
        //                business_type = business_type_id,
        //                business_url = business_url,
        //                email = email,
        //                phone = phone,
        //                address = address,
        //                backend_user_id = backend_user_id,
        //                business_id = business_id
        //            }),
        //            Encoding.UTF8,
        //            "application/json");
        //        var response = await _httpClient.PutAsync(uri, jsonContent);
        //        if (response.IsSuccessStatusCode)
        //        {
        //            string data = await response.Content.ReadAsStringAsync();
        //            ResponseStanderd jsonData = JsonSerializer.Deserialize<ResponseStanderd>(data);
        //            return jsonData;
        //        }
        //    }
        //    catch (Exception ex)
        //    {
        //        Console.WriteLine($"錯誤: {ex.Message}");
        //        err = ex.Message;
        //    }
        //    return new ResponseStanderd
        //    {
        //        code = "-1",
        //        message = $"錯誤: {err}"
        //    };
        //}
        //public async Task<ResponseStanderd> PutBackendUserList(int backend_user_id, string backend_user_name, string email, string password, int business_id, string phone, string phone_country, string country_id,int update_backend_user_id)
        //{
        //    string err = "";
        //    try
        //    {
        //        var basePath = $"{_configuration["BaseUri"]}backendusers";  // "http://10.10.10.207:3000/api/businessList";
        //        var uri = basePath;
        //        using StringContent jsonContent = new(
        //            JsonSerializer.Serialize(new
        //            {
        //                backend_user_id = backend_user_id,
        //                backend_user_name = backend_user_name,
        //                email = email,
        //                password = password,
        //                business_id = business_id,
        //                phone = phone,
        //                phone_country = phone_country,
        //                country_id = country_id,
        //                update_backend_user_id = update_backend_user_id
        //            }),
        //            Encoding.UTF8,
        //            "application/json");
        //        var response = await _httpClient.PutAsync(uri, jsonContent);
        //        if (response.IsSuccessStatusCode)
        //        {
        //            string data = await response.Content.ReadAsStringAsync();
        //            ResponseStanderd jsonData = JsonSerializer.Deserialize<ResponseStanderd>(data);
        //            return jsonData;
        //        }
        //    }
        //    catch (Exception ex)
        //    {
        //        Console.WriteLine($"錯誤: {ex.Message}");
        //        err = ex.Message;
        //    }
        //    return new ResponseStanderd
        //    {
        //        code = "-1",
        //        message = $"錯誤: {err}"
        //    };
        //}
        //public async Task<ResponseStanderd> DeleteBusinessList(int business_id)
        //{
        //    string err = "";
        //    try
        //    {
        //        var basePath = $"{_configuration["BaseUri"]}businessList/{business_id}";  // "http://10.10.10.207:3000/api/businessList";
        //        var uri = basePath;
        //        //using StringContent jsonContent = new(
        //        //    JsonSerializer.Serialize(new {                        
        //        //        business_id = business_id
        //        //    }),
        //        //    Encoding.UTF8,
        //        //    "application/json");
        //        var response = await _httpClient.DeleteAsync(uri);
        //        if (response.IsSuccessStatusCode)
        //        {
        //            string data = await response.Content.ReadAsStringAsync();
        //            ResponseStanderd jsonData = JsonSerializer.Deserialize<ResponseStanderd>(data);
        //            return jsonData;
        //        }
        //    }
        //    catch (Exception ex)
        //    {
        //        Console.WriteLine($"錯誤: {ex.Message}");
        //        err = ex.Message;
        //    }
        //    return new ResponseStanderd
        //    {
        //        code = "-1",
        //        message = $"錯誤: {err}"
        //    };
        //}
        //public async Task<ResponseStanderd> DeleteBusinessServiceList(int business_id, string business_service_name)
        //{
        //    string err = "";
        //    try
        //    {
        //        var basePath = $"{_configuration["BaseUri"]}businessservicelist/{business_id}/{business_service_name}";  // "http://10.10.10.207:3000/api/businessList";
        //        var uri = basePath;
        //        //using StringContent jsonContent = new(
        //        //    JsonSerializer.Serialize(new {                        
        //        //        business_id = business_id
        //        //    }),
        //        //    Encoding.UTF8,
        //        //    "application/json");
        //        var response = await _httpClient.DeleteAsync(uri);
        //        if (response.IsSuccessStatusCode)
        //        {
        //            string data = await response.Content.ReadAsStringAsync();
        //            ResponseStanderd jsonData = JsonSerializer.Deserialize<ResponseStanderd>(data);
        //            return jsonData;
        //        }
        //    }
        //    catch (Exception ex)
        //    {
        //        Console.WriteLine($"錯誤: {ex.Message}");
        //        err = ex.Message;
        //    }
        //    return new ResponseStanderd
        //    {
        //        code = "-1",
        //        message = $"錯誤: {err}"
        //    };
        //}
        //public async Task<ResponseStanderd> DeleteBackendUserList(int backend_user_id)
        //{
        //    string err = "";
        //    try
        //    {
        //        var basePath = $"{_configuration["BaseUri"]}backendusers/{backend_user_id}";  // "http://10.10.10.207:3000/api/businessList";
        //        var uri = basePath;
        //        //using StringContent jsonContent = new(
        //        //    JsonSerializer.Serialize(new {                        
        //        //        business_id = business_id
        //        //    }),
        //        //    Encoding.UTF8,
        //        //    "application/json");
        //        var response = await _httpClient.DeleteAsync(uri);
        //        if (response.IsSuccessStatusCode)
        //        {
        //            string data = await response.Content.ReadAsStringAsync();
        //            ResponseStanderd jsonData = JsonSerializer.Deserialize<ResponseStanderd>(data);
        //            return jsonData;
        //        }
        //    }
        //    catch (Exception ex)
        //    {
        //        Console.WriteLine($"錯誤: {ex.Message}");
        //        err = ex.Message;
        //    }
        //    return new ResponseStanderd
        //    {
        //        code = "-1",
        //        message = $"錯誤: {err}"
        //    };
        //}
    }
}
