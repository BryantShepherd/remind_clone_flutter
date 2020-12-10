import 'package:flutter/material.dart';

class Search extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      IconButton(
        icon: Icon(Icons.close),
        onPressed: () {
          query = "";
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  String selectedResult = "";
  dynamic selectedValue;

  @override
  Widget buildResults(BuildContext context) {
    return Container(
      child: Center(
        child: Text(selectedResult),
      ),
    );
  }

  final List<String> listText;
  final List<dynamic> listValue;
  final Function(BuildContext context, dynamic selectedValue) onSelectResult;
  Search(this.listText, this.listValue, this.onSelectResult);

  List<String> recentList = [];

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> suggestionList = [];
    List<dynamic> suggestionListValue = [];
    if (query.isEmpty) {
      suggestionList = recentList;
    } else {
      for (int i = 0; i < listText.length; i++) {
        var textElem = listText[i];
        var valueElem = listValue[i];
        if (textElem.toLowerCase().contains(query.toLowerCase())) {
          suggestionList.add(textElem);
          suggestionListValue.add(valueElem);
        }
      }
    }

    return ListView.builder(
      itemCount: suggestionList.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(
            suggestionList[index],
          ),
          leading: query.isEmpty ? Icon(Icons.access_time) : SizedBox(),
          onTap: () {
            selectedResult = suggestionList[index];
            // showResults(context);
            onSelectResult(context, suggestionListValue[index]);
          },
        );
      },
    );
  }
}
