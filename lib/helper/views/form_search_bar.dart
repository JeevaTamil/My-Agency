import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_agency/module/customer/cubit/customer_cubit.dart';

class FormSearchBar extends StatefulWidget {
  FormSearchBar(
      {super.key, required this.searchableList, required this.hintText});
  List<dynamic> searchableList;
  final String hintText;

  @override
  State<FormSearchBar> createState() => _FormSearchBarState();
}

class _FormSearchBarState extends State<FormSearchBar> {
  late List<dynamic> _searchableList;
  @override
  void initState() {
    // TODO: implement initState
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
              });
            },
          );
        });
      },
    );
  }
}
