import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {

  ///Text that suggests what sort of input the field accepts.
  final String hintText;

  ///The callback that is called when the user searches
  final Function onSearch;

  SearchBar(this.onSearch, {this.hintText});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        decoration: InputDecoration(
          hintText: hintText,
          suffixIcon: IconButton(
            icon: Icon(Icons.search),
            onPressed: () { },
          ),
          border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(25.0))),
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
