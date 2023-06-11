class User {
  User({
    required this.uid,
    required this.username,
    required this.arobase,
    required this.email,
    required this.profilePicUri,
    required this.bannerPicUri,
    required this.bio,
  });

  final String uid;
  final String username;
  final String arobase;
  final String email;
  final String profilePicUri;
  final String bannerPicUri;
  final String bio;

// final List<User> following;
// final List<User> followers;
// final List<Tusk> tusks;

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      uid: json['\$id'],
      username: json['username'] as String,
      arobase: json['arobase'] as String,
      email: json['email'] as String,
      profilePicUri: json['profilePicUri'] as String,
      bannerPicUri: json['bannerPicUri'] as String,
      bio: json['bio'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    // avoid 'id' field, because we want Firestore create the id for us
    return {
      'username': username,
      'arobase': arobase,
      'email': email,
      'profilePicUri': profilePicUri,
      'bannerPicUri': bannerPicUri,
      'bio': bio,
    };
  }

  User copyWith({
    String? uid,
    String? username,
    String? arobase,
    String? email,
    String? profilePicUri,
    String? bannerPicUri,
    String? bio,
  }) {
    return User(
      uid: uid ?? this.uid,
      username: username ?? this.username,
      arobase: arobase ?? this.arobase,
      email: email ?? this.email,
      profilePicUri: profilePicUri ?? this.profilePicUri,
      bannerPicUri: bannerPicUri ?? this.bannerPicUri,
      bio: bio ?? this.bio,
    );
  }

}
