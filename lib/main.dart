import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';
import 'src/app.dart';
import 'src/auth/auth_controller.dart';
import 'src/auth/auth_repository.dart';
import 'src/catalog/catalog_controller.dart';
import 'src/catalog/fake_store_repository.dart';
import 'src/cart/cart_controller.dart';
import 'src/favorites/favorites_controller.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MultiProvider(
      providers: [
        Provider(create: (_) => FakeStoreRepository()),
        ChangeNotifierProvider(create: (_) => AuthController(FirebaseAuthRepository())),
        ChangeNotifierProvider(create: (_) => CartController()),
        ChangeNotifierProvider(create: (_) => FavoritesController()),
        ChangeNotifierProxyProvider<FakeStoreRepository, CatalogController>(
          create: (context) => CatalogController(context.read<FakeStoreRepository>()),
          update: (_, repository, controller) => controller ?? CatalogController(repository),
        ),
      ],
      child: const NiceApp(),
    ),
  );
}
