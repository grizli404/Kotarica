using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using netCore.Interfaces;
using netCore.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace netCore.Controllers
{
    [Route("proizvodi/")]
    [ApiController]
    public class ProizvodiController : ControllerBase
    {
        private readonly IProizvodi db;

        public ProizvodiController(IProizvodi db)
        {
            this.db = db;
        }

        //proizvodi/1
        [HttpGet("{id}")]
        public IActionResult dajProizvod(int id)
        {
            Proizvodi p = db.dajProizvod(id);
            return Ok(p);
        }

        //proizvodi/sviProizvodi
        [Route("sviProizvodi")]
        [HttpGet]
        public IActionResult dajSveProizvode()
        {
            IQueryable proizvodi = db.dajSveProizvode();

            return Ok(proizvodi);
        }

        //proizvodi
    }
}
