import 'package:flutter/material.dart';

class HeartIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      decoration: ShapeDecoration(
        color: const Color(0xFF515255),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        )
      ),
      child: const Center(
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Icon(
              Icons.favorite,
              color: Color(0xffe0a4ad),
              size: 80,
            ),
            Icon(
              Icons.favorite,
              color: Color(0xfff4c0c8),
              size: 70,
            ),
            Icon(
              Icons.favorite,
              color: (Colors.white),
              size: 40,
            )
          ],
        )
      )
    );
  }
}

class GhostLoveIcon extends StatelessWidget {
  const GhostLoveIcon({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        const Image(
          image: AssetImage("assets/dating_location.png"), 
          width: 200,
          height: 200,
        ),
        Stack(
          alignment: Alignment.center,
  children: <Widget>[
    Transform(
      alignment: Alignment.center,
      // Combining rotation and translation for the first image
      transform: Matrix4.identity()
        ..rotateZ(-0.4) // Rotation in radians
        ..translate(-80.0, -40, 0), // Translation in pixels
      child: const Image(
        image: AssetImage("assets/ghost_green.png"),
        width: 150,
        height: 150,
      ),
    ),
    Transform(
      alignment: Alignment.center,
      // Adjust these values for the third image
      transform: Matrix4.identity()
        ..rotateZ(0.4) // Rotation in radians
        ..translate(80.0, -40, 0), // Translation in pixels
      child: const Image(
        image: AssetImage("assets/ghost_red.png"),
        width: 150,
        height: 150,
      ),
    ),
    Transform(
      alignment: Alignment.center,
      // Adjust these values for the second image
      transform: Matrix4.identity(), // Translation in pixels
      child: const Image(
        image: AssetImage("assets/ghost_purple.png"),
        width: 150,
        height: 150,
      ),
    ),
  ],
        )
      ],
    );
  }
}
class InstagramLoginButton extends StatelessWidget {
  final VoidCallback onPressed;
  const InstagramLoginButton(this.onPressed, {super.key});
  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      icon: Image.asset(
        'assets/instagram_logo.png',
        width: 16,
        height: 16,
      ),
      label: const Text(
            'Log in with Instagram',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFF282840),
              fontSize: 15,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w600,
              height: 0,
            ),
      ),
      style: TextButton.styleFrom(
        backgroundColor: Colors.white, 
        foregroundColor: Colors.grey,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 8),
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
      onPressed: onPressed,
    );
  }
}