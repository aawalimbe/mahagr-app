import 'package:app_links/app_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:forrest_department_gr_and_updatees_app/pages/payment_info.dart';
import 'package:forrest_department_gr_and_updatees_app/pages/pdf_viewer.dart';
import 'package:forrest_department_gr_and_updatees_app/reusable_or_snipit_widgets/api_service.dart';
import 'package:forrest_department_gr_and_updatees_app/reusable_or_snipit_widgets/language_provider.dart';
import 'package:forrest_department_gr_and_updatees_app/reusable_or_snipit_widgets/theme_provider.dart';
import 'package:forrest_department_gr_and_updatees_app/test_connection.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  ApiService.initialize();
  await testOnlineConnection();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LanguageProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

/// 🔑 REQUIRED FOR DEEP LINK NAVIGATION
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final AppLinks _appLinks;

  @override
  void initState() {
    super.initState();
    _appLinks = AppLinks();
    _initDeepLinks();
  }

  /// ✅ Handles BOTH cold start & background links
  void _initDeepLinks() {
    // App opened from terminated state
    _appLinks.getInitialLink().then((uri) {
      if (uri != null) {
        _handleUri(uri);
      }
    });

    // App already running
    _appLinks.uriLinkStream.listen((uri) {
      if (uri != null) {
        _handleUri(uri);
      }
    });
  }

  void _handleUri(Uri uri) {
    // Expected:
    // https://mahagralert.com/pdf?url=PDF_URL&title=TITLE
    if (uri.host == 'mahagralert.com' && uri.path == '/pdf') {
      final pdfUrl = uri.queryParameters['url'];
      final title = uri.queryParameters['title'];

      if (pdfUrl != null) {
        navigatorKey.currentState?.push(
          MaterialPageRoute(
            builder:
                (_) => PdfViewer(
                  pdfUrl: Uri.decodeComponent(pdfUrl),
                  documentTitle: title ?? 'PDF Document',
                ),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 800),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return Consumer<ThemeProvider>(
          builder: (context, themeProvider, _) {
            return MaterialApp(
              navigatorKey: navigatorKey,
              title: 'Forest Department GR and Updates App Demo',
              debugShowCheckedModeBanner: false,
              builder: (context, child) {
                return MediaQuery(
                  data: MediaQuery.of(
                    context,
                  ).copyWith(textScaler: const TextScaler.linear(1.0)),
                  child: child!,
                );
              },
              theme: themeProvider.lightTheme,
              darkTheme: themeProvider.darkTheme,
              themeMode:
                  themeProvider.isDarkMode ? ThemeMode.dark : ThemeMode.light,
              home: child,
            );
          },
        );
      },
      child: const PaymentMethodsPage(), // your existing start page
    );
  }
}
