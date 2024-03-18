import 'package:flutter/material.dart';

class ListEmptyStateWidget extends StatelessWidget {
  const ListEmptyStateWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        children: [
          Spacer(),
          Text(
            "No data available",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
            ),
          ),
          SizedBox(
            height: 16.0,
          ),
          Text(
            "Add data by clicking on the '+' icon at the top",
            style: TextStyle(
              fontWeight: FontWeight.w200,
              fontSize: 14.0,
            ),
          ),
          Spacer(),
        ],
      ),
    );
  }
}
