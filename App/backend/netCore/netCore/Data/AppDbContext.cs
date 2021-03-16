using Microsoft.EntityFrameworkCore;
using netCore.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace netCore.Data
{
    public class AppDbContext : DbContext
    {
        public AppDbContext(DbContextOptions<AppDbContext> options) : base(options) { }

        //-----------<models>----Tabela u db-------------
        public DbSet<Kategorije> Kategorije { get; set; }
        public DbSet<Proizvodi> Proizvodi { get; set; }
    }
}
