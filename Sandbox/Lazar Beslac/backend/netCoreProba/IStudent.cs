using netCoreProba.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace netCoreProba
{
    public interface IStudent
    {
        //Vraca sve studente
        public IQueryable<Student> GetStudents { get; }

        //Vraca jednog studenta
        public Student GetStudent(int id);

        //Dodaje novog studenta
        public void Insert(string indeks, string imePrezime);

        //Brise studenta sa zadatim id-em
        public void Delete(int id);

    }
}
