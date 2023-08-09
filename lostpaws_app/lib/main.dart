library main;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:beamer/beamer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lostpaws_app/business/cubit/authentication_cubit.dart';
import 'package:lostpaws_app/business/cubit/create_account_cubit.dart';

import 'package:lostpaws_app/presentation/constants.dart';
import 'package:lostpaws_app/presentation/routes/home_locations.dart';
import 'package:lostpaws_app/presentation/routes/unauthenticated_locations.dart';
import 'package:lostpaws_app/presentation/theme/lostpaws_text.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:lostpaws_app/firebase_options.dart';

part 'presentation/routes/routes.dart';
part 'presentation/theme/theme.dart';

void main() async {
  // Make sure Flutter is initialized before calling native code
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  //Lock the orientation to portrait mode only.
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const LostPawsApp());
}

class LostPawsApp extends StatelessWidget {
  const LostPawsApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!FocusScope.of(context).hasPrimaryFocus) {
          WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
        }
      },
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AuthenticationCubit(),
          ),
          BlocProvider(
            create: (context) => CreateAccountCubit(),
          ),
        ],
        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: '',
          theme: _theme,
          //Routes are detailed in presentation/routes.dart
          routeInformationParser: BeamerParser(),
          routerDelegate: _routerDelegate,
          backButtonDispatcher: BeamerBackButtonDispatcher(
            delegate: _routerDelegate,
            fallbackToBeamBack: false,
          ),
        ),
      ),
    );
  }
}
