import 'package:chuck_norris_mvvm/data/joke/jokes_data_impl.dart';
import 'package:chuck_norris_mvvm/data/joke/remote/jokes_remote_impl.dart';
import 'package:chuck_norris_mvvm/data/remote/network_client.dart';
import 'package:chuck_norris_mvvm/domain/jokes_repository.dart';
import 'package:chuck_norris_mvvm/presentation/view/joke/viewmodel/jokes_view_model.dart';
import 'package:get_it/get_it.dart';

final inject = GetIt.instance;

class AppModules {
  setup() {
    _setupMainModule();
    _setupJokeModule();
  }

  _setupMainModule() {
    inject.registerSingleton(NetworkClient());
  }

  _setupJokeModule() {
    inject.registerFactory(() => JokesRemoteImpl(networkClient: inject.get()));
    inject.registerFactory<JokesRepository>(
        () => JokesDataImpl(remoteImpl: inject.get()));
    inject.registerFactory(() => JokesViewModel(jokesRepository: inject.get()));
  }
}
