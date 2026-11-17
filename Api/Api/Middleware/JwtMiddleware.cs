namespace PizzariaDesktop.Api.Middleware;

using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Text;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.IdentityModel.Tokens;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;

public static class JwtMiddlewareExtensions
{
    public static IServiceCollection AddJwtAuthentication(this IServiceCollection services, IConfiguration configuration)
    {
        // Lê das mesmas variáveis que o AuthService usa (JWT_* para compatibilidade com Render)
        var secretKey = configuration["JWT_SECRET_KEY"]
                     ?? configuration["JWT_SECRET"]
                     ?? configuration["Jwt:SecretKey"]
                     ?? throw new InvalidOperationException("JWT SecretKey not configured (set JWT_SECRET or JWT_SECRET_KEY)");
        var issuer = configuration["JWT_ISSUER"] ?? configuration["Jwt:Issuer"] ?? "PizzariaDesktop";
        var audience = configuration["JWT_AUDIENCE"] ?? configuration["Jwt:Audience"] ?? "PizzariaDesktopUsers";
        var expiryHours = double.TryParse(configuration["JWT_EXPIRY_HOURS"] ?? configuration["Jwt:ExpiryHours"], out var hours) ? hours : 24;

        var key = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(secretKey));

        services.AddAuthentication(options =>
        {
            options.DefaultAuthenticateScheme = JwtBearerDefaults.AuthenticationScheme;
            options.DefaultChallengeScheme = JwtBearerDefaults.AuthenticationScheme;
        })
        .AddJwtBearer(options =>
        {
            options.TokenValidationParameters = new TokenValidationParameters
            {
                ValidateIssuer = true,
                ValidateAudience = true,
                ValidateLifetime = true,
                ValidateIssuerSigningKey = true,
                ValidIssuer = issuer,
                ValidAudience = audience,
                IssuerSigningKey = key,
                ClockSkew = TimeSpan.Zero,
                NameClaimType = JwtRegisteredClaimNames.Sub,
                RoleClaimType = ClaimTypes.Role
            };

            options.Events = new JwtBearerEvents
            {
                OnAuthenticationFailed = context =>
                {
                    if (context.Exception.GetType() == typeof(SecurityTokenExpiredException))
                    {
                        context.Response.Headers.Append("Token-Expired", "true");
                    }
                    return Task.CompletedTask;
                }
            };
        });

        return services;
    }
}