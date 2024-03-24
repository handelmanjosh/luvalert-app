

import 'package:app/scripts/user_data.dart';
import 'package:flutter/material.dart';


class UserModal extends StatefulWidget {
  final UserData user;
  final void Function(bool b) onSelect;
  const UserModal(this.user, this.onSelect, {super.key});
  @override
  State<UserModal> createState() => _UserModalState();
}

class _UserModalState extends State<UserModal> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const CircleAvatar(
              backgroundColor: Colors.grey,
            ),
            const SizedBox(width: 10),
            Text(
              '@${widget.user.username}',
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Color(0xFF282840),
                fontSize: 15,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w800,
                height: 0,
              ),
            ),
          ]
        ),
        IconButton(
          onPressed: () {
            setState(() {
              widget.user.selected = !widget.user.selected;
              widget.onSelect(widget.user.selected);
            });
          },
          icon: Icon(
            widget.user.selected ? Icons.favorite : Icons.favorite_border,
            color: widget.user.selected ? const Color(0xFFFFAEBC) : Colors.grey,
            size: 20,
          )
        ),
      ]
    );
  }
}