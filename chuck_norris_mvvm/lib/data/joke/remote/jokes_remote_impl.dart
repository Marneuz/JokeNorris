import 'package:chuck_norris_mvvm/data/joke/remote/model/joke_remote_model.dart';
import 'package:chuck_norris_mvvm/data/remote/error/remote_error_mapper.dart';
import 'package:chuck_norris_mvvm/data/remote/network_client.dart';
import 'package:chuck_norris_mvvm/data/remote/network_constants.dart';

class JokesRemoteImpl {
  final NetworkClient _networkClient;

  JokesRemoteImpl({required NetworkClient networkClient})
      : _networkClient = networkClient;

  Future<List<String>> getJokeCategories() async {
    try {
      final response =
          await _networkClient.dio.get(NetworkConstants.JOKE_CATEGORIES_PATH);

      final listResponse = response.data as List<dynamic>;

      return listResponse.map((e) => e.toString()).toList();
    } catch (e) {
      throw RemoteErrorMapper.getException(e);
    }
  }

  Future<JokeRemoteModel> getRandomJokeByCategory(String category) async {
    try {
      final response = await _networkClient.dio.get(
        NetworkConstants.RANDOM_JOKE_BY_CATEGORY_PATH,
        queryParameters: {"category": category},
      );

      return JokeRemoteModel.fromMap(response.data);
    } catch (e) {
      throw RemoteErrorMapper.getException(e);
    }
  }
}
