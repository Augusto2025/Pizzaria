import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:pizza/core/constants/app_colors.dart';
import 'package:pizza/core/constants/app_strings.dart';
import 'package:pizza/core/constants/app_routes.dart';
import 'package:pizza/core/providers/auth_providers.dart';
import 'package:pizza/data/models/auth_models.dart';
import 'package:pizza/shared/widgets/custom_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Tela de Configurações
class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  // Configurações locais
  bool _pushNotifications = true;
  bool _orderNotifications = true;
  bool _promoNotifications = true;
  ThemeMode _themeMode = ThemeMode.system;
  String _language = 'pt_BR';
  String _appVersion = '1.0.0';
  String _buildNumber = '1';

  @override
  void initState() {
    super.initState();
    _loadSettings();
    _loadAppInfo();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _pushNotifications = prefs.getBool('push_notifications') ?? true;
      _orderNotifications = prefs.getBool('order_notifications') ?? true;
      _promoNotifications = prefs.getBool('promo_notifications') ?? true;
      _themeMode = ThemeMode.values.byName(prefs.getString('theme_mode') ?? 'system');
      _language = prefs.getString('language') ?? 'pt_BR';
    });
  }

  Future<void> _loadAppInfo() async {
    final packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      _appVersion = packageInfo.version;
      _buildNumber = packageInfo.buildNumber;
    });
  }

  Future<void> _saveBoolSetting(String key, bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(key, value);
  }

  Future<void> _saveStringSetting(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: AppColors.error),
    );
  }

  void _showSuccess(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: AppColors.success),
    );
  }

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      _showError('Não foi possível abrir o link');
    }
  }

  Future<void> _clearCache() async {
    // TODO: Implementar limpeza de cache real (imagens, dados offline, etc.)
    _showSuccess('Cache limpo com sucesso');
  }

  Future<void> _exportData() async {
    // TODO: Implementar exportação de dados do usuário
    _showSuccess('Dados exportados (funcionalidade em desenvolvimento)');
  }

  Future<void> _logout() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Sair da conta'),
        content: const Text('Tem certeza que deseja sair?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            style: TextButton.styleFrom(foregroundColor: AppColors.error),
            child: const Text('Sair'),
          ),
        ],
      ),
    );

    if (confirmed == true && mounted) {
      await ref.read(authProvider.notifier).logout();
      if (mounted) context.go(AppRoutes.login);
    }
  }

  Future<void> _deleteAccount() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Excluir conta'),
        content: const Text(
          'Esta ação é irreversível. Todos os seus dados, pedidos e histórico serão permanentemente excluídos. Tem certeza?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            style: TextButton.styleFrom(foregroundColor: AppColors.error),
            child: const Text('Excluir'),
          ),
        ],
      ),
    );

    if (confirmed == true && mounted) {
      // TODO: Implementar exclusão de conta via API
      _showError('Funcionalidade em desenvolvimento');
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = ref.watch(currentUserProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.settings),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => context.pop(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header com info do usuário
            if (currentUser != null) _buildUserHeader(currentUser),

            const SizedBox(height: 24),

            // Notificações
            _buildSectionTitle('Notificações'),
            _buildNotificationToggles(),

            const SizedBox(height: 24),

            // Aparência
            _buildSectionTitle('Aparência'),
            _buildThemeSelector(),

            const SizedBox(height: 24),

            // Idioma
            _buildSectionTitle('Idioma'),
            _buildLanguageSelector(),

            const SizedBox(height: 24),

            // Privacidade e Dados
            _buildSectionTitle('Privacidade e Dados'),
            _buildPrivacyOptions(),

            const SizedBox(height: 24),

            // Conta
            _buildSectionTitle('Conta'),
            _buildAccountOptions(currentUser),

            const SizedBox(height: 24),

            // Sobre
            _buildSectionTitle('Sobre'),
            _buildAboutSection(),

            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildUserHeader(UserDto user) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundColor: AppColors.primary.withValues(alpha: 0.15),
              child: Text(
                user.name.isNotEmpty ? user.name[0].toUpperCase() : '?',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user.name,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    user.email,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                  ),
                ],
              ),
            ),
            TextButton.icon(
              onPressed: () => context.push(AppRoutes.editProfile),
              icon: const Icon(Icons.edit_outlined, size: 18),
              label: const Text('Editar perfil'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12, left: 4),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
      ),
    );
  }

  Widget _buildNotificationToggles() {
    return Card(
      child: Column(
        children: [
          _buildSwitchTile(
            title: 'Notificações push',
            subtitle: 'Receber notificações do app',
            value: _pushNotifications,
            onChanged: (value) {
              setState(() => _pushNotifications = value);
              _saveBoolSetting('push_notifications', value);
            },
          ),
          const Divider(height: 1, indent: 16, endIndent: 16),
          _buildSwitchTile(
            title: 'Atualizações de pedido',
            subtitle: 'Status do pedido, entrega, etc.',
            value: _orderNotifications,
            onChanged: _pushNotifications
                ? (value) {
                    setState(() => _orderNotifications = value);
                    _saveBoolSetting('order_notifications', value);
                  }
                : null,
          ),
          const Divider(height: 1, indent: 16, endIndent: 16),
          _buildSwitchTile(
            title: 'Promoções e ofertas',
            subtitle: 'Cupons, descontos e novidades',
            value: _promoNotifications,
            onChanged: _pushNotifications
                ? (value) {
                    setState(() => _promoNotifications = value);
                    _saveBoolSetting('promo_notifications', value);
                  }
                : null,
          ),
        ],
      ),
    );
  }

  Widget _buildSwitchTile({
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool>? onChanged,
  }) {
    return SwitchListTile(
      title: Text(title, style: Theme.of(context).textTheme.titleMedium),
      subtitle: Text(subtitle, style: Theme.of(context).textTheme.bodySmall),
      value: value,
      onChanged: onChanged,
      activeColor: AppColors.primary,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
    );
  }

  Widget _buildThemeSelector() {
    return Card(
      child: Column(
        children: [
          RadioListTile<ThemeMode>(
            title: const Text('Sistema'),
            subtitle: const Text('Segue o tema do dispositivo'),
            value: ThemeMode.system,
            groupValue: _themeMode,
            onChanged: (value) {
              if (value != null) {
                setState(() => _themeMode = value);
                _saveStringSetting('theme_mode', value.name);
              }
            },
            activeColor: AppColors.primary,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16),
          ),
          const Divider(height: 1, indent: 16, endIndent: 16),
          RadioListTile<ThemeMode>(
            title: const Text('Claro'),
            subtitle: const Text('Sempre usar tema claro'),
            value: ThemeMode.light,
            groupValue: _themeMode,
            onChanged: (value) {
              if (value != null) {
                setState(() => _themeMode = value);
                _saveStringSetting('theme_mode', value.name);
              }
            },
            activeColor: AppColors.primary,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16),
          ),
          const Divider(height: 1, indent: 16, endIndent: 16),
          RadioListTile<ThemeMode>(
            title: const Text('Escuro'),
            subtitle: const Text('Sempre usar tema escuro'),
            value: ThemeMode.dark,
            groupValue: _themeMode,
            onChanged: (value) {
              if (value != null) {
                setState(() => _themeMode = value);
                _saveStringSetting('theme_mode', value.name);
              }
            },
            activeColor: AppColors.primary,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16),
          ),
        ],
      ),
    );
  }

  Widget _buildLanguageSelector() {
    return Card(
      child: Column(
        children: [
          RadioListTile<String>(
            title: const Text('Português (Brasil)'),
            subtitle: const Text('pt_BR'),
            value: 'pt_BR',
            groupValue: _language,
            onChanged: (value) {
              if (value != null) {
                setState(() => _language = value);
                _saveStringSetting('language', value);
              }
            },
            activeColor: AppColors.primary,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16),
          ),
          const Divider(height: 1, indent: 16, endIndent: 16),
          RadioListTile<String>(
            title: const Text('English (US)'),
            subtitle: const Text('en_US - Em desenvolvimento'),
            value: 'en_US',
            groupValue: _language,
            onChanged: (value) {
              if (value != null) {
                setState(() => _language = value);
                _saveStringSetting('language', value);
              }
            },
            activeColor: AppColors.primary,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16),
          ),
        ],
      ),
    );
  }

  Widget _buildPrivacyOptions() {
    return Card(
      child: Column(
        children: [
          ListTile(
            leading: Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: AppColors.info.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(Icons.privacy_tip_outlined, color: AppColors.info, size: 22),
            ),
            title: const Text('Política de Privacidade'),
            subtitle: const Text('Como usamos seus dados'),
            trailing: const Icon(Icons.chevron_right, color: AppColors.textDisabled),
            onTap: () => _launchUrl('https://pizzaria.app/privacy'),
          ),
          const Divider(height: 1, indent: 72, endIndent: 16),
          ListTile(
            leading: Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: AppColors.warning.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(Icons.description_outlined, color: AppColors.warning, size: 22),
            ),
            title: const Text('Termos de Uso'),
            subtitle: const Text('Condições de uso do serviço'),
            trailing: const Icon(Icons.chevron_right, color: AppColors.textDisabled),
            onTap: () => _launchUrl('https://pizzaria.app/terms'),
          ),
          const Divider(height: 1, indent: 72, endIndent: 16),
          ListTile(
            leading: Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(Icons.download_outlined, color: AppColors.primary, size: 22),
            ),
            title: const Text('Exportar meus dados'),
            subtitle: const Text('Baixar uma cópia dos seus dados'),
            trailing: const Icon(Icons.chevron_right, color: AppColors.textDisabled),
            onTap: _exportData,
          ),
          const Divider(height: 1, indent: 72, endIndent: 16),
          ListTile(
            leading: Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: AppColors.textSecondary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(Icons.delete_sweep_outlined, color: AppColors.textSecondary, size: 22),
            ),
            title: const Text('Limpar cache'),
            subtitle: const Text('Liberar espaço de armazenamento'),
            trailing: const Icon(Icons.chevron_right, color: AppColors.textDisabled),
            onTap: _clearCache,
          ),
        ],
      ),
    );
  }

  Widget _buildAccountOptions(UserDto? user) {
    return Card(
      child: Column(
        children: [
          ListTile(
            leading: Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(Icons.person_outline, color: AppColors.primary, size: 22),
            ),
            title: const Text('Editar perfil'),
            subtitle: const Text('Nome, telefone, senha'),
            trailing: const Icon(Icons.chevron_right, color: AppColors.textDisabled),
            onTap: () => context.push(AppRoutes.editProfile),
          ),
          const Divider(height: 1, indent: 72, endIndent: 16),
          ListTile(
            leading: Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: AppColors.payment.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(Icons.payment_outlined, color: AppColors.payment, size: 22),
            ),
            title: const Text('Formas de pagamento'),
            subtitle: const Text('Cartões, PIX, saldo'),
            trailing: const Icon(Icons.chevron_right, color: AppColors.textDisabled),
            onTap: () => context.push(AppRoutes.paymentMethods),
          ),
          const Divider(height: 1, indent: 72, endIndent: 16),
          ListTile(
            leading: Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: AppColors.location.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(Icons.location_on_outlined, color: AppColors.location, size: 22),
            ),
            title: const Text('Endereços'),
            subtitle: const Text('Gerenciar endereços de entrega'),
            trailing: const Icon(Icons.chevron_right, color: AppColors.textDisabled),
            onTap: () => context.push(AppRoutes.addresses),
          ),
          const Divider(height: 1, indent: 72, endIndent: 16),
          ListTile(
            leading: Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: AppColors.error.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(Icons.logout, color: AppColors.error, size: 22),
            ),
            title: const Text('Sair da conta'),
            subtitle: const Text('Fazer logout'),
            trailing: const Icon(Icons.chevron_right, color: AppColors.textDisabled),
            onTap: _logout,
          ),
          const Divider(height: 1, indent: 72, endIndent: 16),
          ListTile(
            leading: Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: AppColors.error.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(Icons.delete_forever_outlined, color: AppColors.error, size: 22),
            ),
            title: const Text('Excluir conta'),
            subtitle: const Text('Remover conta permanentemente'),
            trailing: const Icon(Icons.chevron_right, color: AppColors.textDisabled),
            onTap: _deleteAccount,
          ),
        ],
      ),
    );
  }

  Widget _buildAboutSection() {
    return Card(
      child: Column(
        children: [
          ListTile(
            leading: Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(Icons.info_outline, color: AppColors.primary, size: 22),
            ),
            title: const Text('Versão do app'),
            subtitle: Text('v$_appVersion ($_buildNumber)'),
            trailing: const SizedBox.shrink(),
          ),
          const Divider(height: 1, indent: 72, endIndent: 16),
          ListTile(
            leading: Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: AppColors.info.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(Icons.help_outline, color: AppColors.info, size: 22),
            ),
            title: const Text('Ajuda e Suporte'),
            subtitle: const Text('Central de ajuda, FAQ, contato'),
            trailing: const Icon(Icons.chevron_right, color: AppColors.textDisabled),
            onTap: () => _launchUrl('https://pizzaria.app/help'),
          ),
          const Divider(height: 1, indent: 72, endIndent: 16),
          ListTile(
            leading: Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: AppColors.success.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(Icons.star_outline, color: AppColors.success, size: 22),
            ),
            title: const Text('Avaliar o app'),
            subtitle: const Text('Deixe sua opinião na loja'),
            trailing: const Icon(Icons.chevron_right, color: AppColors.textDisabled),
            onTap: () => _launchUrl('https://play.google.com/store/apps/details?id=com.pizzaria.app'),
          ),
          const Divider(height: 1, indent: 72, endIndent: 16),
          ListTile(
            leading: Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: AppColors.warning.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(Icons.bug_report_outlined, color: AppColors.warning, size: 22),
            ),
            title: const Text('Reportar problema'),
            subtitle: const Text('Enviar feedback ou bug'),
            trailing: const Icon(Icons.chevron_right, color: AppColors.textDisabled),
            onTap: () => _launchUrl('https://pizzaria.app/feedback'),
          ),
        ],
      ),
    );
  }
}