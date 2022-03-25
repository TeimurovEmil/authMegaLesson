import 'package:auth_mega_lesson/feature/bloc/posts/posts_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostScreen extends StatelessWidget {
  const PostScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<PostsBloc, PostsState>(
        builder: (context, state) {
          if (state is PostsLoaded) {
            return ListView(
              padding: const EdgeInsets.all(16),
              children: state.posts
                  .map(
                    (e) => ListTile(
                      title: Text(e.title),
                      subtitle: Text(e.body),
                      leading: CircleAvatar(
                        radius: 25,
                        backgroundColor: Colors.blue,
                        child: Align(
                          child: Text(
                            e.id.toString(),
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                  .toList(),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
