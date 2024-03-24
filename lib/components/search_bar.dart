import 'package:flutter/material.dart';

class MySearchBar extends StatefulWidget {
  final Function(String) onChanged;
  final VoidCallback onReset;
  const MySearchBar({
    required this.onChanged,
    required this.onReset,
    super.key,
  });
  @override
  _SearchBarState createState() => new _SearchBarState(onChanged, onReset);
}

class _SearchBarState extends State<MySearchBar> {
  final TextEditingController _controller = TextEditingController();
  final Function(String) onChanged;
  final VoidCallback onReset;
  _SearchBarState(this.onChanged, this.onReset);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: TextField(
          cursorColor: Colors.grey,
          controller: _controller,
          decoration: InputDecoration(
            labelText: 'Search...',
            floatingLabelBehavior: FloatingLabelBehavior.never,
            labelStyle:  const TextStyle(
              color: Colors.grey,
            ),
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  _controller.clear();
                  onReset();
                });
              },
              icon: const Icon(Icons.clear)
            ),
            filled: true,
            fillColor: const Color(0xFFF5F0FD),
            contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none, // No border
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none, // No border when enabled (not focused)
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none, // No border when focused
            ),
          ),
          onChanged: onChanged
        ),
    );
  }
}