import 'package:flutter/material.dart';
import 'package:medify/scale.dart';

class SearchBar extends StatelessWidget {
  ///Text that suggests what sort of input the field accepts.
  final String hintText;

  ///The callback that is called when the user searches
  final Function onSearch;

  final _controller = TextEditingController();

  SearchBar({this.onSearch, this.hintText});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.sv, horizontal: 8.sh),
      child: TextField(
        style: TextStyle(fontSize: 16.sf),
        controller: _controller,
        decoration: InputDecoration(
          hintText: hintText,
          suffixIcon: IconButton(
            icon: Icon(
              Icons.search,
              size: 24.sf,
            ),
            onPressed: () {
              if (onSearch != null) {
                onSearch(_controller.text);
              }
              //hide keyboard
              FocusManager.instance.primaryFocus.unfocus();
            },
          ),
          border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(35.0))),
        ),
        onSubmitted: (inputText) {
          if (onSearch != null) {
            onSearch(inputText);
          }
        },
      ),
    );
  }
}
