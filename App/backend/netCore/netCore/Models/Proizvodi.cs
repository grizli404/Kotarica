using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace netCore.Models
{
    public class Proizvodi
    {
        public int id { get; set; }
        public int idKorisnika { get; set; }
        public int idKategorije { get; set; }
        public string naziv { get; set; }
        public int kolicina { get; set; }

    }
}
