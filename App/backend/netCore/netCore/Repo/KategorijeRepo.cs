using netCore.Data;
using netCore.Interfaces;
using netCore.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace netCore.Repo
{
    public class KategorijeRepo : IKategorije
    {
        private readonly AppDbContext db;

        public KategorijeRepo(AppDbContext db)
        {
            this.db = db;
        }

        public Kategorije dajKategoriju(int id)
        {
            return db.Kategorije.Find(id);
        }

        public IQueryable<Kategorije> dajSveKategorije()
        {
            return db.Kategorije;
        }

        public bool dodajKategoriju(Kategorije k)
        {
            db.Kategorije.Add(k);
            return true;
        }

        public bool obrisiKategoriju(int id)
        {
            try
            {
                var kategorija = db.Kategorije.Find(id);
                if(kategorija == null)
                {
                    return false;
                }
                db.Kategorije.Remove(kategorija);
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
