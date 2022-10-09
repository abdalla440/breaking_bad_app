import 'dart:math';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:breaking_bad_app/business_logic/cubit/characters_cubit.dart';
import 'package:breaking_bad_app/business_logic/cubit/characters_state.dart';
import 'package:breaking_bad_app/data/models/Quote_model.dart';
import 'package:breaking_bad_app/data/models/character_model.dart';
import 'package:breaking_bad_app/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CharacterDetailsScreen extends StatelessWidget {
  final CharacterModel selectedCharacter;

  const CharacterDetailsScreen({super.key, required this.selectedCharacter});

  Widget _buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: 600,
      pinned: true,
      stretch: true,
      backgroundColor: AppColors.gray,
      flexibleSpace: FlexibleSpaceBar(
        title: Text(
          selectedCharacter.nickName!,
          style: const TextStyle(
            color: AppColors.white,
            fontSize: 22,
          ),
        ),
        background: Hero(
          tag: selectedCharacter.charId!,
          child: Image.network(
            selectedCharacter.img,
            fit: BoxFit.cover,
          ),
        ),
        // centerTitle: true,
      ),
    );
  }

  Widget characterInfo(String title, String value) {
    return RichText(
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      text: TextSpan(
        children: [
          TextSpan(
            text: title,
            style: const TextStyle(
              color: AppColors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18.0,
            ),
          ),
          TextSpan(
            text: value,
            style: const TextStyle(
              color: AppColors.white,
              fontSize: 16.0,
            ),
          )
        ],
      ),
    );
  }

  Widget buildDivider(double endIndent) {
    return Divider(
      color: AppColors.yellow,
      height: 30.0,
      endIndent: endIndent,
      thickness: 2.0,
    );
  }

  Widget _checkForQuotes(CharactersState state) {
    if (state is QuotesSuccessState) {
      return buildRandomQuotesViewer(state);
    } else {
      return const Center(
        child: CircularProgressIndicator(
          color: Colors.yellow,
        ),
      );
    }
  }

  Widget buildRandomQuotesViewer(QuotesSuccessState state) {
    var quotes = state.quoteModel;
    if (quotes.isNotEmpty) {
      List<int> randomQuotesIndexesList = [
        Random().nextInt(quotes.length - 1),
        Random().nextInt(quotes.length - 1),
        Random().nextInt(quotes.length - 1),

      ];
      return Container(
        child: Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const SizedBox(width: 20.0, height: 100.0),
              const SizedBox(width: 20.0, height: 100.0),
              Expanded(
                child: DefaultTextStyle(
                  style: const TextStyle(
                    fontSize: 20.0,
                    fontFamily: 'Horizon',
                  ),
                  // maxLines: 2,
                  // overflow: TextOverflow.clip,

                  child: AnimatedTextKit(
                    repeatForever: true,
                    animatedTexts: [
                      TypewriterAnimatedText(
                          quotes[randomQuotesIndexesList[0]].quote!,
                          speed: const Duration(milliseconds: 100)),
                      TypewriterAnimatedText(
                          quotes[randomQuotesIndexesList[1]].quote!,
                          speed: const Duration(milliseconds: 100)),
                      TypewriterAnimatedText(
                          quotes[randomQuotesIndexesList[2]].quote!,
                          speed: const Duration(milliseconds: 100)),
                    ],
                    onTap: () {},
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<CharactersCubit>(context)
        .getAllQuotes(selectedCharacter.name!);
    return Scaffold(
      backgroundColor: AppColors.gray,
      body: CustomScrollView(
        slivers: [
          _buildSliverAppBar(),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Container(
                  margin: const EdgeInsets.fromLTRB(14, 14, 14, 0),
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      characterInfo(
                          'Job : ', selectedCharacter.jobs!.join(' / ')),
                      buildDivider(315),
                      selectedCharacter.birthday != 'Unknown'
                          ? characterInfo(
                              'birthday : ', selectedCharacter.birthday!)
                          : Container(),
                      selectedCharacter.birthday != 'Unknown'
                          ? buildDivider(280)
                          : Container(),
                      characterInfo(
                          'Appeared in : ', selectedCharacter.category!),
                      buildDivider(250),
                      characterInfo('Seasons : ',
                          selectedCharacter.breakingBadAppearance!.join(' / ')),
                      buildDivider(280),
                      characterInfo(
                          'status : ', selectedCharacter.statusIfDead!),
                      buildDivider(298),
                      selectedCharacter.betterCallSaulAppearance!.isEmpty
                          ? Container()
                          : characterInfo(
                              'better call saul appearance : ',
                              selectedCharacter.betterCallSaulAppearance!
                                  .join(' / ')),
                      selectedCharacter.betterCallSaulAppearance!.isEmpty
                          ? Container()
                          : buildDivider(130),
                      characterInfo(
                          'Actor/Actress : ', selectedCharacter.actorName!),
                      buildDivider(235),
                      const SizedBox(
                        height: 30,
                      ),
                      BlocBuilder<CharactersCubit, CharactersState>(
                        builder: (context, state) {
                          return _checkForQuotes(state);
                        },
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 400,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
