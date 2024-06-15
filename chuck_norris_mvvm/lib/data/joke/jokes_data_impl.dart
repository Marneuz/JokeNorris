import 'package:chuck_norris_mvvm/data/joke/remote/jokes_remote_impl.dart';
import 'package:chuck_norris_mvvm/data/joke/remote/mapper/joke_remote_mapper.dart';
import 'package:chuck_norris_mvvm/domain/jokes_repository.dart';
import 'package:chuck_norris_mvvm/model/joke.dart';

class JokesDataImpl extends JokesRepository {
  final JokesRemoteImpl _remoteImpl;

  JokesDataImpl({required JokesRemoteImpl remoteImpl})
      : _remoteImpl = remoteImpl;

  @override
  Future<List<String>> getJokeCategories() {
    return _remoteImpl.getJokeCategories();
  }

  @override
  Future<Joke> getRandomJokeByCategory(String category) async {
    final remoteJoke = await _remoteImpl.getRandomJokeByCategory(category);

    return JokeRemoteMapper.fromRemote(remoteJoke);
  }
}
