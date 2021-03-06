import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {
  ///Called when the search icon is clicked
  final Function onSearch;

  SearchBar({this.onSearch});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        decoration: InputDecoration(
          hintText: "Search for a medication",
          suffixIcon: IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              onSearch();
            },
          ),
          border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(25.0))),
        ),
      ),
    );
  }
}
