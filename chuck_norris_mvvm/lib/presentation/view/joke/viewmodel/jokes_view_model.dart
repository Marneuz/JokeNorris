import 'dart:async';

import 'package:chuck_norris_mvvm/domain/jokes_repository.dart';
import 'package:chuck_norris_mvvm/model/joke.dart';
import 'package:chuck_norris_mvvm/presentation/base/base_view_model.dart';
import 'package:chuck_norris_mvvm/presentation/model/resource_state.dart';

class JokesViewModel extends BaseViewModel {
  final JokesRepository _jokesRepository;

  final StreamController<ResourceState<List<String>>> getJokeCategoriesState =
      StreamController();
  final StreamController<ResourceState<Joke>> getRandomJokeByCategoryState =
      StreamController();

  JokesViewModel({required JokesRepository jokesRepository})
      : _jokesRepository = jokesRepository;

  fetchJokeCategories() {
    getJokeCategoriesState.add(ResourceState.loading());

    _jokesRepository
        .getJokeCategories()
        .then(
            (value) => getJokeCategoriesState.add(ResourceState.success(value)))
        .catchError(
            (error) => getJokeCategoriesState.add(ResourceState.error(error)));
  }

  fetchRandomJokeByCategory(String category) {
    getRandomJokeByCategoryState.add(ResourceState.loading());

    _jokesRepository
        .getRandomJokeByCategory(category)
        .then((value) =>
            getRandomJokeByCategoryState.add(ResourceState.success(value)))
        .catchError((error) =>
            getRandomJokeByCategoryState.add(ResourceState.error(error)));
  }

  @override
  void dispose() {
    getJokeCategoriesState.close();
    getRandomJokeByCategoryState.close();
  }
}
