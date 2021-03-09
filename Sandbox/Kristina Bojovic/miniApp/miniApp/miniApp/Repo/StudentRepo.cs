using netCore.Data;
using netCore.Interfaces;
using netCore.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace netCore.Repo
{
    public class StudentRepo : IStudent
    {
        private readonly ApplicatinoDbContext db;

        public StudentRepo(ApplicatinoDbContext db)
        {
            this.db = db;
        }

        public Student GetStudent(int id)
        {
            return db.Student.Find(id);
        }

        public IQueryable<Student> GetStudents()
        {
            return db.Student;
        }
    }
}
