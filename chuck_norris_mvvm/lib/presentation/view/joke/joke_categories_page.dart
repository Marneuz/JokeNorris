import 'package:chuck_norris_mvvm/di/app_modules.dart';
import 'package:chuck_norris_mvvm/presentation/model/resource_state.dart';
import 'package:chuck_norris_mvvm/presentation/navigation/navigation_routes.dart';
import 'package:chuck_norris_mvvm/presentation/view/joke/viewmodel/jokes_view_model.dart';
import 'package:chuck_norris_mvvm/presentation/widget/error/error_view.dart';
import 'package:chuck_norris_mvvm/presentation/widget/loading/loading_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class JokeCategoriesPage extends StatefulWidget {
  const JokeCategoriesPage({super.key});

  @override
  State<JokeCategoriesPage> createState() => _JokeCategoriesPageState();
}

class _JokeCategoriesPageState extends State<JokeCategoriesPage> {
  final JokesViewModel _jokesViewModel = inject<JokesViewModel>();
  List<String> _categories = [];

  @override
  void initState() {
    super.initState();

    _jokesViewModel.getJokeCategoriesState.stream.listen((state) {
      switch (state.status) {
        case Status.LOADING:
          LoadingView.show(context);
          break;
        case Status.SUCCESS:
          LoadingView.hide();
          setState(() {
            _categories = state.data!;
          });
          break;
        case Status.ERROR:
          LoadingView.hide();
          ErrorView.show(context, state.exception!.toString(), () {
            _jokesViewModel.fetchJokeCategories();
          });
          break;
      }
    });

    _jokesViewModel.fetchJokeCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Categories"),
      ),
      body: SafeArea(
        child: GridView.builder(
          itemCount: _categories.length,
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
            crossAxisCount: 3,
          ),
          itemBuilder: (_, index) {
            final category = _categories[index];

            return Card(
              child: InkWell(
                onTap: () {
                  context.go(NavigationRoutes.JOKE_DETAIL_ROUTE,
                      extra: category);
                },
                child: Center(
                  child: Text(category),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _jokesViewModel.dispose();
    super.dispose();
  }
}
