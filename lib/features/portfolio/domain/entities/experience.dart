import 'package:equatable/equatable.dart';

class Experience extends Equatable {
  final String id;
  final String company;
  final String position;
  final String period;
  final String description;

  const Experience({
    required this.id,
    required this.company,
    required this.position,
    required this.period,
    required this.description,
  });

  @override
  List<Object?> get props => [id, company, position, period, description];
}
