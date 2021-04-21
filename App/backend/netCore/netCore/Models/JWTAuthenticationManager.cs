using Microsoft.IdentityModel.Tokens;
using netCore.Interfaces;
using System;
using System.Collections.Generic;
using System.IdentityModel.Tokens.Jwt;
using System.Linq;
using System.Security.Claims;
using System.Text;
using System.Threading.Tasks;

namespace netCore.Models
{
    public class JWTAuthenticationManager : IJWTAuthenticationManager
    {
        //Ovde mora da se napravi da se ove stvari cuvaju u bazi ovo je samo test
        private readonly IDictionary<string, string> users = new Dictionary<string, string>
        {
            {"mika.mikic@gmail.com", "mika123"},
            {"mika.mikic", "mikica" }
        };

        private readonly string key;

        public JWTAuthenticationManager(string key)
        {
            this.key = key;
        }

        public string Authenticate(string username, string password)
        {
            if(!users.Any(u => u.Key == username && u.Value == password))
            {
                return null;
            }

            var tokenHandler = new JwtSecurityTokenHandler();
            var tokenKey = Encoding.ASCII.GetBytes(key);
            var tokenDescriptor = new SecurityTokenDescriptor
            {
                Subject = new ClaimsIdentity(new Claim[]
                {
                    new Claim(ClaimTypes.Name, username)
                }),
                Expires = DateTime.UtcNow.AddHours(1),
                SigningCredentials = new SigningCredentials(
                    new SymmetricSecurityKey(tokenKey),
                    SecurityAlgorithms.HmacSha256Signature)
            };
            var token = tokenHandler.CreateToken(tokenDescriptor);
            return tokenHandler.WriteToken(token);
        }
    }
}
