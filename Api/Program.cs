using Microsoft.AspNetCore.Builder;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using Microsoft.Extensions.Diagnostics.HealthChecks;
using PizzariaDesktop.Services;
using PizzariaDesktop.Api.Middleware;

var builder = WebApplication.CreateBuilder(args);

// Carrega .env se existir
DotNetEnv.Env.Load();

// Configura serviços usando a mesma extensão do Desktop
builder.Services.AddPizzariaServices(builder.Configuration);

// Health Checks
builder.Services.AddHealthChecks()
    .AddDbContextCheck<PizzariaDesktop.Data.PizzariaDbContext>();

var app = builder.Build();

// Configura pipeline HTTP
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI(c => c.SwaggerEndpoint("/swagger/v1/swagger.json", "Pizzaria API v1"));
}

// Health check endpoint
app.MapHealthChecks("/health");

app.UseAuthentication();
app.UseAuthorization();

app.MapControllers();

app.Run();