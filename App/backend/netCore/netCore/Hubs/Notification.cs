﻿using Microsoft.AspNetCore.SignalR;
using netCore.Data;
using netCore.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace netCore.Hubs
{
    public class Notification : Hub
    {
        private readonly AppDbContext _context;

        public Notification(AppDbContext context)
        {
            _context = context;
        }

        public async Task Notifikacija(string ime, string broj, string adresa, string sta, int kolicina, int kome)
        {
            String message = "" + ime + " je naručio " + kolicina + " komada Vašeg proizvoda " + sta + "\n\nInformacije o isporuci:\nIme = " + ime + "\nBroj telefona = " + broj + "\nAdresa za isporuku = " + adresa;

            Notifications poruka = new Notifications(kome, message);

            _context.Notif.Add(poruka);
            _context.SaveChanges();

            await Clients.All.SendAsync("novaNotifikacija", poruka);
        }

        public IEnumerable<Notifications> GetNotificationsHistory(int id)
        {
            return _context.Notif.Where(n => n.kome == id)
                .AsEnumerable()
                .Reverse()
                .ToList();
        }
    }

    
}
