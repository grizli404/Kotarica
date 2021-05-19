const Korisnici = artifacts.require("Korisnici");

contract('Korisnici', () => {

    it("can create user", async () => {
        const storage = await Korisnici.deployed();

        const tx = await storage.dodajKorisnika("pera.peric@gmail.com", "pera123", "Pera", "Peric", "06123456789", "Atinska 33");
        tx = await storage.dodajKorisnika("laza.lazic@gmail.com", "laza123", "Laza", "Lazic", "06987654321", "Glavna 33");

        console.log(tx);
    })
})