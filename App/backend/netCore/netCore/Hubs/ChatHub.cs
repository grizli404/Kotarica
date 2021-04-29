using Microsoft.AspNetCore.SignalR;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace netCore.Hubs
{
    public class ChatHub : Hub
    {
        public async Task SendMessage(string from, string to, string message)
        {
            await Clients.All.SendAsync("ReceiveNewMessage", from, to, message, DateTime.Now);
            Console.WriteLine("Primljena je nova poruka od: " + from + ", i on ju je poslao: " + to + " a tekst poruke je: " + message);
        }
    }
}
