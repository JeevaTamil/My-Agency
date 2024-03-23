import 'package:flutter/material.dart';
import 'package:my_agency/helper/views/supplier_search_dropdown_widget.dart';

class FormSearchBar extends StatefulWidget {
  FormSearchBar({
    super.key,
    required this.searchableList,
    required this.hintText,
    required this.itemSelected,
  });
  List<dynamic> searchableList;
  final String hintText;
  final IntCallback itemSelected;

  @override
  State<FormSearchBar> createState() => _FormSearchBarState();
}

class _FormSearchBarState extends State<FormSearchBar> {
  late List<dynamic> _searchableList;
  @override
  void initState() {
    super.initState();
    _searchableList = widget.searchableList;
  }

  void onQueryChanged(String query) {
    setState(() {
      widget.searchableList = widget.searchableList
          .where(
              (item) => item.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SearchAnchor(
      builder: (context, controller) {
        // controller.addListener(_onSearchChanged);
        return SearchBar(
          hintText: widget.hintText,
          controller: controller,
          onTap: () {
            controller.openView();
          },
        );
      },
      viewOnChanged: (searchString) {
        setState(() {
          _searchableList = widget.searchableList
              .where((item) =>
                  item.name
                      .toLowerCase()
                      .contains(searchString.toLowerCase()) ||
                  item.city.toLowerCase().contains(searchString.toLowerCase()))
              .toList();
        });
      },
      suggestionsBuilder: (context, controller) {
        return List<ListTile>.generate(_searchableList.length, (index) {
          return ListTile(
            title: Text(_searchableList[index].name),
            onTap: () {
              setState(() {
                controller.closeView(_searchableList[index].name);
                // widget.itemSelected(_searchableList[index.id]);
                widget.itemSelected(_searchableList[index].id);
              });
            },
          );
        });
      },
    );
  }
}
