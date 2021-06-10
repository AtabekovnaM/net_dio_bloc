import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:net_dio_bloc/blocs/list_post_state.dart';
import 'package:net_dio_bloc/model/post_model.dart';
import 'package:net_dio_bloc/pages/create_page.dart';
import 'package:net_dio_bloc/pages/update_page.dart';
import 'package:net_dio_bloc/services/dio_service.dart';

class ListPostCubit extends Cubit<ListPostState> {
  ListPostCubit() : super(ListPostInit());

  void apiPostList() async {
    emit(ListPostLoading());
    final response = await DioService.GET(DioService.API_LIST, DioService.paramsEmpty());
    print(response);
    if(response != null) {
      emit(ListPostLoaded(posts: DioService.parsePostList(response)));
    } else {
      emit(ListPostError(error: "Couldn't fetch posts"));
    }
  }

  void apiPostDelete(Post post) async {
    emit(ListPostLoading());
    final response = await DioService.DEL(DioService.API_DELETE + post.id.toString(), DioService.paramsEmpty());
    print(response);
    if(response != null) {
      apiPostList();
    } else {
      emit(ListPostError(error: "Couldn't delete post"));
    }
  }

  void callCreatePage(BuildContext context) async {
    var result = await Navigator.push(context, MaterialPageRoute(builder: (context) => CreatePage()));
    if(result != null) {
      //BlocProvider.of<ListPostCubit>(context).apiPostList();
      apiPostList();
    }
  }

  void callUpdatePage(BuildContext context, Post post) async{
    var result = await Navigator.push(context, MaterialPageRoute(builder: (context) => UpdatePage(post: post,)));
    if(result != null) {
      apiPostList();
    }
  }
}