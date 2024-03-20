import 'package:flutter/material.dart';
import 'package:dropdown_model_list/dropdown_model_list.dart';
import 'package:my_agency/module/supplier/cubit/supplier_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SupplierSearchDropDown extends StatefulWidget {
  SupplierSearchDropDown({super.key, required this.optionItemSelected});
  OptionItem optionItemSelected;

  @override
  State<SupplierSearchDropDown> createState() => _SupplierSearchDropDownState();
}

class _SupplierSearchDropDownState extends State<SupplierSearchDropDown> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.45,
      child: BlocBuilder<SupplierCubit, SupplierState>(
        builder: (context, state) {
          return FutureBuilder(
              future: state.suppliers,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return SearchDropList(
                    itemSelected: widget.optionItemSelected,
                    dropListModel: DropListModel(snapshot.data!
                        .map((e) =>
                            OptionItem(id: e.id.toString(), title: e.name))
                        .toList()),
                    showIcon: false,
                    showBorder: true,
                    showArrowIcon: false,
                    textEditingController: _controller,
                    paddingTop: 10,
                    containerPadding: const EdgeInsets.all(0),
                    onOptionSelected: (optionItem) {
                      setState(() {
                        widget.optionItemSelected = optionItem;
                      });
                    },
                  );
                } else {
                  return const Text("No Data found");
                }
              });
        },
      ),
    );
  }
}
