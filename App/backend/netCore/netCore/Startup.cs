using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.HttpsPolicy;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using Microsoft.Extensions.Logging;
using Microsoft.IdentityModel.Tokens;
using netCore.Data;
using netCore.Handlers;
using netCore.Interfaces;
using netCore.Models;
using netCore.SocketsManager;

namespace netCore
{
    public class Startup
    {
        public Startup(IConfiguration configuration)
        {
            Configuration = configuration;
        }

        public IConfiguration Configuration { get; }

        // This method gets called by the runtime. Use this method to add services to the container.
        public void ConfigureServices(IServiceCollection services)
        {
            //Povezali sa bazom
            services.AddDbContext<AppDbContext>(options => options.UseSqlite("Data Source=Kotarica.db"));

            //Sve veze
            //services.AddTransient<IKategorije, KategorijeRepo>();
            //services.AddTransient<IProizvodi, ProizvodiRepo>();

            services.AddControllers();

            /*************** POCETAK TOKENA ************** */
            var key = "Mod privatni kljuc";

            services.AddAuthentication(x =>
           {
               x.DefaultAuthenticateScheme = JwtBearerDefaults.AuthenticationScheme;
               x.DefaultChallengeScheme = JwtBearerDefaults.AuthenticationScheme;
           }).AddJwtBearer(x =>
           {
               x.RequireHttpsMetadata = false;
               x.SaveToken = true;
               x.TokenValidationParameters = new TokenValidationParameters
               {
                   ValidateIssuerSigningKey = true,
                   IssuerSigningKey = new SymmetricSecurityKey(Encoding.ASCII.GetBytes(key)),
                   ValidateIssuer = false,
                   ValidateAudience = false
               };
           });

            services.AddSingleton<IJWTAuthenticationManager>(new JWTAuthenticationManager(key));
            /*************** KRAJ TOKENA ************** */

            /*************** POCETAK CHAT-a ************** */
            services.AddWebSocketManager();
            /*************** KRAJ CHAT-a ************** */
        }

        // This method gets called by the runtime. Use this method to configure the HTTP request pipeline.
        public void Configure(IApplicationBuilder app, IWebHostEnvironment env, IServiceProvider serviceProvider)
        {
            if (env.IsDevelopment())
            {
                app.UseDeveloperExceptionPage();
            }

            app.UseHttpsRedirection();

            app.UseRouting();

            app.UseAuthorization();

            app.UseEndpoints(endpoints =>
            {
                endpoints.MapControllers();
            });


            /*************** POCETAK CHAT-a ************** */
            app.UseWebSockets();
            //OVDE IMAMO PROBLEM VALJDA TREBA DA UKLJUCIMO SOCKETSEXTENSION.CS IZ SOCKETSMANAGER
            app.MapSockets("/ws", serviceProvider.GetService<WebSocketMessageHandler>());
            app.UseStaticFiles();
            /*************** KRAJ CHAT-a ************** */
        }
    }
}
