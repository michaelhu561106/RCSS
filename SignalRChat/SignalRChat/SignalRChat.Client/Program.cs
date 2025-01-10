using FirebaseAdmin;
using FluentValidation;
using Google.Apis.Auth.OAuth2;
using Microsoft.AspNetCore.Components.WebAssembly.Hosting;
using SignalRChat.Client.Model;
using SignalRChat.Client.Service;
using SignalRChat.Client.Validator;
using Blazored.SessionStorage;



var builder = WebAssemblyHostBuilder.CreateDefault(args);

builder.Services.AddScoped(sp => new HttpClient { BaseAddress = new Uri("http://10.10.10.207:3000") });
builder.Services.AddScoped<AuthService>();
builder.Services.AddScoped<BusinessService>();
builder.Services.AddScoped<BackendUserService>();
builder.Services.AddScoped<BusinessServiceService>();
builder.Services.AddScoped<BusinessListService>();
builder.Services.AddScoped<BusinessMessagePushService>();
builder.Services.AddTransient<IValidator<BusinessListCreateModel>, BusinessListCreateValidator>();
// Alternatively, use FluentValidation.DependencyInjectionExtensions package (read further down below...)
builder.Services.AddScoped<ChatService>();
builder.Services.AddBlazorBootstrap();
builder.Services.AddBlazoredSessionStorageAsSingleton(config =>
        config.JsonSerializerOptions.WriteIndented = true);

await builder.Build().RunAsync();
