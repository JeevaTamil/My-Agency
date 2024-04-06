import 'package:flutter/material.dart';
import 'package:my_agency/helper/theme/color_schemes.g.dart';
import 'package:my_agency/module/bill_inward/cubit/bill_inward_cubit.dart';
import 'package:my_agency/module/customer/cubit/customer_cubit.dart';
import 'package:my_agency/module/navigation/cubit/navigation_cubit.dart';
import 'package:my_agency/module/navigation/view/nav_landing_page.dart';
import 'package:my_agency/module/supplier/cubit/supplier_cubit.dart';
import 'package:my_agency/module/transaction/cubit/transaction_cubit.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://qebxrmzcqjalwdrvwxyr.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InFlYnhybXpjcWphbHdkcnZ3eHlyIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTEyNTMzMjYsImV4cCI6MjAyNjgyOTMyNn0.1VVaozyvRcopABLt8LXgBWjIMNrIleFfvFfw9CI95XQ',
  );

  runApp(const MyApp());
}

final supabase = Supabase.instance.client;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CustomerCubit(),
        ),
        BlocProvider(
          create: (context) => SupplierCubit(),
        ),
        BlocProvider(
          create: (context) => NavigationCubit(),
        ),
        BlocProvider(
          create: (context) => BillInwardCubit(),
        ),
        BlocProvider(
          create: (context) => TransactionCubit(),
        ),
      ],
      child: MaterialApp(
        title: 'My Agency',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: lightColorScheme,
        ),
        darkTheme: ThemeData(useMaterial3: true, colorScheme: darkColorScheme),
        home: const NavLandingPage(),
      ),
    );
  }
}
