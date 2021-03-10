using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using netCoreProba.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace netCoreProba.Controllers
{
    [Route("[controller]")]
    [ApiController]
    public class StudentController : ControllerBase
    {
        private readonly IStudent db;

        public StudentController(IStudent db)
        {
            this.db = db;
        }

        [HttpGet("{id}")]
        public IActionResult dajStudenta(int id)
        {
            Student rez = db.GetStudent(id);

            return Ok(rez);
        }

        [HttpGet]
        public IActionResult dajSveStudente()
        {
            IQueryable<Student> rez = db.GetStudents;

            return Ok(rez);
        }

        [Route("obrisi/{id}")]
        [HttpGet]
        public IActionResult obrisi(int id)
        {
            db.Delete(id);

            return Ok();
        }

        [Route("dodaj/indeks={indeks}/imePrezime={imePrezime}")]
        [HttpGet]
        public IActionResult dodaj(string indeks, string imePrezime)
        {
            db.Insert(indeks, imePrezime);

            return Ok("Lepo sam pozvao");
        }
    }
}
