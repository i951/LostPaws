import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_post_event.dart';
part 'create_post_state.dart';
part 'create_post_bloc.freezed.dart';

class CreatePostBloc extends Bloc<CreatePostEvent, CreatePostState> {
  CreatePostBloc() : super(const CreatePostState()) {
    on<CreatePostInitial>(onCreatePostInitial);
    on<CreatePostTypeChanged>(onCreatePostTypeChanged);
    on<CreatePostTitleChanged>(onCreatePostTitleChanged);
    on<CreatePostPetTypeChanged>(onCreatePostPetTypeChanged);
    on<CreatePostBreedChanged>(onCreatePostBreedChanged);
    on<CreatePostColourChanged>(onCreatePostColourChanged);
    on<CreatePostWeightChanged>(onCreatePostWeightChanged);
    on<CreatePostDateChanged>(onCreatePostDateChanged);
  }

  void onCreatePostInitial(
    CreatePostInitial event,
    Emitter<CreatePostState> emit,
  ) {
    print("create post bloc initialized");
  }

  void onCreatePostTypeChanged(
    CreatePostTypeChanged event,
    Emitter<CreatePostState> emit,
  ) {
    if (event.postType == "SIGHTING") {
      emit(state.copyWith(postType: PostType.sighting));
    } else if (event.postType == "LOST") {
      emit(state.copyWith(postType: PostType.lost));
    } else {
      throw UnimplementedError("Post type not supported");
    }

    print("state's post type: ${state.postType}");
  }

  void onCreatePostTitleChanged(
      CreatePostTitleChanged event, Emitter<CreatePostState> emit) {
    emit(state.copyWith(postTitle: event.title));

    print("state's title: ${state.postTitle}");
  }

  void onCreatePostPetTypeChanged(
      CreatePostPetTypeChanged event, Emitter<CreatePostState> emit) {}

  void onCreatePostBreedChanged(
      CreatePostBreedChanged event, Emitter<CreatePostState> emit) {}

  void onCreatePostColourChanged(
      CreatePostColourChanged event, Emitter<CreatePostState> emit) {}

  void onCreatePostWeightChanged(
      CreatePostWeightChanged event, Emitter<CreatePostState> emit) {}

  void onCreatePostDateChanged(
      CreatePostDateChanged event, Emitter<CreatePostState> emit) {}
}
