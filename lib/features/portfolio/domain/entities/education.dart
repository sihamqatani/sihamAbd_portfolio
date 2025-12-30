import 'package:equatable/equatable.dart';

class Education extends Equatable {
  final String id;
  final String school;
  final String degree;
  final String period;

  const Education({
    required this.id,
    required this.school,
    required this.degree,
    required this.period,
  });

  @override
  List<Object?> get props => [id, school, degree, period];
}
