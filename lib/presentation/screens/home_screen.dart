import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:harry_potter_app/business_logic/character_cubit.dart';
import 'package:harry_potter_app/constants/colors.dart';
import 'package:harry_potter_app/data/model/characters_model.dart';
import 'package:harry_potter_app/presentation/widgets/character_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late List<CharacterModel> allCharacter;
  late List<CharacterModel> searchedResultList;
  TextEditingController? _searchedController;
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    _searchedController = TextEditingController();
    BlocProvider.of<CharacterCubit>(context).getAllCharacters();
  }

  @override
  void dispose() {
    super.dispose();
    _searchedController!.dispose();
  }

  Widget buildBlocWidget() {
    return BlocBuilder<CharacterCubit, CharacterState>(
      builder: (context, state) {
        if (state is CharacterLoaded) {
          allCharacter = (state).characters;
          return buildLoadedListWidget();
        } else {
          return showCircularIndicator();
        }
      },
    );
  }

  Widget showCircularIndicator() {
    return Center(child: CircularProgressIndicator(color: MyColors.myYellow));
  }

  Widget buildLoadedListWidget() {
    return SingleChildScrollView(
      child: Container(
        color: MyColors.myGrey,
        child: Column(children: [gridViewCharacters()]),
      ),
    );
  }

  Widget gridViewCharacters() {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 8,
        childAspectRatio: .75,
        crossAxisSpacing: 8,
      ),
      itemCount: _searchedController!.text.isEmpty
          ? allCharacter.length > 30
                ? 30
                : allCharacter.length
          : searchedResultList.length,
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      physics: const ClampingScrollPhysics(),
      itemBuilder: (context, index) {
        return CharacterItem(
          characterModel: _searchedController!.text.isEmpty
              ? allCharacter[index]
              : searchedResultList[index],
        );
      },
    );
  }

  Widget buildSearchField() {
    return TextField(
      controller: _searchedController,
      decoration: InputDecoration(
        hintText: "Find an actor/actress...",
        hintStyle: TextStyle(
          color: MyColors.myGrey,
          fontSize: 18,
          fontFamily: "ComicNeue",
        ),
        border: InputBorder.none,
      ),
      cursorColor: MyColors.myGrey,
      style: TextStyle(
        color: MyColors.myGrey,
        fontSize: 18,
        fontFamily: "ComicNeue",
      ),
      onChanged: (searchedCharacter) {
        addItemForSearchedResultList(searchedCharacter);
        setState(() {});
      },
    );
  }

  addItemForSearchedResultList(String searchedCharacter) {
    searchedResultList = allCharacter
        .where(
          (character) =>
              character.name!.toLowerCase().startsWith(searchedCharacter.toLowerCase()),
        )
        .toList();
  }

  List<Widget> _buildAppBarActions() {
    if (_isSearching) {
      return [
        IconButton(
          onPressed: () {
            _clearSearch();
            Navigator.pop(context);
          },
          icon: Icon(Icons.clear, color: MyColors.myGrey, size: 18),
        ),
      ];
    } else {
      return [
        IconButton(
          onPressed: () {
            _startSearch();
          },
          icon: Icon(Icons.search, color: MyColors.myGrey, size: 18),
        ),
      ];
    }
  }

  void _clearSearch() {
    setState(() {
      _searchedController!.clear();
    });
  }

  void _startSearch() {
    ModalRoute.of(
      context,
    )!.addLocalHistoryEntry(LocalHistoryEntry(onRemove: _stopSearch));
    setState(() {
      _isSearching = true;
    });
  }

  _stopSearch() {
    _clearSearch();
    setState(() {
      _isSearching = false;
    });
  }

  Widget buildAppBarTitle() {
    return Text(
      "Characters",
      style: TextStyle(
        fontWeight: FontWeight.normal,
        fontSize: 25,
        color: Colors.black,
        fontFamily: "ComicNeue",
      ),
    );
  }

  Widget buildNoInternetWidget() {
    return Container(
      color: Colors.white,
      child: Stack(
        children: [
          Center(
            child: Image(
              image: AssetImage("assets/images/no_internet.png"),
              fit: BoxFit.cover,
              width: double.infinity,
              height: 300,
            ),
          ),
          Positioned(
            left: 30,
            bottom: 200,
            child: SizedBox(
              child:
                Text("Can't connect ❌ ...  Please check your internet "),

            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _isSearching ? buildSearchField() : buildAppBarTitle(),
        backgroundColor: MyColors.myYellow,
        actions: _buildAppBarActions(),
      ),
      body: OfflineBuilder(
        connectivityBuilder:
            (
              BuildContext context,
              List<ConnectivityResult> connectivity,
              Widget child,
            ) {
              final bool connected = !connectivity.contains(ConnectivityResult.none,);
              if (connected) {
                return buildBlocWidget();
              } else {
                return buildNoInternetWidget();
              }
            },
        child: showCircularIndicator(),
      ),
    );
  }
}
