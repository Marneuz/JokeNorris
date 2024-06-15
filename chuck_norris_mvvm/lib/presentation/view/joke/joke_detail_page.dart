import 'package:chuck_norris_mvvm/di/app_modules.dart';
import 'package:chuck_norris_mvvm/model/joke.dart';
import 'package:chuck_norris_mvvm/presentation/model/resource_state.dart';
import 'package:chuck_norris_mvvm/presentation/view/joke/viewmodel/jokes_view_model.dart';
import 'package:chuck_norris_mvvm/presentation/widget/error/error_view.dart';
import 'package:chuck_norris_mvvm/presentation/widget/loading/loading_view.dart';
import 'package:flutter/material.dart';

class JokeDetailPage extends StatefulWidget {
  const JokeDetailPage({super.key, required this.category});

  final String category;

  @override
  State<JokeDetailPage> createState() => _JokeDetailPageState();
}

class _JokeDetailPageState extends State<JokeDetailPage> {
  final JokesViewModel _viewModel = inject<JokesViewModel>();

  Joke? _joke;

  @override
  void initState() {
    super.initState();

    _viewModel.getRandomJokeByCategoryState.stream.listen((state) {
      switch (state.status) {
        case Status.LOADING:
          LoadingView.show(context);
          break;
        case Status.SUCCESS:
          LoadingView.hide();
          setState(() {
            _joke = state.data!;
          });
          break;
        case Status.ERROR:
          LoadingView.hide();
          ErrorView.show(context, state.exception.toString(), () {
            _viewModel.fetchRandomJokeByCategory(widget.category);
          });
          break;
      }
    });

    _viewModel.fetchRandomJokeByCategory(widget.category);
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.network(
                "https://pngimg.com/d/chuck_norris_PNG14.png",
                width: 140,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Text(
                  _joke?.value ?? '',
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          _viewModel.fetchRandomJokeByCategory(widget.category);
        },
        label: const Text("New joke"),
        icon: const Icon(Icons.refresh),
      ),
    );
  }
}
