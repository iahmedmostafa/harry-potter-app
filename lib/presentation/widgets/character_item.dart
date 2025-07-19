import 'package:flutter/material.dart';
import 'package:harry_potter_app/constants/colors.dart';
import 'package:harry_potter_app/constants/strings.dart';
import 'package:harry_potter_app/data/model/characters_model.dart';

class CharacterItem extends StatelessWidget {
 final CharacterModel characterModel;

  CharacterItem({super.key, required this.characterModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4),
      margin: EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
      decoration: BoxDecoration(
        color: MyColors.myWhite,
        borderRadius: BorderRadius.circular(10),
      ),
      child: InkWell(
        onTap: (){
          Navigator.pushNamed(context, characterDetailsScreen,arguments: characterModel);
        },
        child: GridTile(
          child:  Hero(
            tag: characterModel.id as Object,
            child: Container(
              color: MyColors.myGrey,
              child: characterModel.image!.isNotEmpty
                  ? FadeInImage.assetNetwork(
                      width: double.infinity,
                      height: double.infinity,
                      placeholder: "assets/images/loading.gif",fit: BoxFit.cover,
                      image: characterModel.image!,
                    )
                  : Image(image: AssetImage("assets/images/no_image.png",),fit: BoxFit.cover,),
            ),
          ),
          footer: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            color: Colors.black.withOpacity(.5),
            alignment: AlignmentDirectional.bottomCenter,
            child: Text(
              characterModel.name.toString(),
              style: TextStyle(
                color: MyColors.myWhite,
                height: 1.3,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
          ),
        ),
      ),
    );
  }
}
