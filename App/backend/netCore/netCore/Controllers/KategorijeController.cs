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
    [Route("kategorije/")]
    [ApiController]
    public class KategorijeController : ControllerBase
    {
        private readonly IKategorije db;

        public KategorijeController(IKategorije db)
        {
            this.db = db;
        }

        //kategorije/1
        [HttpGet("{id}")]
        public IActionResult dajKategoriju(int id)
        {
            Kategorije k = db.dajKategoriju(id);
            return Ok(k);
        }

        //kategorije/svekategorije
        [Route("sveKategorije")]
        [HttpGet]
        public IActionResult dajSveKategorije()
        {
            IQueryable kategorije = db.dajSveKategorije();
            return Ok(kategorije);
        }
    }
}
