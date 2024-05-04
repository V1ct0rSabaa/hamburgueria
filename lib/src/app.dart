import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'lista_items/item_details_view.dart';
import 'lista_items/item_list_view.dart';
import 'settings/settings_controller.dart';
import 'settings/settings_view.dart';

/// Widget de configuração
class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.settingsController,});

  final SettingsController settingsController;
  @override
  Widget build(BuildContext context) {
    // Glue the SettingsController to the MaterialApp.
    // The ListenableBuilder Widget listens to the SettingsController for changes.
    return ListenableBuilder(
      listenable: settingsController,
      builder: (BuildContext context, Widget? child) {
        return MaterialApp(
          restorationScopeId: 'app',
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en', ''), // English, no country code
          ],

          // Use AppLocalizations to configure the correct application title
          // depending on the user's locale.
          //
          // The appTitle is defined in .arb files found in the localization
          // directory.
          onGenerateTitle: (BuildContext context) =>
              AppLocalizations.of(context)!.appTitle,

          // Define a light and dark color theme. Then, read the user's
          // preferred ThemeMode (light, dark, or system default) from the
          // SettingsController to display the correct theme.
          theme: ThemeData(),
          darkTheme: ThemeData.dark(),
          themeMode: settingsController.themeMode,

          // Define a function to handle named routes in order to support
          // Flutter web url navigation and deep linking.
          onGenerateRoute: (RouteSettings routeSettings) {
            return MaterialPageRoute<void>(
              settings: routeSettings,
              builder: (BuildContext context) {
                switch (routeSettings.name) {
                  case SettingsView.routeName:
                    return SettingsView(controller: settingsController);
                  case ItemDetailsView.routeName:
                    return const ItemDetailsView();
                  case ItemListView.routeName:
                  default:
                    return const ItemListView();
                }
              },
            );
          },
        );
      },
    );
  }
}