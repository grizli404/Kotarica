using netCore.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace netCore.Interfaces
{
    public interface IStudent
    {
        public Student GetStudent(int id);

        public IQueryable<Student> GetStudents();
    }
}
