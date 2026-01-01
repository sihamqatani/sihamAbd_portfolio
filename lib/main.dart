import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:purple_portfolio/l10n/app_localizations.dart';

import 'core/bloc/language_cubit.dart';
import 'core/bloc/theme_cubit.dart';
import 'core/theme/purple_theme.dart';
import 'features/portfolio/data/datasources/portfolio_local_data_source.dart';
import 'features/portfolio/data/repositories/portfolio_repository_impl.dart';
import 'features/portfolio/domain/repositories/portfolio_repository.dart';
import 'features/portfolio/domain/usecases/get_educations.dart';
import 'features/portfolio/domain/usecases/get_experiences.dart';
import 'features/portfolio/domain/usecases/get_projects.dart';
import 'features/portfolio/domain/usecases/get_skills.dart';
import 'features/portfolio/presentation/bloc/portfolio_cubit.dart';
import 'features/portfolio/presentation/pages/home_page.dart';

void main() {
  runApp(const PortfolioApp());
}

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Dependency Injection
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<PortfolioRepository>(
          create: (context) => PortfolioRepositoryImpl(
            dataSource: PortfolioLocalDataSourceImpl(),
          ),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<PortfolioCubit>(
            create: (context) => PortfolioCubit(
              getProjects: GetProjects(context.read<PortfolioRepository>()),
              getSkills: GetSkills(context.read<PortfolioRepository>()),
              getExperiences:
                  GetExperiences(context.read<PortfolioRepository>()),
              getEducations: GetEducations(context.read<PortfolioRepository>()),
            )..loadPortfolioData(),
          ),
          BlocProvider<LanguageCubit>(
            create: (context) => LanguageCubit(),
          ),
          BlocProvider<ThemeCubit>(
            create: (context) => ThemeCubit(),
          ),
        ],
        child: BlocBuilder<ThemeCubit, ThemeMode>(
          builder: (context, themeMode) {
            return BlocBuilder<LanguageCubit, Locale>(
              builder: (context, locale) {
                return MaterialApp(
                  title: 'My Portfolio',
                  debugShowCheckedModeBanner: false,
                  theme: PurpleTheme.lightTheme,
                  darkTheme: PurpleTheme.darkTheme,
                  themeMode: themeMode,
                  themeAnimationDuration: const Duration(milliseconds: 800),
                  themeAnimationCurve: Curves.easeInOut,
                  locale: locale,
                  // Localization
                  localizationsDelegates: const [
                    AppLocalizations.delegate,
                    GlobalMaterialLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate,
                    GlobalCupertinoLocalizations.delegate,
                  ],
                  supportedLocales: const [
                    Locale('en'), // English
                    Locale('ar'), // Arabic
                  ],
                  home: const HomePage(),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
