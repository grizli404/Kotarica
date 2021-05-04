using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace netCore.Models
{
    public class Message
    {
        public int Id { get; set; }
        public int Ko { get; set; }
        public int Kome { get; set; }
        public string Sta { get; set; }
        public DateTime Kada { get; set; }
    }
}
