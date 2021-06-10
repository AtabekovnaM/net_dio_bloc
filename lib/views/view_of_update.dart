import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:net_dio_bloc/blocs/update_post_cubit.dart';
import 'package:net_dio_bloc/model/post_model.dart';


Widget viewOfUpdate(bool isLoading, BuildContext context, Post post, TextEditingController titleController, TextEditingController bodyController) {
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
            Container(
              decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(7.5)
              ),
              child: FlatButton(
                onPressed: () {
                  BlocProvider.of<UpdatePostCubit>(context).apiPostUpdate(post);
                },
                child: Text('Update Post', style:  TextStyle(color: Colors.white),),
              ),
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