import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:vocabulary_app/constans.dart';
import 'package:vocabulary_app/view/screens/home_screen.dart';

import 'controller/read_data_cubit/read_data_cubit.dart';
import 'controller/write_data_cubit/write_data_cubit.dart';
import 'model/word_type_adapter.dart';
import 'view/style/theme_manager.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(WorldTypeAdapter());
  await Hive.openBox(HiveConstants.wordsBox);
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
   const MyApp({super.key});
  // final CollectionBox wordsBox;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context)=>ReadDataCubit()..getWords()),
          BlocProvider(create: (context)=>WriteDataCubit()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'vocabulary',
          theme:ThemeManager.getAppTheme(),
          home: const HomeScreen(),
          // home: const MyHomePage(title: 'Flutter Demo Home Page'),
        ),
      ),
    );
  }
}

