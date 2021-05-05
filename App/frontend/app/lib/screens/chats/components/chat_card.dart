import 'package:app/model/chats.dart';
import 'package:flutter/material.dart';

class ChatCard extends StatelessWidget {
  const ChatCard({
    Key key,
    @required this.chat,
    @required this.press,
  }) : super(key: key);

  final Chat chat;
  final VoidCallback press;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: press,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Row(
          children: [
            CircleAvatar(
              radius: 24,
              backgroundImage: AssetImage("assets/images/cookiechoco.jpg"),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "IME NEKO VO NO",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Opacity(
                      opacity: 0.65,
                      child: Text(
                        "Sjedio sam u tramvaju vozio se sam krenuo sam na Ilidzu bio je lep dan bio sam sretan sto postojim i sretan sto sjedim u guzvi vidio sam frenda ma je li to Nedim Nedim jesi li to ti",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Opacity(
              opacity: 0.65,
              child: Text(
                "300 godina",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
