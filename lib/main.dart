import 'dart:developer';
import 'dart:io';

import 'package:adflaunt/core/adapters/location/location_adapter.dart';
import 'package:adflaunt/core/adapters/profile/profile_adapter.dart';
import 'package:adflaunt/cubit/main_cubit.dart';
import 'package:adflaunt/feature/booking_list/customer_page.dart';
import 'package:adflaunt/feature/booking_list/host_page.dart';
import 'package:adflaunt/feature/chat/chat_view.dart';
import 'package:adflaunt/feature/landing_view.dart';
import 'package:adflaunt/feature/no_internet.dart';
import 'package:adflaunt/feature/tab_view.dart';
import 'package:adflaunt/generated/l10n.dart';
import 'package:adflaunt/product/widgets/loading_widget.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  await Firebase.initializeApp();
  await FirebaseMessaging.instance.requestPermission();
  Hive.init((await getApplicationDocumentsDirectory()).path);
  Hive.registerAdapter(ProfileAdapterAdapter());
  Hive.registerAdapter(LocationAdapterAdapter());
  await Hive.openBox<ProfileAdapter>('user');
  await Hive.openBox<LocationAdapter>("location");
  await Hive.openBox<List<String>>("recentSearch");
  await Hive.openBox<String>("translator");
  await Hive.openBox<List<String>>("favorites");
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

class MainApp extends StatefulWidget {
  MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  final ProfileAdapter? user = Hive.box<ProfileAdapter>('user').get('userData');

  @override
  void initState() {
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      FocusScope.of(context).unfocus();
      final user = Hive.box<ProfileAdapter>('user').get('userData');
      log("tesrt" + message.data.toString());
      if (user != null) {
        if (message.data['page'] == 'chat') {
          Navigator.push(context, MaterialPageRoute<dynamic>(
            builder: (context) {
              return ChatView(
                chatId: message.data["chatID"].toString(),
              );
            },
          ));
        } else if (message.data['page'] == 'bookingPage') {
          Map<String, dynamic> data = message.data;
          Navigator.push(context, MaterialPageRoute<dynamic>(
            builder: (context) {
              if (data["customer"] != user.id) {
                return HostPage(null, data["bookingID"].toString());
              } else {
                return CustomerPage(
                    asCustomer: null, bookingId: data["bookingID"].toString());
              }
            },
          ));
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MainCubit()..checkConnection(),
      child: AnnotatedRegion(
        value: SystemUiOverlayStyle.dark,
        child: BlocBuilder<MainCubit, MainState>(
          builder: (context, state) {
            print(state.toString());
            if (state is MainLoading) {
              return Scaffold(
                body: Center(
                  child: LoadingWidget(),
                ),
              );
            } else if (state is MainLoggedIn) {
              return const TabView();
            } else if (state is MainLoggedOut) {
              return const LandingView();
            } else if (state is MainNoInternet) {
              return NoInternet();
            } else {
              return const Scaffold(
                body: LoadingWidget(),
              );
            }
          },
        ),
      ),
    );
  }
}
