using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace netCore.Models
{
    public class Notification
    {
        public int NotificationID { get; set; }
        public int kome { get; set; }
        public string poruka { get; set; }

        public Notification(int kome, string poruka)
        {
            this.kome = kome;
            this.poruka = poruka;
        }
    }
}
