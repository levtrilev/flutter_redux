import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart';

import 'package:redux_simple/domain/entity/post.dart'; // for mobile (non-web)
// import 'dart:html'; // for web only
// use dio from pub.dev for any platform

/*
// using http://jsonplaceholder.typicode.com/ backend
*/

class ApiClient {
  final client = HttpClient();

  Future<List<Post>> getPosts() async {
    // final url = Uri.parse('https://jsonplaceholder.typicode.com/posts');
    // // Uri(scheme: 'https:', host: 'jsonplaceholder.typicode.com', path: 'posts');
    // final request = await client.getUrl(url);
    // final responce =
    //     await request.close(); // responce is a Strem - for "listening"'
    // final code = responce.statusCode; // 200 is OK as usual
    // final jsonStrings = await responce
    //     .transform(utf8.decoder)
    //     .toList(); // transforming from Stream<List<int>> to Strem<String>
    // final jsonString = jsonStrings.join();
    // final json = jsonDecode(jsonString) as List<dynamic>;
    final json =
        await getJsonFromServer('https://jsonplaceholder.typicode.com/posts');
    // as List<dynamic>;
    final posts = json
        .map((dynamic e) => Post.fromJson(e as Map<String, dynamic>))
        .toList();
    return posts;
  }

  Future<List<dynamic>> getJsonFromServer(String urlAdress) async {
    // could use also: final url = Uri(scheme: 'https:', host: 'jsonplaceholder.typicode.com', path: 'posts');
    final url = Uri.parse(urlAdress);

    final request = await client.getUrl(url);
    final responce =
        await request.close(); // responce is a Strem - for "listening"'
    // final code = responce.statusCode; // 200 is OK as usual
    final jsonStrings = await responce
        .transform(utf8.decoder)
        .toList(); // transforming from Stream<List<int>> to Strem<String>
    final jsonString = jsonStrings.join();
    // should I use 'dynamic' : final dynamic json = jsonDecode(jsonString); ??
    final json = jsonDecode(jsonString);
    return json;
  }

  Future<Post> createPost({
    required String title,
    required String body,
  }) async {
    final parameters = <String, dynamic>{
      'title': title,
      'body': body,
      'userId': 111
    };
    final url = Uri.parse('https://jsonplaceholder.typicode.com/posts');
    final request = await client.postUrl(url);
    request.headers.set('Content-type', 'application/json; charset=UTF-8');
    request.write(jsonEncode(parameters));
    final responce = await request.close();
    final jsonStrings = await responce
        .transform(utf8.decoder)
        .toList(); // transforming from Stream<List<int>> to Strem<String>
    final jsonString = jsonStrings.join();
    print(jsonString);
    final json = jsonDecode(jsonString) as Map<String, dynamic>;
    final post = Post.fromJson(json);
    return post;
  }

  Future<void> fileUpload(File file) async {
    final url = Uri.parse('https://example.com');
    final request = await client.postUrl(url);
    request.headers.set(HttpHeaders.contentTypeHeader, ContentType.binary);
    request.headers.add('filename', basename(file.path));
    request.contentLength = file.lengthSync();
    final fileStream = file.openRead();
    await request.addStream(fileStream);
    final httpResponce = await request.close();
    if (httpResponce.statusCode != 200) {
      throw Exception('Error uploading file');
    } else {
      return;
    }
  }
}
