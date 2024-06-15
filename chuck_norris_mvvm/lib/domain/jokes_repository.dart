import 'package:chuck_norris_mvvm/model/joke.dart';

abstract class JokesRepository {
  Future<List<String>> getJokeCategories();
  Future<Joke> getRandomJokeByCategory(String category);
}
