import 'package:app/screens/conversation/components/message.dart';

import 'korisniciModel.dart';

class Chat {
  final String image, time, message;
  Korisnik sagovornik;
  Chat({
    this.sagovornik,
    this.image,
    this.message,
    this.time,
  });
}
