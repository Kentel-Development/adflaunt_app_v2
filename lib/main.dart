import 'dart:io';

import 'package:adflaunt/core/adapters/location/location_adapter.dart';
import 'package:adflaunt/core/adapters/profile/profile_adapter.dart';
import 'package:adflaunt/feature/landing_view.dart';
import 'package:adflaunt/feature/tab_view.dart';
import 'package:adflaunt/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() async {
  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey =
      "pk_test_51LkdT2BwxpdnO2PUdAlSZzzOM4bAIG9abSAc3e3llUFjDh5KhnlBUrdcfouBgUB2b6JE0WyVUMRgCC6gvF2lTdJp00BgLoJQLk";
  Stripe.merchantIdentifier = "merchant.com.adflaunt";
  await Stripe.instance.applySettings();
  Hive.init((await getApplicationDocumentsDirectory()).path);
  Hive.registerAdapter(ProfileAdapterAdapter());
  Hive.registerAdapter(LocationAdapterAdapter());
  await Hive.openBox<ProfileAdapter>('user');
  await Hive.openBox<LocationAdapter>("location");
  await Hive.openBox<List<String>>("recentSearch");
  await Hive.openBox<String>("translator");
  runApp(MaterialApp(
      theme: ThemeData(useMaterial3: false),
      supportedLocales: const [
        Locale('en', 'US'),
      ],
      localizationsDelegates: const [
        S.delegate,
      ],
      home: MainApp()));
}

class MainApp extends StatelessWidget {
  MainApp({super.key});
  final ProfileAdapter? user = Hive.box<ProfileAdapter>('user').get('userData');
  @override
  Widget build(BuildContext context) {
    return user == null ? LandingView() : TabView();
  }
}
