import 'package:intl/intl.dart';
import 'package:twittusk/domain/models/user.dart';

class Tusk {
  final String id;
  final String description;
  final String? imageUri;
  final User profile;
  final DateTime publishedAt;
  final int nbLikes;
  final int nbDislikes;
  final int nbComments;
  final bool isLiked;
  final bool isDisliked;

  Tusk({
    required this.id,
    required this.description,
    this.imageUri,
    required this.profile,
    required this.publishedAt,
    required this.nbLikes,
    required this.nbDislikes,
    required this.nbComments,
    this.isLiked = false,
    this.isDisliked = false,
  });

  String getNbCommentStr() {
    if (nbComments < 1000) {
      return nbComments.toString();
    } else if (nbComments < 1000000) {
      return "${(nbComments / 1000).toStringAsFixed(1)}k";
    } else {
      return "${(nbComments / 1000000).toStringAsFixed(1)}M";
    }
  }

  String getNbLikesStr() {
    if (nbLikes < 1000) {
      return nbLikes.toString();
    } else if (nbLikes < 1000000) {
      return "${(nbLikes / 1000).toStringAsFixed(1)}k";
    } else {
      return "${(nbLikes / 1000000).toStringAsFixed(1)}M";
    }
  }

  String getNbDislikesStr() {
    if (nbDislikes < 1000) {
      return nbDislikes.toString();
    } else if (nbDislikes < 1000000) {
      return "${(nbDislikes / 1000).toStringAsFixed(1)}k";
    } else {
      return "${(nbDislikes / 1000000).toStringAsFixed(1)}M";
    }
  }

  String getPublishAtStr() {
    final diff = DateTime.now().difference(publishedAt);
    if (diff.inSeconds > -60 && diff.inSeconds < 0) {
      return "${diff.inSeconds * -1} seconds ago";
    } else if (diff.inMinutes > -60 && diff.inMinutes < 0) {
      return "${diff.inMinutes * -1} minutes ago";
    } else if (diff.inHours < 24) {
      return "${diff.inHours} hours ago";
    } else if (diff.inDays < 7) {
      return "${diff.inDays} day ago";
    } else {
      return "Publish on ${DateFormat('MM/dd/yyyy').format(publishedAt)}";
    }
  }
}
