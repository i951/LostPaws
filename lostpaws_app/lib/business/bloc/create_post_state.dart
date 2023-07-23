part of 'create_post_bloc.dart';

@freezed
class CreatePostState with _$CreatePostState {
  const factory CreatePostState({
    PostTypeOption? postType,
    @Default("") String postTitle,
    @Default([]) List<String> photos,
    PetTypeOption? petType,
    String? breed,
    String? colour,
    double? weight,
    String? size,
    DateTime? dateLastSeen,
  }) = _CreatePostState;
}
