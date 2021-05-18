using Microsoft.AspNetCore.SignalR;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace netCore.Hubs
{
    public class Notification : Hub
    {
        public async Task Notifikacija(string ime, string broj, string adresa, string sta, int kolicina, int kome)
        {
            String message = "" + ime + " je naručio " + kolicina + " komada Vašeg proizvoda " + sta + "\n\nInformacije o isporuci:\nIme = " + ime + "\nBroj telefona = " + broj + "\nAdresa za isporuku = " + adresa;

            Notif poruka = new Notif(kome, message);

            await Clients.All.SendAsync("novaNotifikacija", poruka);
        }
    }

    public class Notif
    {
        public int kome { get; set; }
        public string poruka { get; set; }

        public Notif(int kome, string poruka)
        {
            this.kome = kome;
            this.poruka = poruka;
        }
    }
}
