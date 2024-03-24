

import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  final String username;
  const SettingsPage(this.username, {Key? key}) : super(key: key);
  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const CircleAvatar(
          radius: 50,
          backgroundColor: Colors.grey,
        ),
        const Text(
          'Benjamin Chen',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Color(0xFF282840),
            fontSize: 30,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w800,
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: ShapeDecoration(
            color: const Color(0xFFFFAEBC),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            )
          ),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(
                Icons.favorite,
                color: Colors.white,
                size: 20,
              ),
              Text(
                '  3',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ]
          )
        ),
        const SizedBox(height: 60),
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.55,
          padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
          decoration: const ShapeDecoration(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40),
                topRight: Radius.circular(40),
              ),
            ),
          ),
          child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: <Widget>[
              const Positioned(
                top: -75,
                left: 0,
                right: 0,
                child: Image(
                  image: AssetImage("assets/ghost_blue.png"),
                  width: 80,
                  height: 80,
                )
              ),
              Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text(
                    'Account Info',
                    style: TextStyle(
                      color: Color(0xFF282840),
                      fontSize: 30,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Phone number',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF8A8CA8),
                      fontSize: 15,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w700,
                      height: 0,
                    ),
                  ),
                  const Text(
                    '+929 690 3254',
                    style: TextStyle(
                      color: Color(0xFF282840),
                      fontSize: 25,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w700,
                      height: 0,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Username',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF8A8CA8),
                      fontSize: 15,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w700,
                      height: 0,
                    ),
                  ), 
                  Text(
                    widget.username,
                    style: const TextStyle(
                      color: Color(0xFF282840),
                      fontSize: 25,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w700,
                      height: 0,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Membership',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF8A8CA8),
                      fontSize: 15,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w700,
                      height: 0,
                    ),
                  ), 
                  const Text(
                    'Basic',
                    style: TextStyle(
                      color: Color(0xFF282840),
                      fontSize: 25,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w700,
                      height: 0,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Crush Setting',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF8A8CA8),
                      fontSize: 15,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w700,
                      height: 0,
                    ),
                  ), 
                  const Text(
                    'N/A',
                    style: TextStyle(
                      color: Color(0xFF282840),
                      fontSize: 25,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w700,
                      height: 0,
                    ),
                  ),
                  const SizedBox(height: 20),
                  
                  Expanded(
                    child: Center(
                      child: TextButton(
                        onPressed: () {

                        },
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 120, vertical: 10),
                          backgroundColor: const Color(0xFFF7F7F9),
                          foregroundColor: Colors.grey,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          )
                        ),
                        child: const Text(
                          'Log out',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xFFFF5353),
                            fontSize: 15,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      )
                    ) 
                  )      
                ]
              )
              ),
            ]
          )
        )
      ]
    );
  }
}