import 'package:doccure_patient/constanst/strings.dart';
import 'package:flutter/material.dart';

class ProfileSettings extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffold;
  const ProfileSettings(this.scaffold, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Color(0xFFf6f6f6),
        child: Column(children: [
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
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
                            onTap: () => scaffold.currentState!.openDrawer(),
                            child: Icon(Icons.menu, color: Colors.white)),
                        const SizedBox(
                          width: 10.0,
                        ),
                        Text('Profile',
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
            margin: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20.0)
            ),
            child: Column(children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Text('Basic Information', style: getCustomFont(size: 17.0, color: Colors.black45),)),
            const SizedBox(height: 20.0,),
                CircleAvatar(
                  radius: 35.0,
                  backgroundColor: Colors.grey,
                  backgroundImage: AssetImage('assets/imgs/1.png'),
                ),
                 const SizedBox(height: 30.0,),
            ]),
          ))
        ]));
  }
}
