part of 'create_post_bloc.dart';

enum PostType {
  sighting,
  lost,
}

enum PetType {
  dog,
  cat,
  bird,
  bunny,
  reptile,
  amphibian,
  rodent,
  other,
}

@freezed
class CreatePostState with _$CreatePostState {
  const factory CreatePostState({
    PostType? postType,
    @Default("") String postTitle,
    @Default([]) List<String> photos,
    PetType? petType,
    String? breed,
    String? colour,
    double? weight,
    String? size,
    DateTime? dateLastSeen,
  }) = _CreatePostState;
}
