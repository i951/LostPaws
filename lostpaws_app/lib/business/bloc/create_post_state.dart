part of 'create_post_bloc.dart';

enum Status { initial, loading, complete, failure }

@freezed
class CreatePostState with _$CreatePostState {
  const factory CreatePostState({
    @Default(Status.initial) Status status,
    PostTypeOption? postType,
    @Default("") String postTitle,
    @Default([]) List<String> photos,
    PetTypeOption? petType,
    String? breed,
    String? colour,
    double? weight,
    String? size,
    DateTime? dateLastSeen,
    LocationLastSeen? locationLastSeen,
  }) = _CreatePostState;
}
