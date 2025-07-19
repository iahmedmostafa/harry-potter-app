import 'package:dio/dio.dart';
import 'package:harry_potter_app/constants/strings.dart';

class CharacterWebServices {
  Dio dio = Dio(
    BaseOptions(
      receiveTimeout: Duration(seconds: 10),
      connectTimeout: Duration(seconds: 10),
      baseUrl: baseUrl,
    ),
  );

  Future<List<dynamic>> fetchAllCharacters() async {
    try {
      Response response = await dio.get("characters");
      print(response.statusCode.toString());
      return response.data;
    } catch (e) {
      print(e);
      return [];
    }
  }
  Future<List<dynamic>> fetchCharacterQuotes() async {
    try {
      Response response = await dio.get("https://api.breakingbadquotes.xyz/v1/quotes/5");
      print(response.statusCode.toString());
      return response.data;
    } catch (e) {
      print(e);
      return [];
    }
  }
}
