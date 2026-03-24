import 'package:equatable/equatable.dart';

class Project extends Equatable {
  final String id;
  final String title;
  final String description;
  final String? imageUrl;
  final List<String> screenshots;
  final List<String> tags;
  final String? link;
  final String? videoLink;
  final String? appStoreLink;
  final String? playStoreLink;

  const Project({
    required this.id,
    required this.title,
    required this.description,
    this.imageUrl,
    this.screenshots = const [],
    this.tags = const [],
    this.link,
    this.videoLink,
    this.appStoreLink,
    this.playStoreLink,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        imageUrl,
        screenshots,
        tags,
        link,
        videoLink,
        appStoreLink,
        playStoreLink,
      ];
}
