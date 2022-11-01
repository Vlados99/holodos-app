import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:holodos/common/app_colors.dart';
import 'package:holodos/common/locator_service.dart' as dependency_injection;
import 'package:holodos/common/on_generate_route.dart';
import 'package:holodos/presentation/pages/all_recipes_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  await dependency_injection.init();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark().copyWith(
          backgroundColor: AppColors.mainBackground,
          scaffoldBackgroundColor: AppColors.mainBackground,
        ),
        home: RecipesPage(),
        initialRoute: '/',
        onGenerateRoute: OnGenerateRoute.route,
        routes: {
          "/": ((context) {
            return Container();
          })
        },
      ),
    );
  }
}
