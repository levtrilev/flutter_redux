import 'package:flutter/material.dart';
import 'package:redux_simple/models_folder/example_model.dart';

class Example extends StatefulWidget {
  const Example({Key? key}) : super(key: key);

  @override
  _ExampleState createState() => _ExampleState();
}

class _ExampleState extends State<Example> {
  final model = ExampleWidgetModel();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: ExampleModelProvider(
            model: model,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _ReloadButton(),
                _CreateButton(),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: _PostWidget(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _CreateButton extends StatelessWidget {
  const _CreateButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => ExampleModelProvider.get(context)?.model.createPosts(),
      child: Text('Create posts'),
    );
  }
}

class _ReloadButton extends StatelessWidget {
  const _ReloadButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        // final aa = ExampleModelProvider.get(context);
        // aa?.model.reloadPosts();
        ExampleModelProvider.get(context)?.model.reloadPosts();
      },
      child: Text('Reload posts'),
    );
  }
}

class _PostWidget extends StatelessWidget {
  const _PostWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount:
          ExampleModelProvider.subscribe(context)?.model.posts.length ?? 0,
      itemBuilder: (context, index) => _PostsRowWidget(index: index),
    );
  }
}

class _PostsRowWidget extends StatelessWidget {
  final int index;
  const _PostsRowWidget({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final post = ExampleModelProvider.get(context)!.model.posts[index];
    return Column(
      children: [
        Text(post.id.toString()),
        SizedBox(
          height: 10,
        ),
        Text(post.title),
        SizedBox(
          height: 10,
        ),
        Text(post.body),
      ],
    );
  }
}
