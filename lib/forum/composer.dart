import 'package:flutter/material.dart';

class Composer extends StatefulWidget {

  Composer(this.send, this.focus);

  Function(String) send;
  FocusNode focus;

  @override
  _ComposerState createState() => _ComposerState();
}

class _ComposerState extends State<Composer> {

  final TextEditingController _controller = TextEditingController();

  bool _validador = false;

  void _reset() {
    _controller.clear();
    setState(() {
      _validador = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      padding: EdgeInsets.only(
          left: 10
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(35),
          color: Colors.grey.withOpacity(0.2)),
      child: Row(
        children: [
          Expanded(
              child: TextField(
                controller: _controller,
                focusNode: widget.focus,
                decoration: InputDecoration.collapsed(
                    hintText: "Envie uma mensagem"),
                onChanged: (text) {
                  setState(() {
                    _validador = text.isNotEmpty;
                  });
                },
                onSubmitted: (text) {
                  widget.send(text);
                  _reset();
                },
              )),
          IconButton(
              icon: Icon(Icons.send),
              onPressed: _validador
                  ? () {
                widget.send(_controller.text);
                _reset();
              }
                  : null)
        ],
      ),
    );
  }
}
