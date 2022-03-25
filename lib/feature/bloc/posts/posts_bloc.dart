import 'package:auth_mega_lesson/feature/data/model/post_model.dart';
import 'package:auth_mega_lesson/feature/data/repositories/posts_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  PostsBloc({
    required this.repo,
  }) : super(const PostsLoading()) {
    on<GetPosts>((event, emit) async {
      await Future.delayed(const Duration(seconds: 1));

      final data = await repo.getPosts();
      emit(PostsLoaded(posts: data));

      ///
      ///
      ///
    });
  }

  final PostsRepo repo;
}

@immutable
abstract class PostsState {
  const PostsState();
}

class PostsLoading extends PostsState {
  const PostsLoading();
}

class PostsLoaded extends PostsState {
  const PostsLoaded({required this.posts});

  final List<PostModel> posts;
}

class PostsError extends PostsState {
  const PostsError();
}

@immutable
abstract class PostsEvent {}

class GetPosts extends PostsEvent {}
