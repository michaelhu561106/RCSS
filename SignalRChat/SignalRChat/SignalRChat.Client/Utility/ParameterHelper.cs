namespace SignalRChat.Client.Utility
{
    public class ParameterHelper
    {        
            public static string BuildUrlWithQueryStringUsingStringConcat(
                string basePath, Dictionary<string, string> queryParams)
            {
                var queryString = string.Join("&", queryParams.Select(kvp => $"{kvp.Key}={kvp.Value}"));

                return $"{basePath}?{queryString}";
            }
    }
}
