using Microsoft.AspNetCore.SignalR;
using Microsoft.EntityFrameworkCore;
using netCore.Data;
using netCore.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace netCore.Hubs
{
    public class ChatHub : Hub
    {
        private readonly AppDbContext _context;

        public ChatHub(AppDbContext context)
        {
            _context = context;
        }

        public async Task SendPrivate(int id, int ko, int kome, string sta)
        {
            if (!string.IsNullOrEmpty(sta.Trim()))
            {
                Message message = new Message()
                {
                    Ko = ko,
                    Kome = kome,
                    Sta = sta,
                    Kada = DateTime.Now
                };

                _context.Message.Add(message);
                _context.SaveChanges();

                await Clients.Client(kome.ToString()).SendAsync("newMessage", message);
                await Clients.Caller.SendAsync("newMessage", id);
            }
        }

        public IEnumerable<Message> GetMessageHistory(int ko, int kome)
        {
            return _context.Message.Where(mes => (mes.Ko == ko && mes.Kome == kome) || (mes.Ko == kome && mes.Kome == ko))
                .OrderByDescending(mes => mes.Kada)
                .AsEnumerable()
                .Reverse()
                .ToList();
        }

        public async Task Online(int ko)
        {
            await Clients.All.SendAsync("UserOnline", ko);
        }

        public async Task Offline(int ko)
        {
            await Clients.All.SendAsync("UserOffline", ko);
        }

        public async Task SendMessage(string from, string to, string message)
        {
            await Clients.All.SendAsync("ReceiveMessage", from, to, message, DateTime.Now);
            Console.WriteLine("Primljena je nova poruka od: " + from + ", i on ju je poslao: " + to + " a tekst poruke je: " + message);
        }
    }
}
