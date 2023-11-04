using Microsoft.IdentityModel.Tokens;
using System.IdentityModel.Tokens.Jwt;
using System.Net;
using System.Text;

namespace Inventarios.Token
{
    public class JwtService
    {
        private string securekey = "this is a very secure key";
        public string? jwt = "";
        public string? username = "";
        public string? login = "";
        public string? password = "";
        public string? programas = "";
        public string? tiposdedocumento = "";

        public int Id { get; set; }

        public string Generate(int id)
        {
            var simetricSecurityKey = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(securekey));
            var credentials = new SigningCredentials(simetricSecurityKey, algorithm: SecurityAlgorithms.HmacSha256Signature);
            var header = new JwtHeader(credentials);
            var payload = new JwtPayload(issuer: id.ToString(), audience: null, claims: null, notBefore: null, expires: DateTime.Today.AddDays(1));
            var securityToken = new JwtSecurityToken(header, payload);

            return new JwtSecurityTokenHandler().WriteToken(securityToken);
        }

        public bool UserAthenticated()
        {

          
            bool authenticated = true;
            var token = this.Verify(this.jwt);
            int userid = -1;
            if (token.Issuer.IsNullOrEmpty())  authenticated= false;
            if (!token.Issuer.IsNullOrEmpty())  userid = int.Parse(token.Issuer);
            if (userid != ((int)this.Id)) authenticated = false;
            return authenticated;
        }

        public JwtSecurityToken Verify(string? jwt)
        {

            try
            {
                var tokenHanlder = new JwtSecurityTokenHandler();

                byte[] key = Encoding.ASCII.GetBytes(securekey);
                tokenHanlder.ValidateToken(jwt, new TokenValidationParameters
                {
                    IssuerSigningKey = new SymmetricSecurityKey(key),
                    ValidateIssuerSigningKey = true,
                    ValidateIssuer = false,
                    ValidateAudience = false
                }, out SecurityToken validatedToken);
                return (JwtSecurityToken)validatedToken;
            } 
            catch(Exception ) {

                return new JwtSecurityToken();
            
            }
           

        }

      
    }
}