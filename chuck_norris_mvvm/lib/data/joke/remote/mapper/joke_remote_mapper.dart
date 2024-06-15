import 'package:chuck_norris_mvvm/data/joke/remote/model/joke_remote_model.dart';
import 'package:chuck_norris_mvvm/model/joke.dart';

class JokeRemoteMapper {
  static Joke fromRemote(JokeRemoteModel remoteModel) {
    return Joke(
        categories: remoteModel.categories,
        createdAt: remoteModel.createdAt,
        iconUrl: remoteModel.iconUrl,
        id: remoteModel.id,
        updatedAt: remoteModel.updatedAt,
        url: remoteModel.url,
        value: remoteModel.value);
  }

  // Unused
  static JokeRemoteModel toRemote(Joke model) {
    return JokeRemoteModel(
        categories: model.categories,
        createdAt: model.createdAt,
        iconUrl: model.iconUrl,
        id: model.id,
        updatedAt: model.updatedAt,
        url: model.url,
        value: model.value);
  }
}
