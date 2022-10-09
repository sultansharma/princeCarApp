import 'package:flutter/material.dart';
import 'package:newhandy/api_service/provider/mainprovider.dart';
import 'package:newhandy/chat/chat_screen.dart';
import 'package:newhandy/helper/common_widgets.dart';
import 'package:newhandy/helper/constant.dart';
import 'package:provider/provider.dart';

class Chat extends StatefulWidget {
  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var provider = Provider.of<MainProvider>(context);
    return Scaffold(
        backgroundColor: Colors.grey[50],
        appBar: AppBar(
          primary: true,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          centerTitle: false,
          elevation: 0,
          title: ntext(
            "Chats",
            size: 18,
            w: FontWeight.w500,
            clr: Colors.black.withOpacity(0.80),
          ),
        ),
        body: provider.chatsData == null
            ? Container(
                height: 300,
                child: Center(
                  child: ntext("Loading..", clr: Colors.black),
                ))
            : provider.chatsData.conversationsData.length == 0
                ? Container(
                    height: 300,
                    child: Center(
                      child: ntext("No Chats", clr: Colors.black),
                    ))
                : ListView.builder(
                    padding:
                        EdgeInsets.only(top: SizeConfig.blockSizeVertical * 2),
                    itemCount: provider.chatsData.conversationsData.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                          onTap: () {
                            print("object");
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (_) => ChatScreen(
                                      name: provider.chatsData
                                          .conversationsData[index].user.name,
                                      rid: provider.chatsData
                                          .conversationsData[index].user.userId,
                                    )));
                            Provider.of<MainProvider>(context, listen: false)
                                .getChat(provider
                                    .chatsData.conversationsData[index].id);
                          },
                          child: c_card(
                              provider
                                  .chatsData.conversationsData[index].user.name,
                              provider.chatsData.conversationsData[index]
                                  .messages.last.body,
                              "img"));
                    },

                    // ConversationCard(
                    //     conversation: provider.concersations[index],
                    //     onTap: () {

                    //     }),
                  ));
  }

  c_card(String name, String msg, String img) {
    return Container(
      margin: EdgeInsets.only(bottom: 10, left: 15, right: 15),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          border: Border.all(color: Colors.grey[300])),
      child: ListTile(
        // onTap: onTap,
        leading: ClipOval(
          child: Image.network(
              'https://s3.amazonaws.com/37assets/svn/765-default-avatar.png'),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              name.toString(),
              style: TextStyle(
                color: Colors.red,
                fontSize: 18,
              ),
            ),
            Text(
              "2 min ago",
              //'${timeago.format(DateTime.parse(conversation.messages.last.createdAt))}',
              style: TextStyle(
                color: Colors.white.withOpacity(0.7),
                fontSize: 14,
              ),
            )
          ],
        ),
        subtitle: Text(msg),
      ),
    );
  }
}
