

import 'package:app/components/search_bar.dart';
import 'package:app/components/user_modal.dart';
import 'package:app/scripts/user_data.dart';
import 'package:flutter/material.dart';

class DiscoverPage extends StatefulWidget {
  final List<UserData> _users;
  final String username;
  final List<String> crushes;
  final void Function(String name, bool b) onSelect;
  const DiscoverPage(this._users, this.username, this.crushes, this.onSelect, {super.key});
  @override
  State<DiscoverPage> createState() => _DiscoverPageState(_users);
}

class _DiscoverPageState extends State<DiscoverPage> {
  List<UserData> _tempUsers;
  _DiscoverPageState(this._tempUsers);
  @override
  void initState() {
    super.initState();
    debugPrint("crushes");
    print(widget.crushes);
    for (int i = 0; i < widget.crushes.length; i++) {
      for (int j = 0; j < _tempUsers.length; j++) {
        if (_tempUsers[j].username == widget.crushes[i]) {
          _tempUsers[j].selected = true;
        }
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const CircleAvatar(
              backgroundColor: Colors.grey,
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text(
                  'Hi there',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF8A8CA8),
                    fontSize: 10,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  widget.username,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Color(0xFF282840),
                    fontSize: 25,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ]
            ),
            const SizedBox(width: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: ShapeDecoration(
                color: const Color(0xFFFFAEBC),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                )
              ),
              child: const Row(
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
            )
          ]
        ),
        const SizedBox(height: 20),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          decoration: ShapeDecoration(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          child: const Text(
            '🔥 \$9.99/month for 100 REQUESTS (& more!)',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFF8A8CA8),
              fontSize: 15,
              fontStyle: FontStyle.italic,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w700,
              height: 0,
            ),
          ),
        ),
        const SizedBox(height: 20),
        Container(
            alignment: Alignment.centerLeft,
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
            child: const Text(
              'Discovery',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFF282840),
                fontSize: 30,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w800,
                height: 0,
              ),
            ),
        ),
        const SizedBox(height: 20),
        const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

          ]
        ),
        const SizedBox(height: 20),
        Container(
            width: double.infinity,
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                const Text(
                  'Select your crush',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF282840),
                    fontSize: 30,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w800,
                    height: 0,
                  ),
                ),
                const SizedBox(height: 10),
                MySearchBar(
                  onChanged: (String value) {
                    setState(() {
                      _tempUsers = widget._users.where((UserData user) => user.username.contains(value)).toList();
                    });
                  }, 
                  onReset: () {
                    setState(() {
                      _tempUsers = widget._users;
                    });
                  }
                ),
                Expanded(
                  child: ListView.separated(
                    itemCount: _tempUsers.length,
                    itemBuilder: (BuildContext context, int index) {
                      return UserModal(_tempUsers[index], (bool status) {
                        widget.onSelect(_tempUsers[index].username, status);
                      });
                    },
                    separatorBuilder: (context, index) => const SizedBox(height: 5),
                  )
                )
              ]
            )
          )
      ]
    );
  }
}