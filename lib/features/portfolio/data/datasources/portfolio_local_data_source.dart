import '../../domain/entities/education.dart';
import '../../domain/entities/experience.dart';
import '../../domain/entities/project.dart';
import '../../domain/entities/skill.dart';

abstract class PortfolioDataSource {
  Future<List<Project>> getProjects();
  Future<List<Skill>> getSkills();
  Future<List<Experience>> getExperiences();
  Future<List<Education>> getEducations();
}

class PortfolioLocalDataSourceImpl implements PortfolioDataSource {
  @override
  Future<List<Project>> getProjects() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 2500));
    return const [
      Project(
        id: 'p1',
        title: 'Delta Oil app',
        description:
            'A mobile application for collecting used cooking oil for eco-friendly disposal and recycling. Features: Schedule pickups, track requests, contribute to sustainable waste management.',
        tags: ['Flutter', 'Sustainability', 'Eco-friendly'],
        link: '',
      ),
      Project(
        id: 'p2',
        title: 'Sympl-app',
        description:
            'FinTech (Buy Now Pay Later). Contributed to the development by modifying existing codebase and implementing new features, while improving performance.',
        tags: ['Flutter', 'FinTech', 'BNPL'],
        link: '',
      ),
      Project(
        id: 'p3',
        title: 'Gate Plus App',
        description:
            'Medical Recruitment Application. Helps healthcare professionals find and apply for medical jobs. Built with Cubit, Dio, WebSockets, and FCM.',
        tags: ['Flutter', 'Clean Code', 'WebSockets'],
        link: '',
      ),
      Project(
        id: 'p4',
        title: 'Al Dhahirah Governorate',
        description:
            'An application that showcases the governorate’s services and events, with the ability to request services directly through it.',
        tags: ['Flutter', 'Public Services', 'Events'],
        link: '',
      ),
      Project(
        id: 'p5',
        title: 'Clinic App (local app)',
        description:
            'A medical data entry system to manage patient records and history in clinics.',
        tags: ['Flutter', 'Medical', 'Data Entry'],
        link: '',
      ),
      Project(
        id: 'p6',
        title: 'Erada-app',
        description:
            'A financing app for small business owners to apply for funding, upload documents, and track requests.',
        tags: ['Flutter', 'Financing', 'Business'],
        link:
            'https://drive.google.com/file/d/1PWlsCPPAS8ebFSOW7CWc4C2jQEpk6Dgt/view?usp=sharing',
      ),
      Project(
        id: 'p7',
        title: 'Shahm App',
        description:
            'Medical service platform for pharmacies and laboratories.',
        tags: ['Flutter', 'Medical', 'Healthcare'],
        link: '',
      ),
      Project(
        id: 'p8',
        title: 'babyhome app',
        description:
            'Realtime chat module using Firebase (Text, Voice, Image) for a childcare application.',
        tags: ['Flutter', 'Firebase', 'Realtime Chat'],
        link: '',
      ),
      Project(
        id: 'p9',
        title: 'Sboba Families App',
        description:
            'Home-based food ordering system with product and coupon management, user registration, and OTP.',
        tags: ['Flutter', 'E-commerce', 'Food Ordering'],
        link:
            'https://drive.google.com/drive/folders/16D_LVcPetmjyEIA80v5RDfiAM2V4F5HM?usp=sharing',
      ),
    ];
  }

  @override
  Future<List<Skill>> getSkills() async {
    await Future.delayed(const Duration(milliseconds: 2500));
    return const [
      Skill(
        id: '1',
        name: 'Flutter & Dart',
        category: 'Core Development',
        description:
            'Expert in Flutter UI development and Dart language (OOP, null-safety).',
        iconCode: 'flutter',
      ),
      Skill(
        id: '2',
        name: 'State Management',
        category: 'Architecture',
        description:
            'BLoC (Cubit & State), Provider, riverpod, GetX — managing app logic and reactivity with best practices.',
        iconCode: 'state_management',
      ),
      Skill(
        id: '3',
        name: 'API & Backend Integration',
        category: 'Integration',
        description:
            'RESTful APIs with Dio, Firebase services (Auth, Firestore, Cloud Functions, Storage), Strapi CMS integration.',
        iconCode: 'backend',
      ),
      Skill(
        id: '4',
        name: 'Local Storage',
        category: 'Data Persistence',
        description:
            'Hive, Shared Preferences, GetStorage, SQLite, Flutter Secure Storage for offline data persistence.',
        iconCode: 'storage',
      ),
      Skill(
        id: '5',
        name: 'Version Control & Deployment',
        category: 'DevOps',
        description:
            'Git & GitHub (branching, PR workflows), CI/CD basics with GitHub Actions, Codemagic.',
        iconCode: 'devops',
      ),
      Skill(
        id: '6',
        name: 'Algorithms & Data Structures',
        category: 'Computer Science',
        description: 'Solid understanding to optimize performance and logic.',
        iconCode: 'algorithms',
      ),
      Skill(
        id: '7',
        name: 'Geolocation & Maps',
        category: 'Integration',
        description:
            'Google Maps SDK, location detection, geocoding, Places API autocomplete.',
        iconCode: 'location',
      ),
      Skill(
        id: '8',
        name: 'UI/UX Implementation',
        category: 'Design',
        description:
            'Convert Figma and Adobe XD designs into pixel-perfect, responsive Flutter screens.',
        iconCode: 'design',
      ),
      Skill(
        id: '9',
        name: 'Code Structure & Quality',
        category: 'Architecture',
        description:
            'Clean Architecture, SOLID principles, maintainable and scalable codebases.',
        iconCode: 'architecture',
      ),
    ];
  }

  @override
  Future<List<Experience>> getExperiences() async {
    await Future.delayed(const Duration(milliseconds: 2500));
    return const [
      Experience(
        id: '1',
        company: 'BlushBirds',
        position: 'Flutter Developer',
        period: 'Remote',
        description: 'Building mobile applications remotely.',
      ),
      Experience(
        id: '2',
        company: 'GatePlus company',
        position: 'Flutter developer (Part-time)',
        period: 'Germany',
        description: 'Part-time development for international clients.',
      ),
      Experience(
        id: '3',
        company: 'Unicom group',
        position: 'Flutter developer',
        period: 'Sana\'a, Yemen',
        description: 'Development of mobile solutions.',
      ),
      Experience(
        id: '4',
        company: 'AQ-international',
        position: 'Flutter developer',
        period: 'Sana\'a, Yemen',
        description: 'Crafting Flutter applications.',
      ),
      Experience(
        id: '5',
        company: 'Freelancer',
        position: 'Flutter developer',
        period: 'Self-employed',
        description: 'Independent app development.',
      ),
    ];
  }

  @override
  Future<List<Education>> getEducations() async {
    await Future.delayed(const Duration(milliseconds: 2500));
    return const [
      Education(
        id: '1',
        school: 'Taiz University',
        degree: 'Software Engineering (Grade: V.Good)',
        period: 'Taiz, Yemen',
      ),
      Education(
        id: '2',
        school: 'Udemy',
        degree: 'The Complete 2022 Flutter & Dart Development Course [Arabic]',
        period: 'Certification',
      ),
      Education(
        id: '3',
        school: 'Udemy',
        degree: 'The Complete Flutter Development Guide [2022 Edition]',
        period: 'Certification',
      ),
      Education(
        id: '4',
        school: 'Udemy',
        degree: 'Flutter Clean Architecture [2022] [Flutter 3] (In Arabic)',
        period: 'Certification',
      ),
    ];
  }
}
