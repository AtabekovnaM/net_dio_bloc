import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:net_dio_bloc/blocs/update_post_cubit.dart';
import 'package:net_dio_bloc/blocs/update_post_state.dart';
import 'package:net_dio_bloc/model/post_model.dart';
import 'package:net_dio_bloc/views/view_of_update.dart';


class UpdatePage extends StatelessWidget {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController bodyController = TextEditingController();
  final Post post;

  UpdatePage({this.post});

  _finish(BuildContext context) {
    SchedulerBinding.instance?.addPostFrameCallback((_) {
      Navigator.pop(context, "result");
    });
  }
  @override
  Widget build(BuildContext context) {
    titleController.text = post.title;
    bodyController.text = post.body;

    return BlocProvider(
      create: (context) => UpdatePostCubit(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          title: Text("Update a post"),
        ),
        body: BlocBuilder<UpdatePostCubit, UpdatePostState>(
          builder: (context, state) {
            if(state is UpdatePostLoading){
              String title = titleController.text.toString();
              String body = bodyController.text.toString();
              Post post = Post(id: this.post.id,title: title, body: body, userId: this.post.userId);
              return viewOfUpdate(true,context,post, titleController, bodyController);
            }
            if(state is UpdatePostLoaded){
              _finish(context);
            }
            if(state is UpdatePostError){

            }
            return viewOfUpdate(false,context,post, titleController, bodyController);
          },
        ),
      ),
    );
  }
}