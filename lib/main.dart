import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:petfinder/app_startup.dart';
import 'package:petfinder/bloc/dog_bloc/dog_bloc.dart';
import 'package:petfinder/core/navigator/app_navigator.dart';
import 'package:petfinder/injection/injection_container.dart';
import 'package:petfinder/shared/app_theme.dart';

void main() async {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  ///
  /// Show splash screen until the app is initialized
  ///
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  ///
  /// Run the startup process
  ///
  await AppStartup.init();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<DogBloc>(create: (_) => DogBloc()),
      ],
      child: const AppRunner(),
    ),
  );
}

final class AppRunner extends StatelessWidget {
  const AppRunner({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: AppTheme().themeData,
      routerConfig: locator<AppRouter>().config(),
    );
  }
}
