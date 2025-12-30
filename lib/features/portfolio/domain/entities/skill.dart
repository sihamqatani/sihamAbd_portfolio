import 'package:equatable/equatable.dart';

class Skill extends Equatable {
  final String id;
  final String name;
  final String category;
  final String description;
  final String iconCode;

  const Skill({
    required this.id,
    required this.name,
    required this.category,
    required this.description,
    required this.iconCode,
  });

  @override
  List<Object?> get props => [id, name, category, description, iconCode];
}
