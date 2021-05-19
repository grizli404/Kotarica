Pokretanje aplikacije:

Prvo treba pokrenuti Ganache.Onda uci u podesavanja i truffle project dodati truffle-config.js fajl koji se nalazi u projektu. Nakon toga uci u karticu SERVER i tamo promeniti host na neku javnu adresu Ethernet ili WI-FI. Kada to izmenimo treba da restartujemo Ganache. Time smo zavrsili podesavanja u Ganache-u.

Onda otvorimo kod i u lib/model treba otvoriti kategorijeModel.dart, korisniciModel.dart, proizvodiModel.dart i oceneModel.dart i u njima promenljive rpcUrl i wsUrl. Treba da se stavi url koji Vam stoji u ganache-u. Pored toga u fajlovima korisniciModel.dart i oceneModel.dart treba promeniti private key. Treba staviti privatni kljuc prvog novcanika na listi koji vam stoji u Ganache-u. Kada to zavrsimo treba da udjemo u truffle-config.js i tamo u networks/development pa tu takodje treba promeniti host i postaviti na host koji stoji u Ganache-u. Time smo zavrsili sva podesavanja. 

Ostalo nam je samo da pokrenemo aplikaciju. Ako zelimo da je pokrenemo na web-u onda u terminalu kucamo komandu flutter run -d chorme, a ako zelimo da otvorimo preko emulatora, otvorimo emulator i u terminalu pokrenemo komandu flutter run.