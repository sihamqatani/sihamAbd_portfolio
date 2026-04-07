import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:purple_portfolio/l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // SharedPreferences can still be initialized here

  // Initialize Shared Preferences
  final prefs = await SharedPreferences.getInstance();

  runApp(PortfolioApp(prefs: prefs));
}

class PortfolioApp extends StatefulWidget {
  final SharedPreferences prefs;
  const PortfolioApp({super.key, required this.prefs});

  @override
  State<PortfolioApp> createState() => _PortfolioAppState();
}

class _PortfolioAppState extends State<PortfolioApp> {
  @override
  void initState() {
    super.initState();
    // Remove splash screen after the first frame to prevent white flash
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FlutterNativeSplash.remove();
    });
  }

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
            create: (context) => ThemeCubit(widget.prefs),
          ),
        ],
        child: Builder(
          builder: (context) {
            final initialThemeMode = context.read<ThemeCubit>().state;
            return BlocBuilder<LanguageCubit, Locale>(
              builder: (context, locale) {
                return ThemeProvider(
                  initTheme: initialThemeMode == ThemeMode.dark
                      ? PurpleTheme.darkTheme
                      : PurpleTheme.lightTheme,
                  builder: (context, myTheme) {
                    return MaterialApp(
                      title: 'My Portfolio',
                      debugShowCheckedModeBanner: false,
                      theme: myTheme,
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
                });
              },
            );
          },
        ),
      ),
    );
  }
}
