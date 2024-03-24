import 'dart:async';
import 'dart:convert';

import 'package:app/home/detect_page.dart';
import 'package:app/home/discover_page.dart';
import 'package:app/home/settings_page.dart';
import 'package:app/parent_page.dart';
import 'package:app/responses.dart';
import 'package:app/scripts/user_data.dart';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:geolocator/geolocator.dart';

class HomePage extends StatefulWidget {
  final void Function(PageState state) changeState;
  final List<UserData> _users;
  final String username;
  const HomePage(this.changeState, this._users, this.username, {super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

enum HomeState {
  discover,
  detect,
  settings
}
class _HomePageState extends State<HomePage> {
  late final WebSocketChannel channel;
  HomeState _state = HomeState.discover;
  late List<String> crushes;
  late List<String> crushees;
  _HomePageState();
  @override
  void initState() {
    super.initState();
    crushes = List<String>.empty();
    crushees = List<String>.empty();
    channel = WebSocketChannel.connect(Uri.parse("ws://localhost:8080?username=${widget.username}"));
    channel.stream.listen((message) {
      debugPrint("called");
      var data = jsonDecode(message);
      print(data);
      switch(data["type"]) {
        case "UserData":
          var userData = UserDataMessage.fromJson(data);
          setState(() {
            crushees = userData.crushees;
            crushes = userData.crushes;
          });
          break;
        case "NearbyData":
          break;
        default:
          debugPrint("Invalid type");
          break;
      }
    });
    _determinePosition(); // start position reporting stream
  }
  void _reportLocation(double latitude, double longitude) {
    var data = jsonEncode({
      "type": "PositionUpdate",
      "latitude": latitude,
      "longitude": longitude
    });
    channel.sink.add(data);
  }
  void _determinePosition() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    LocationPermission permission = await Geolocator.checkPermission();

    while (!serviceEnabled ||
        permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      permission = await Geolocator.requestPermission();
    }
    StreamSubscription<Position> positionStream = Geolocator.getPositionStream(
        locationSettings: const LocationSettings(
      accuracy: LocationAccuracy.best,
      distanceFilter: 0,
    )).listen((Position position) {
      _reportLocation(position.latitude, position.longitude);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/login_background.png'),
            fit: BoxFit.cover,
          )
        ),
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.only(top: 20, bottom: 20),
        child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          if (_state == HomeState.discover)
            DiscoverPage(widget._users, widget.username, crushes, (String name, bool status) {
              var data = jsonEncode({
                "type": "CrushModify",
                "name": name,
                "status": status,
              });
              channel.sink.add(data);
            }, key: ValueKey(crushes.length))
          else if (_state == HomeState.detect) 
            DetectPage(widget._users, widget.username)
          else 
            SettingsPage(widget.username),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextButton.icon(
                icon: Icon(
                  Icons.explore_outlined,
                  color: _state == HomeState.discover ? Colors.black : const Color(0xFF8A8CA8),
                ),
                label: Text(
                  'Discover',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: _state == HomeState.discover ? Colors.black : const Color(0xFF8A8CA8),
                    fontSize: 15,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w600,
                  ),
                ),
                style: TextButton.styleFrom(
                  backgroundColor: Colors.transparent, 
                  foregroundColor: Colors.grey,
                ),
                onPressed: () {
                  setState(() {
                    _state = HomeState.discover;
                  });
                },
              ),
              TextButton.icon(
                icon: Icon(
                  Icons.chat_outlined,
                  color: _state == HomeState.detect ? Colors.black : const Color(0xFF8A8CA8),
                ),
                label: Text(
                  'Detect',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: _state == HomeState.detect ? Colors.black : const Color(0xFF8A8CA8),
                    fontSize: 15,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w600,
                  ),
                ),
                style: TextButton.styleFrom(
                  backgroundColor: Colors.transparent, 
                  foregroundColor: Colors.grey,
                ),
                onPressed: () {
                  setState(() {
                    _state = HomeState.detect;
                  });
                }, 
              ),
              TextButton.icon(
                icon: Icon(
                  Icons.settings_outlined,
                  color: _state == HomeState.settings ? Colors.black : const Color(0xFF8A8CA8),
                ),
                label: Text(
                  'Settings',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: _state == HomeState.settings ? Colors.black : const Color(0xFF8A8CA8),
                    fontSize: 15,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w600,
                  ),
                ),
                style: TextButton.styleFrom(
                  backgroundColor: Colors.transparent, 
                  foregroundColor: Colors.grey,
                ),
                onPressed: () {
                  setState(() {
                    _state = HomeState.settings;
                  });
                },
              )
            ]
          )
        ]
      )
      )
      )
    );
  }
}