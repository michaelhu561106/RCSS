using Blazored.SessionStorage;
using FirebaseAdmin;
using FluentValidation;
using Google.Apis.Auth.OAuth2;
using SignalRChat.Client.Model;
using SignalRChat.Client.Pages;
using SignalRChat.Client.Service;
using SignalRChat.Client.Validator;
using SignalRChat.Components;
using System.Text.Json;
using Blazored.SessionStorage;

FirebaseApp.Create(new AppOptions()
{
    Credential = GoogleCredential.FromFile("rcss-eb982-firebase-adminsdk-t4h23-e7ae0ca97a.json")
});

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.
builder.Services.AddRazorComponents()
    .AddInteractiveWebAssemblyComponents()
    .AddInteractiveServerComponents();

builder.Services.AddSignalR();
builder.Services.AddHttpClient();
builder.Services.AddSingleton<SignalRChat.Client.Service.BusinessService>();
builder.Services.AddScoped<AuthService>();
builder.Services.AddScoped<BackendUserService>();
builder.Services.AddScoped<BusinessServiceService>();
builder.Services.AddScoped<BusinessListService>();
builder.Services.AddScoped<BusinessMessagePushService>();
builder.Services.AddTransient<IValidator<BusinessListCreateModel>, BusinessListCreateValidator>();
builder.Services.AddSingleton<SignalRChat.Client.Service.ChatService>();
builder.Services.AddBlazorBootstrap();
//builder.Services.AddBlazoredSessionStorageAsSingleton(config =>
//        config.JsonSerializerOptions.WriteIndented = true);
builder.Services.AddBlazoredSessionStorage(config =>
        config.JsonSerializerOptions.WriteIndented = true);
builder.Services.AddCors(options =>
{
    options.AddPolicy("AllowAll", builder =>
    {
        builder.AllowAnyOrigin()
               .AllowAnyMethod()
               .AllowAnyHeader();
    });
});
builder.Services.AddControllers();

var app = builder.Build();
//app.MapRazorComponents<App>()
//    .AddInteractiveServerRenderMode()
//    .AddInteractiveWebAssemblyRenderMode();
// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseWebAssemblyDebugging();
}
else
{
    app.UseExceptionHandler("/Error", createScopeForErrors: true);
    // The default HSTS value is 30 days. You may want to change this for production scenarios, see https://aka.ms/aspnetcore-hsts.
    app.UseHsts();
}

app.UseHttpsRedirection();

app.UseStaticFiles();
app.UseAntiforgery();
app.UseCors("AllowAll");
app.UseRouting();

app.UseAntiforgery();

app.MapRazorComponents<App>()
    .AddInteractiveWebAssemblyRenderMode()
    .AddAdditionalAssemblies(typeof(SignalRChat.Client._Imports).Assembly);

app.MapHub<SignalRChat.Hubs.ChatHub>("/chathub");
app.MapHub<SignalRChat.Hubs.FriendHub>("/friendhub");
app.MapControllers();

app.Run();
