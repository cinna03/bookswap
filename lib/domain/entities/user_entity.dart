class UserEntity {
  final String id;
  final String email;
  final String name;
  final bool isEmailVerified;

  const UserEntity({
    required this.id,
    required this.email,
    required this.name,
    required this.isEmailVerified,
  });
}