import 'package:auth_mega_lesson/feature/data/model/post_model.dart';
import 'package:dio/dio.dart';

class PostsRepo {
  PostsRepo({required this.dio});
  final Dio dio;

  Future<List<PostModel>> getPosts() async {
    try {
      final result = await dio.get(
        'https://jsonplaceholder.typicode.com/posts',
      );

      return statisticFromJson(result.data.toString());
    } catch (e) {
      return [];
    }
  }
}
