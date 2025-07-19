import 'package:flutter/material.dart';
import 'package:harry_potter_app/app_router.dart';

void main() {
  runApp( HarryPotterApp(appRouter:AppRouter()));
}

class HarryPotterApp extends StatelessWidget {
  
 final AppRouter appRouter;
 const HarryPotterApp({super.key,required this.appRouter});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute:appRouter.generateRoute ,
    debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: "ComicNeue",
      ),

    );
  }
}
