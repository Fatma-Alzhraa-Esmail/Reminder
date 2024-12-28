import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:quickcue/home/pages/home_page.dart';
import 'package:quickcue/reminder/models/reminder_model.dart';
import 'package:quickcue/router/navigator.dart';
import 'package:quickcue/router/routers.dart';
import 'package:quickcue/simple_bloc_observer.dart';
import 'package:quickcue/utils/constants.dart';

void main() async {
  await Hive.initFlutter();
  Bloc.observer = SimpleBlocObserver();

  Hive.registerAdapter(ReminderModelAdapter());
  await Hive.openBox<ReminderModel>(kNotesBox);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.home,
      navigatorKey: CustomNavigator.navigatorState,
      navigatorObservers: [CustomNavigator.routeObserver],
      scaffoldMessengerKey: CustomNavigator.scaffoldState,
      onGenerateRoute: CustomNavigator.onCreateRoute,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MyHomePage(),
    );
  }
}
