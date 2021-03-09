using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Routing;
using netCore.Interfaces;
using netCore.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace netCore.Controllers
{
    [Route("[controller]")]
    [ApiController]
    public class StudentsController : ControllerBase
    {
        private readonly IStudent db;

        public StudentsController(IStudent db)
        {
            this.db = db;
        }

        // Get: Students/5
        [HttpGet("{id}")]
        public IActionResult getStudent(int id)
        {
            Student s = db.GetStudent(id);

            return Ok(s);
        }

        // Get: Students/prikaziStudente
        //[Route("prikaziStudente")]
        [HttpGet]
        public IActionResult getStudents()
        {
            IQueryable<Student> students = db.GetStudents();

            return Ok(students);
        }
    }
}
