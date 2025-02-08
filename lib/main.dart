import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:realtime_todo/constant/colors.dart';
import 'package:realtime_todo/screens/AddEmployee/bloc/add_bloc.dart';
import 'package:realtime_todo/screens/Home/bloc/home_bloc.dart';
import 'package:realtime_todo/services/hive_services.dart';
import 'package:realtime_todo/utils/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveService.init();
  SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => HomeBloc()..add(LoadDataEvent())),
        BlocProvider(
          create: (context) => AddBloc(
            BlocProvider.of<HomeBloc>(context),
          ),
        ),
      ],
      child: ScreenUtilInit(
        designSize: const Size(428, 926),
        minTextAdapt: true,
        splitScreenMode: true,
        child: MaterialApp.router(
          title: 'realtime_todo',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            scaffoldBackgroundColor: Colors.white,
            colorScheme: ColorScheme.fromSeed(seedColor: blue),
            useMaterial3: true,
            fontFamily: GoogleFonts.roboto().fontFamily,
          ),
          routerConfig: AppRouter().router,
        ),
      ),
    );
  }
}
