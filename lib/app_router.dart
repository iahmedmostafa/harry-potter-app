import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:harry_potter_app/business_logic/character_cubit.dart';
import 'package:harry_potter_app/constants/strings.dart';
import 'package:harry_potter_app/data/model/characters_model.dart';
import 'package:harry_potter_app/data/repository/characters_repo.dart';
import 'package:harry_potter_app/data/web_services/web_services_character.dart';
import 'package:harry_potter_app/presentation/screens/home_screen.dart';
import 'package:harry_potter_app/presentation/screens/character_details_screen.dart';

class AppRouter {
  late CharactersRepository charactersRepository;
  late CharacterCubit characterCubit;


  AppRouter() {
    charactersRepository = CharactersRepository(CharacterWebServices());
    characterCubit = CharacterCubit(charactersRepository);
  }

  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case homeScreen:
        return MaterialPageRoute(builder: (_) =>
            BlocProvider(create: (BuildContext context) {
              return characterCubit;
            },
              child: HomeScreen(),
            )
        );
      case characterDetailsScreen:
        final character = settings.arguments as CharacterModel;
        return MaterialPageRoute(builder: (_) =>
            BlocProvider(
              create: (context) => CharacterCubit(charactersRepository),
              child: CharacterDetailsScreen(character: character,),
            ));
    }
  }

}