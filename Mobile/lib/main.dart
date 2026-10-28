import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:pizza/core/router/app_router.dart';
import 'package:pizza/core/theme/app_theme.dart';
import 'package:pizza/injection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  // Inicializa a formatação de datas para o padrão brasileiro (pt_BR)
  // Isso evita o LocaleDataException ao usar DateFormat com 'pt_BR'
  await initializeDateFormatting('pt_BR', null);
  runApp(const MeuAplicativo());
}

class MeuAplicativo extends StatelessWidget {
  const MeuAplicativo({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Pizzaria Delivery',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.light,
      routerConfig: AppRouter.router,
    );
  }
}