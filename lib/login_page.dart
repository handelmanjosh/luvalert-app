import 'package:app/components/login_page_components.dart';
import 'package:app/parent_page.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  final void Function(PageState state) changeState;
  const LoginPage(this.changeState, {super.key});
  @override
  State<LoginPage> createState() => _LoginPageState(changeState);
}

class _LoginPageState extends State<LoginPage> {
  final void Function(PageState state) changeState;
  _LoginPageState(this.changeState);
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
        child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            HeartIcon(),
            const Text(
              'LuvAlert',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFF282840),
                fontSize: 60,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w800,
                height: 0,
              ),
            ),
            const Text(
              '10m radius love detector ',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFF8A8CA8),
                fontSize: 15,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w800,
                height: 0,
              ),
            ),
            const SizedBox(height: 30),
            const GhostLoveIcon(),
            const SizedBox(height: 40),
            const Text(
              '#1 app to confess and find <3',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFF8A8CA8),
                fontSize: 20,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w200,
                height: 0,
              ),
            ),
            const SizedBox(height: 20),
            InstagramLoginButton(
              () => changeState(PageState.login)
            ),
          ],
        )
      )
      )

    );
  }
}