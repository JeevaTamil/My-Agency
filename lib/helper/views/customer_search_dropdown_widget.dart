import 'package:flutter/material.dart';
import 'package:dropdown_model_list/dropdown_model_list.dart';
import 'package:my_agency/module/customer/cubit/customer_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class customerSearchDropDown extends StatefulWidget {
  customerSearchDropDown({super.key, required this.optionItemSelected});
  OptionItem optionItemSelected;

  @override
  State<customerSearchDropDown> createState() => _customerSearchDropDownState();
}

class _customerSearchDropDownState extends State<customerSearchDropDown> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CustomerCubit, CustomerState>(
      builder: (context, state) {
        return FutureBuilder(
            future: state.customers,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return SearchDropList(
                  itemSelected: widget.optionItemSelected,
                  dropListModel: DropListModel(snapshot.data!
                      .map(
                          (e) => OptionItem(id: e.id.toString(), title: e.name))
                      .toList()),
                  showIcon: false,
                  showBorder: true,
                  showArrowIcon: false,
                  textEditingController: _controller,
                  paddingTop: 0,
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
    );
  }
}
