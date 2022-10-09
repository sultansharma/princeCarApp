import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newhandy/api_service/provider/mainprovider.dart';
import 'package:newhandy/helper/common_widgets.dart';
import 'package:newhandy/helper/models/messageModel.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatefulWidget {
  final String name;
  final String rid;
  const ChatScreen({Key key, this.name, this.rid}) : super(key: key);
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController messageTextEditController = TextEditingController();

 // MessageModal message;
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    // message = MessageModal();
    // message.conversationId = conversation.id;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MainProvider>(
      builder: (_, data, __) => Scaffold(
          // backgroundColor: Colors.black,
          appBar: AppBar(
            backgroundColor: Colors.white,
            leading: IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: Icon(Icons.arrow_back_ios),
            ),
            title: Text(
              '${widget.name}',
              style:
                  GoogleFonts.montserrat(color: Colors.black.withOpacity(0.60)),
            ),
            centerTitle: true,
          ),
          body: data.chatData == null
              ? Container(
                  height: 300,
                  child: Center(
                    child: ntext("Loading..", clr: Colors.black),
                  ),
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                        child: ListView.builder(
                      controller: _scrollController,
                      padding: EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      itemCount: data.chatData.chatData.length,
                      itemBuilder: (context, index) =>
                          data.chatData.chatData[index].userId !=
                                  data.u_data.data.id
                              ? FriendMessageCard(
                                  name: widget.name,
                                  msg: data.chatData.chatData[index].body,
                                  date: data.chatData.chatData[index].createdAt,
                                )
                              : MyMessageCard(
                                  message: data.chatData.chatData[index].body,
                                ),
                    )),
                    // FriendMessageCard(),
                    // MyMessageCard(),
                    Container(
                      padding: EdgeInsets.all(3),
                      margin: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                          color: Colors.redAccent,
                          borderRadius: BorderRadius.circular(32)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          SizedBox(
                            width: 12,
                          ),
                          Expanded(
                              child: TextField(
                            style: TextStyle(color: Colors.white),
                            controller: messageTextEditController,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Type your message...',
                                hintStyle: TextStyle(color: Colors.white)),
                          )),
                          InkWell(
                            onTap: () async {
                              FocusScope.of(context).requestFocus(FocusNode());

                              if (messageTextEditController.text.isEmpty)
                                return;
                              // message.body = messageTextEditController.text.trim();
                              // print(message.toJson());
                              await Provider.of<MainProvider>(context,
                                      listen: false)
                                  .sendMsg(widget.rid,
                                      messageTextEditController.text);
                              messageTextEditController.clear();
                              _scrollController.jumpTo(
                                  _scrollController.position.maxScrollExtent +
                                      23);
                            },
                            child: Container(
                                padding: EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.send,
                                  color: Colors.white,
                                )),
                          ),
                        ],
                      ),
                    ),
                  ],
                )),
    );
  }
}

class FriendMessageCard extends StatelessWidget {
  final String name;
  final String msg;
  final String date;

  const FriendMessageCard({Key key, this.name, this.msg, this.date})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(bottom: 12, right: 50),
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
            color: Colors.deepOrange.withOpacity(0.30),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(28),
              topRight: Radius.circular(28),
              bottomRight: Radius.circular(28),
            )),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Text(
                '${msg}',
              ),
            ),
          ],
        ));
  }
}

class MyMessageCard extends StatelessWidget {
  final String message;
  final String date;
  const MyMessageCard({Key key, this.message, this.date}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      margin: EdgeInsets.only(bottom: 12, left: 50),
      decoration: BoxDecoration(
          color: Colors.redAccent.withOpacity(0.50),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(28),
            topRight: Radius.circular(28),
            bottomLeft: Radius.circular(28),
          )),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Text(
              '${message}',
            ),
          ),
        ],
      ),
    );
  }
}
