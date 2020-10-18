import 'package:meta/meta.dart';

class Chat {
  final String urlAvatar;
  final String username;
  final String message;
  bool isFavourite;

  Chat({
    @required this.urlAvatar,
    @required this.username,
    @required this.message,
    this.isFavourite = false,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Chat &&
          runtimeType == other.runtimeType &&
          urlAvatar == other.urlAvatar &&
          username == other.username &&
          message == other.message &&
          isFavourite == other.isFavourite;

  @override
  int get hashCode =>
      urlAvatar.hashCode ^
      username.hashCode ^
      message.hashCode ^
      isFavourite.hashCode;

  @override
  String toString() =>
      'Chat{urlAvatar: $urlAvatar, username: $username, message: $message, isFavourite: $isFavourite}';
}
