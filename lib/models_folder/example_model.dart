import 'package:flutter/material.dart';
import 'package:redux_simple/domain/api_clients/api_client.dart';
import 'package:redux_simple/domain/entity/post.dart';

class ExampleWidgetModel extends ChangeNotifier {
  final apiClient = ApiClient();
  var _posts = <Post>[];
  List<Post> get posts => _posts;

  Future<void> reloadPosts() async {
    final posts = await apiClient.getPosts();
    _posts += posts;
    notifyListeners();
  }

  Future<void> createPosts() async {
    final posts =
        await apiClient.createPost(title: 'my__title', body: 'my__body');
    print(posts);
  }
}

class ExampleModelProvider extends InheritedNotifier {
  final ExampleWidgetModel model;
  ExampleModelProvider({
    Key? key,
    required this.child,
    required this.model,
  }) : super(key: key, child: child, notifier: model);

  final Widget child;

  static ExampleModelProvider? subscribe(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ExampleModelProvider>();
  }

  static ExampleModelProvider? get(BuildContext context) {
    final widget = context
        .getElementForInheritedWidgetOfExactType<ExampleModelProvider>()
        ?.widget;
    return widget is ExampleModelProvider ? widget : null;
  }

// почему лишний?
  @override
  bool updateShouldNotify(ExampleModelProvider oldWidget) {
    return true;
  }
}
