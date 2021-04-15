using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace netCore.Interfaces
{
    public interface IJWTAuthenticationManager
    {
        string Authenticate(string username, string password);
    }
}
