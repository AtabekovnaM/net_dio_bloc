import 'package:bloc/bloc.dart';
import 'package:net_dio_bloc/blocs/create_post_state.dart';
import 'package:net_dio_bloc/model/post_model.dart';
import 'package:net_dio_bloc/services/dio_service.dart';

class CreatePostCubit extends Cubit<CreatePostState> {
  CreatePostCubit() : super(CreatePostInit());

  void apiPostCreate (Post post) async{
    print(post.toJson());
    emit(CreatePostLoading());
    final response = await DioService.POST(DioService.API_CREATE, DioService.paramsCreate(post));
    print(response);
    if(response != null) {
      emit(CreatePostLoaded(isCreated: true));
    } else {
      emit(CreatePostError(error: "Couldn't create post"));
    }
  }
}