import 'package:breaking_bad_app/data/models/character_model.dart';
import 'package:breaking_bad_app/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../business_logic/cubit/characters_cubit.dart';
import '../../shared/constants/constants.dart';

class CharacterItem extends StatelessWidget {
  final CharacterModel singleCharacterItem;

  const CharacterItem({super.key, required this.singleCharacterItem});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(
            context,
            characterDetails,
            arguments: singleCharacterItem,
          );

        },
        child: GridTile(
          footer: Hero(
            tag: singleCharacterItem.charId!,
            child: Container(
              color: Colors.black54,
              alignment: Alignment.bottomCenter,
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Text(
                '${singleCharacterItem.name}',
                style: const TextStyle(
                  color: AppColors.white,
                  height: 1.3,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
          ),
          child: singleCharacterItem.img.isNotEmpty
              ? FadeInImage.assetNetwork(
                  height: double.infinity,
                  fit: BoxFit.cover,
                  placeholder: 'assets/images/image_loading.gif',
                  image: singleCharacterItem.img,
                )
              : const Image(
                  image: AssetImage('assets/images/logo_dark_green.png')),
        ),
      ),
    );
  }
}
