import 'package:flutter/material.dart';
import 'package:my_agency/module/customer/cubit/customer_cubit.dart';
import 'package:my_agency/view/home_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CustomerCubit(),
        ),
      ],
      child: MaterialApp(
        title: 'My Agency',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          appBarTheme: const AppBarTheme(
            backgroundColor:
                Colors.blue, // Set the background color of the AppBar
            foregroundColor: Colors.white, // Set the text color of the AppBar
            iconTheme: IconThemeData(
                color: Colors.white), // Set the color of the AppBar icons
            elevation: 0, // Set the elevation of the AppBar (0 for no shadow)
          ),
        ),
        home: HomePage(),
      ),
    );
  }
}
