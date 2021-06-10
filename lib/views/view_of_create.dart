import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:net_dio_bloc/blocs/create_post_cubit.dart';
import 'package:net_dio_bloc/model/post_model.dart';


Widget viewOfCreate(bool isLoading, BuildContext context, TextEditingController titleController, TextEditingController bodyController) {
  return Container(
    padding: EdgeInsets.all(30),
    child: Stack(
      children: [
        Column(
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                  hintText: "Title",
                  hintStyle: TextStyle(color: Colors.blueGrey)
              ),
            ),
            TextField(
              controller: bodyController,
              decoration: InputDecoration(
                  hintText: "Body",
                  hintStyle: TextStyle(color: Colors.blueGrey)
              ),
            ),
            SizedBox(height: 25,),
            FlatButton(
              onPressed: () {
                Post post = Post(title: titleController.text.toString(), body: bodyController.text.toString(), userId: 1);
                BlocProvider.of<CreatePostCubit>(context).apiPostCreate(post);
              },
              color: Colors.red,
              child: Text('Create a Post', style:  TextStyle(color: Colors.white),),
            )
          ],
        ),

        isLoading ? Center(
          child: CircularProgressIndicator(),
        ) : SizedBox.shrink(),
      ],
    ),
  );
}