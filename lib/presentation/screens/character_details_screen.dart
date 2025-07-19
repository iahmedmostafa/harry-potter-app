import 'dart:math';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:harry_potter_app/business_logic/character_cubit.dart';
import 'package:harry_potter_app/constants/colors.dart';
import 'package:harry_potter_app/data/model/characters_model.dart';

class CharacterDetailsScreen extends StatelessWidget {
  final CharacterModel character;
  const CharacterDetailsScreen({super.key, required this.character});

  Widget buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: 600,
      pinned: true,
      stretch: true,
      centerTitle: false,
      backgroundColor: MyColors.myGrey,
      flexibleSpace: FlexibleSpaceBar(
        title: Text(
          character.name!,
          style: TextStyle(
            color: MyColors.myWhite,
            fontWeight: FontWeight.bold,
            fontFamily: "ComicNeue",
          ),
        ),
        background: Hero(
          tag: character.id as Object,
          child: FadeInImage.assetNetwork(
            placeholder: "assets/images/loading.gif",
            image: character.image ?? "assets/images/no_image.png",
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget buildCharacterInfo(String title, String? description) {
    return RichText(
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      text: TextSpan(
        children: [
          TextSpan(
            text: title,
            style: TextStyle(
              color: MyColors.myWhite,
              fontWeight: FontWeight.bold,
              fontSize: 18,
              fontFamily: "ComicNeue",
            ),
          ),
          TextSpan(
            text: description,
            style: TextStyle(
              color: MyColors.myWhite,
              fontWeight: FontWeight.normal,
              fontSize: 18,
              fontFamily: "ComicNeue",
            ),
          ),


        ],
      ),
    );
  }

  Widget buildDivider(double length) {
    return Divider(
      height: 30,
      thickness: 1.8,
      endIndent: length,
      color: MyColors.myYellow,
    );
  }
Widget showQuotes(){
    return checkIfQuotesLoaded();
}

  Widget checkIfQuotesLoaded() {
    return BlocBuilder<CharacterCubit, CharacterState>(
      builder: (context, state) {
        if (state is QuotesLoaded) {
          return displayRandomQuoteOrEmptySpace(state);
        } else {
          return showCircularIndicator() ;
        }
      },
    );
  }

  Widget displayRandomQuoteOrEmptySpace(QuotesLoaded state) {
    var quotes = (state).quotes;
    if (quotes.isNotEmpty) {
      int randomIndex = Random().nextInt(quotes.length - 1);
      return Center(
        child: DefaultTextStyle(
          style: TextStyle(fontSize: 25,color: MyColors.myWhite, fontFamily: "ComicNeue",
            shadows: [
            Shadow(
              blurRadius: 5,
              color: MyColors.myYellow,
              offset: Offset(0, 0),
            )
          ],),
          child: AnimatedTextKit(
            repeatForever: true,
            animatedTexts: [FlickerAnimatedText(quotes[randomIndex].quote)],
          ),
        ),
      );
    } else {
      return Container();
    }
  }

  Widget showCircularIndicator() {
    return Center(child: CircularProgressIndicator(color: MyColors.myYellow));
  }

  @override
  Widget build(BuildContext context) {
BlocProvider.of<CharacterCubit>(context).getAllQuotes();

    return Scaffold(
      backgroundColor: MyColors.myGrey,
      body: CustomScrollView(
        slivers: [
          buildSliverAppBar(),
          SliverList(
            delegate: SliverChildListDelegate([
              Container(
                margin: EdgeInsets.all(10),
                padding: EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildCharacterInfo("Actor : ", character.actor!),
                    buildDivider(275),
                    character.alternateNames!.isEmpty
                        ? Container()
                        : buildCharacterInfo(
                            "Nick Names : ",
                            (character.alternateNames!.join('/')),
                          ),
                    character.alternateNames!.isEmpty
                        ? Container()
                        : buildDivider(230),
                    character.patronus!.isEmpty
                        ? Container()
                        : buildCharacterInfo("Patronus : ", character.patronus),
                    character.patronus!.isEmpty
                        ? Container()
                        : buildDivider(255),
                    buildCharacterInfo(
                      "Hogwarts Student : ",
                      character.hogwartsStudent.toString(),
                    ),
                    buildDivider(185),
                    buildCharacterInfo("Address : ", character.house!),
                    buildDivider(255),
                    character.dateOfBirth == null
                        ? Container()
                        : buildCharacterInfo(
                            "Date Of Birth : ",
                            character.dateOfBirth!,
                          ),
                    character.dateOfBirth == null
                        ? Container()
                        : buildDivider(215),
                    buildCharacterInfo("Hair Color : ", character.hairColour!),
                    buildDivider(240),
                    buildCharacterInfo("Eye Color : ", character.eyeColour!),
                    buildDivider(250),
                    buildCharacterInfo("Alive : ", character.alive.toString()),
                    buildDivider(280),
                    SizedBox(height: 30),
                    showQuotes(),
                  ],
                ),
              ),
              SizedBox(height: 400),
            ]),
          ),
        ],
      ),
    );
  }
}
