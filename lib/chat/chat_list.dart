import 'package:doccure_patient/constanst/strings.dart';
import 'package:flutter/material.dart';

class ChatListScreen extends StatefulWidget {

  final GlobalKey<ScaffoldState> scaffold;
  const ChatListScreen(this.scaffold, {Key? key}) : super(key: key);

  @override
  State<ChatListScreen> createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: BLUECOLOR,
      child: Column(
        children: [
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
            width: MediaQuery.of(context).size.width,
            height: 90.0,
            color: BLUECOLOR,
            child: Column(children: [
              const SizedBox(
                height: 25.0,
              ),
              Row(
                children: [
                  Flexible(
                    child: Row(
                      children: [
                        GestureDetector(
                            onTap: () =>
                                widget.scaffold.currentState!.openDrawer(),
                            child: Icon(Icons.menu, color: Colors.white)),
                        const SizedBox(
                          width: 10.0,
                        ),
                        Text('Chat',
                            style:
                                getCustomFont(size: 18.0, color: Colors.white))
                      ],
                    ),
                  ),
                  Icon(
                    Icons.notifications_active,
                    color: Colors.white,
                  )
                ],
              )
            ]),
          ),
          Expanded(child: Container(
            decoration: BoxDecoration(
              color: Color(0xFFF6F6F6),
              borderRadius: BorderRadius.only(topLeft: Radius.circular(30.0), 
              topRight: Radius.circular(30.0))
            ),
          ))
        ]));
  }
}