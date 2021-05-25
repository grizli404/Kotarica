using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace netCore.Models
{
    public class Notifications
    {
        public int kome { get; set; }
        public string poruka { get; set; }

        public Notifications(int kome, string poruka)
        {
            this.kome = kome;
            this.poruka = poruka;
        }
    }
}
