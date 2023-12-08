import 'package:equatable/equatable.dart';

/// {@template user}
/// User model
///
/// [AppUser.empty] represents an unauthenticated user.
/// {@endtemplate}
class AppUser extends Equatable {
  /// {@macro user}
  const AppUser({
    required this.id,
    this.email,
    this.name,
    this.photo,
  });

  /// The current user's email address.
  final String? email;

  /// The current user's id.
  final String id;

  /// The current user's name (display name).
  final String? name;

  /// Url for the current user's photo.
  final String? photo;

  /// Empty user which represents an unauthenticated user.
  static const empty = AppUser(id: '');

  /// Convenience getter to determine whether the current user is empty.
  bool get isEmpty => this == AppUser.empty;

  /// Convenience getter to determine whether the current user is not empty.
  bool get isNotEmpty => this != AppUser.empty;

  @override
  List<Object?> get props => [email, id, name, photo];
}
