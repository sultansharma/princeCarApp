import 'package:flutter/material.dart';
import 'package:newhandy/helper/common_widgets.dart';

class Chat extends StatefulWidget {
  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            automaticallyImplyLeading: false,
            backgroundColor: Colors.white,
            centerTitle: false,
            title: ntext(
              "Notifications",
              size: 18,
              w: FontWeight.w500,
              clr: Colors.black.withOpacity(0.80),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              height: 400,
              child: Center(
                child: ntext("No Notifications Yet",
                    clr: Colors.black.withOpacity(0.70)),
              ),
            ),
          )
        ],
      ),
    );
  }
}
