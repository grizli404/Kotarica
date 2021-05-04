using AutoMapper;
using Microsoft.AspNetCore.SignalR;
using Microsoft.EntityFrameworkCore;
using netCore.Data;
using netCore.Models;
using netCore.ViewModels;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace netCore.Hubs
{
    public class ChatHub : Hub
    {
        //public readonly static List<MessageViewModel>

        private readonly AppDbContext _context;
        private readonly IMapper _mapper;

        public ChatHub(AppDbContext context)
        {
            _context = context;
        }

        public async Task SendPrivate(string ko, string kome, string sta)
        {
            if (!string.IsNullOrEmpty(sta.Trim()))
            {

                //Ako poslata poruka nije prazna
                var messageViewModel = new MessageViewModel()
                {
                    Ko = ko,
                    Kome = kome,
                    Sta = sta,
                    Kada = DateTime.Now.ToLongTimeString()
                };

                await Clients.Client(kome).SendAsync("newMessage", messageViewModel);
                await Clients.Caller.SendAsync("newMessage", messageViewModel);
            }
        }

        public IEnumerable<MessageViewModel> GetMessageHistory(int ko, int kome)
        {
            var messageHistory = _context.Message.Where(mes => (mes.Ko == ko && mes.Kome == kome) || (mes.Ko == kome && mes.Kome == ko))
                .Include(mes => mes.Ko)
                .Include(mes => mes.Kome)
                .OrderByDescending(mes => mes.Kada)
                .Take(50)
                .AsEnumerable()
                .Reverse()
                .ToList();

            return _mapper.Map<IEnumerable<Message>, IEnumerable<MessageViewModel>>(messageHistory);
        }

        public async Task Online(string ko)
        {
            await Clients.All.SendAsync("UserOnline", ko);
        }

        public async Task Offline(string ko)
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
