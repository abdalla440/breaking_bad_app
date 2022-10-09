import 'package:breaking_bad_app/business_logic/cubit/characters_cubit.dart';
import 'package:breaking_bad_app/business_logic/cubit/characters_state.dart';
import 'package:breaking_bad_app/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';

import '../../data/models/character_model.dart';
import '../widgets/character_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late List<CharacterModel> allCharacters;
  late List<CharacterModel> allCharactersFiltered;
  bool _isSearch = false;
  final _searchController = TextEditingController();

  Widget _buildSearchField() {
    return TextField(
      controller: _searchController,
      maxLines: 1,
      cursorColor: AppColors.gray,
      decoration: const InputDecoration(
        hintText: 'Fined a character ...',
        border: InputBorder.none,
        hintStyle: TextStyle(
          fontSize: 18,
          color: AppColors.gray,
        ),
      ),
      style: const TextStyle(
        fontSize: 18,
        color: AppColors.gray,
      ),
      onChanged: (value) => changeFilteredList(value),
    );
  }

  void changeFilteredList(String searchKeyword) {
    allCharactersFiltered = allCharacters
        .where(
            (element) => element.name!.toLowerCase().startsWith(searchKeyword))
        .toList();
    setState(() {});
  }

  List<Widget> _bulidAppbarActions() {
    if (_isSearch) {
      return [
        IconButton(
          onPressed: () {
            _clearSearchField();
            // Navigator.pop(context);
          },
          icon: const Icon(
            Icons.clear,
            color: AppColors.gray,
          ),
        ),
      ];
    } else {
      return [
        IconButton(
          onPressed: () {
            _startSearch();
          },
          icon: const Icon(
            Icons.search,
            color: AppColors.gray,
          ),
        ),
      ];
    }
  }

  void _startSearch() {
    ModalRoute.of(context)?.addLocalHistoryEntry(
      LocalHistoryEntry(onRemove: () => _stopSearch()),
    );
    setState(() {
      _isSearch = true;
    });
  }

  void _stopSearch() {
    _clearSearchField();
    setState(() {
      _isSearch = false;
    });
  }

  void _clearSearchField() {
    setState(() {
      _searchController.clear();
    });
  }

  @override
  void initState() {
    super.initState();
    BlocProvider.of<CharactersCubit>(context).getAllCharacters();
  }

  Widget buildBlocBuilder() {
    return BlocBuilder<CharactersCubit, CharactersState>(
      builder: (context, state) {
        if (state is CharactersSuccessState) {
          allCharacters = state.characterModel;
          return buildSuccessUi(allCharacters);
        } else {
          return const Center(
            child: CircularProgressIndicator(
              color: AppColors.yellow,
            ),
          );
        }
      },
    );
  }

  Widget buildSuccessUi(List<CharacterModel> allCharacters) {
    return SingleChildScrollView(
      child: Container(
        color: AppColors.gray,
        child: Column(
          children: [
            buildCharactersGrid(allCharacters),
          ],
        ),
      ),
    );
  }

  Widget buildCharactersGrid(List<CharacterModel> allCharacters) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 2 / 3,
          crossAxisSpacing: 1,
          mainAxisSpacing: 1),
      shrinkWrap: true,
      itemCount: _searchController.text.isEmpty
          ? allCharacters.length
          : allCharactersFiltered.length,
      physics: const ClampingScrollPhysics(),
      itemBuilder: (context, index) => CharacterItem(
          singleCharacterItem: _searchController.text.isEmpty
              ? allCharacters[index]
              : allCharactersFiltered[index]),
    );
  }

  Widget _buildAppbarTitle() {
    return const Image(
      image: AssetImage(
        'assets/images/logo_dark_green.png',
      ),
      width: 70,
      height: 70,
    );
  }

  Widget _displayConnectionWarning() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: const [
          Image(
            image: AssetImage(
              'assets/images/offline_image.png',
            ),
            height: 200,
            width: 200,
          ),
          SizedBox(
            height: 30,
          ),
          Text('No Internet connection', style: TextStyle(fontSize: 20.0)),
          SizedBox(
            height: 10.0,
          ),
          Text(
            'Check your connection, then refresh the page...',
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: _isSearch ? _buildSearchField() : _buildAppbarTitle(),
        backgroundColor: AppColors.yellow,
        actions: _bulidAppbarActions(),
        leading: _isSearch
            ? const BackButton(
                color: AppColors.gray,
              )
            : Container(),
      ),
      body: OfflineBuilder(
        connectivityBuilder: (
          BuildContext context,
          ConnectivityResult connectivityResult,
          Widget child,
        ) {
          final bool connected = connectivityResult != ConnectivityResult.none;
          if (connected) {
            return buildBlocBuilder();
          } else {
            return _displayConnectionWarning();
          }
        },
        child: const Center(
            child: CircularProgressIndicator(
          color: AppColors.yellow,
        )),
      ),
    );
    // );
  }
}
