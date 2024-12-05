import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rasidtasks/features/location/manager/location_cubit/location_cubit.dart';
import 'package:rasidtasks/features/notification/manager/cubit/notificatoin_cubit.dart';
import 'package:rasidtasks/features/portfolio/manager/cubit/portfolio_cubit.dart';
import 'package:rasidtasks/routs.dart';

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
          create: (context) => LocationCubit(),
        ),
        BlocProvider(
          create: (context) => PortfolioCubit(),
        ),
        BlocProvider(
          create: (context) => NotificationCubit(),
        ),
      ],
      child: MaterialApp.router(
        routerConfig: router,
        title: 'Rasid Tasks',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.blueAccent,
            titleTextStyle: TextStyle(color: Colors.black, fontSize: 22),
          ),
        ),
      ),
    );
  }
}
