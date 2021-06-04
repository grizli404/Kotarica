import 'package:app/model/chats.dart';
import 'package:app/screens/conversation/conversation_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

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
      onTap: () => {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return ConversationScreen(
            sagovornik: chat.sagovornik,
          );
        }))
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Row(
          children: [
            SizedBox(
              width: 25,
              child: AspectRatio(
                aspectRatio: 1,
                child: Container(
                    clipBehavior: Clip.hardEdge,
                    // clipBehavior: Clip.hardEdge,
                    child: Image.network(
                      "http://147.91.204.116:11099/ipfs/" +
                          chat.sagovornik.slika,
                      errorBuilder: (context, error, stackTrace) {
                        return SvgPicture.asset(
                            Theme.of(context).colorScheme == ColorScheme.dark()
                                ? "assets/icons/shopping-basket-dark.svg"
                                : "assets/icons/shopping-basket.svg");
                      },
                      fit: BoxFit.cover,
                    ),
                    decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      borderRadius: BorderRadius.circular(20),
                    )),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      chat.sagovornik.ime,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Opacity(
                      opacity: 0.65,
                      child: Text(
                        chat.message,
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
                chat.time,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
