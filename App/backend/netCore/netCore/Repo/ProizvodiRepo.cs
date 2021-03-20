using netCore.Data;
using netCore.Interfaces;
using netCore.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace netCore.Repo
{
    public class ProizvodiRepo : IProizvodi
    {
        //Instanca baze
        private readonly AppDbContext db;

        public ProizvodiRepo(AppDbContext db)
        {
            this.db = db;
        }

        public Proizvodi dajProizvod(int id)
        {
            return db.Proizvodi.Find(id);
        }

        public IQueryable<Proizvodi> dajSveProizvode()
        {
            return db.Proizvodi;
        }

        public bool dodajProizvod(Proizvodi p)
        {
            db.Proizvodi.Add(p);
            return true;
        }

        public bool obrisiProizvod(int id)
        {
            try
            {
                var proizvod = db.Proizvodi.Find(id);
                if (proizvod == null)
                {
                    return false;
                }
                db.Proizvodi.Remove(proizvod);
                db.SaveChanges();
            }
            catch
            {

                throw;
            }

            return true;
        }
    }
}
