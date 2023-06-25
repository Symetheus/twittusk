class UserSession {
  final String uid;
  final String? email;
  final String? displayName;
  final bool isVerified;
  final bool isAnonymous;
  final String? providerId;
  final String? refreshToken;
  final String? tenantId;

  UserSession({
    required this.uid,
    this.email,
    this.displayName,
    this.isVerified = false,
    this.isAnonymous = false,
    this.providerId,
    this.refreshToken,
    this.tenantId,
  });
}