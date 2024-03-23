import 'package:flutter/material.dart';
import 'package:my_agency/helper/views/form_search_bar.dart';
import 'package:my_agency/helper/views/supplier_search_dropdown_widget.dart';
import 'package:my_agency/module/customer/cubit/customer_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomerSearchDropDown extends StatefulWidget {
  const CustomerSearchDropDown({super.key, required this.customerSelected});
  final IntCallback customerSelected;

  @override
  State<CustomerSearchDropDown> createState() => _CustomerSearchDropDownState();
}

class _CustomerSearchDropDownState extends State<CustomerSearchDropDown> {
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
                return FormSearchBar(
                  searchableList: snapshot.data!,
                  hintText: 'Select Customer',
                  itemSelected: (int selectedItemId) {
                    widget.customerSelected(selectedItemId);
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
