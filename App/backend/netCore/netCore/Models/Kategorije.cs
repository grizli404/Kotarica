using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace netCore.Models
{
    public class Kategorije
    {
        public int id { get; set; }
        public int idRoditelja { get; set; }
        public string naziv { get; set; }
    }
}
