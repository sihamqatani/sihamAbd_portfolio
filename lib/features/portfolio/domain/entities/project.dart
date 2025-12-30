import 'package:equatable/equatable.dart';

class Project extends Equatable {
  final String id;
  final String title;
  final String description;
  final String? imageUrl;
  final List<String> tags;
  final String? link;

  const Project({
    required this.id,
    required this.title,
    required this.description,
    this.imageUrl,
    this.tags = const [],
    this.link,
  });

  @override
  List<Object?> get props => [id, title, description, imageUrl, tags, link];
}
