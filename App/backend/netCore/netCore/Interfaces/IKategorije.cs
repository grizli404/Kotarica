using netCore.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace netCore.Interfaces
{
    public interface IKategorije
    {
        public Kategorije dajKategoriju(int id);
        public IQueryable<Kategorije> dajSveKategorije();
        public bool dodajKategoriju(Kategorije k);
        public bool obrisiKategoriju(int id);
    }
}
