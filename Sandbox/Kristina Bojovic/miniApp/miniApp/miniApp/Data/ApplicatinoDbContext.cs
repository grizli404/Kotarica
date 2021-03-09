using Microsoft.EntityFrameworkCore;
using netCore.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace netCore.Data
{
    public class ApplicatinoDbContext : DbContext
    {
        public ApplicatinoDbContext(DbContextOptions<ApplicatinoDbContext> options) : base(options) { }

        public DbSet<Student> Student { get; set; }
    }
}
