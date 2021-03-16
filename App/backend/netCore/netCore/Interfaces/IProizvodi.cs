using netCore.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace netCore.Interfaces
{
    public interface IProizvodi
    {
        public Proizvodi dajProizvod(int id);
        public IQueryable<Proizvodi> dajSveProizvode();
        public bool dodajProizvod(Proizvodi p);
        public bool obrisiProizvod(int id);

    }
}
