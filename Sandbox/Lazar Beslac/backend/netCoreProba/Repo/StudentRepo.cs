using netCoreProba.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace netCoreProba.Repo
{
    public class StudentRepo : IStudent
    {
        private readonly ApplicationDbContext db;

        public StudentRepo(ApplicationDbContext _db)
        {
            db = _db;
        }

        public IQueryable<Student> GetStudents
        {
            get
            {
                return db.student;
            }
        }

        public void Delete(int id)
        {
            try
            {
                var student = db.student.Find(id);
                if (student == null) return;
                db.student.Remove(student);
                db.SaveChanges();
            }
            catch
            {
                throw;
            }
        }

        public Student GetStudent(int id)
        {
            return  db.student.Find(id);
        }

        
        public void Insert(string indeks, string imePrezime)
        {
            /*
            Student
            db.Students.Add(new);
            */
        }
        
    }
}
