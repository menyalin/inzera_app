import 'package:flutter/material.dart';

class SearchField extends StatefulWidget {
  final Function setSearchText;
  SearchField(this.setSearchText);
  @override
  _SearchFieldState createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  TextEditingController _controller = TextEditingController();
  FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _controller.addListener(_changeTextHandler);
  }

  void _changeTextHandler() {
    widget.setSearchText(_controller.text);
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        // color: Styles.searchBackground,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 5,
          vertical: 10,
        ),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                autocorrect: false,
                controller: _controller,
                style: TextStyle(fontSize: 18.0, color: Colors.black),
                decoration: InputDecoration(
                    suffixIcon: GestureDetector(
                      child: Icon(
                        Icons.clear,
                      ),
                      onTap: () {
                        _controller.clear();
                      },
                    ),
                    prefixIcon: Icon(Icons.search),
                    hintText: "Для поиска товара введите не менее 4-х символов",
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 14.0)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
