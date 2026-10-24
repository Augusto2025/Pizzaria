import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pizza/core/constants/app_colors.dart';
import 'package:pizza/core/constants/app_strings.dart';
import 'package:pizza/core/constants/app_routes.dart';
import 'package:pizza/shared/widgets/custom_button.dart';

/// Tela inicial (Home/Dashboard)
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: Obter nome do usuário do estado de auth
    const userName = 'João';

    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.appName),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {
              // TODO: Navegar para notificações
            },
          ),
          IconButton(
            icon: const Icon(Icons.person_outline),
            onPressed: () => context.push(AppRoutes.profile),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 100), // Bottom padding for NavigationBar
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Welcome Section
            _buildWelcomeSection(context, userName),

            const SizedBox(height: 24),

            // Quick Actions
            _buildQuickActions(context),

            const SizedBox(height: 24),

            // Last Order Status (if exists)
            _buildLastOrderSection(context),

            const SizedBox(height: 24),

            // Promotions
            _buildPromotionsSection(context),
          ],
        ),
      ),
    );
  }

  Widget _buildWelcomeSection(BuildContext context, String userName) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: AppColors.primaryGradient,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${AppStrings.welcomeBack}, $userName! 👋',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'Que tal uma pizza hoje?',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Colors.white.withValues(alpha: 0.9),
                ),
          ),
          const SizedBox(height: 20),
          CustomButton(
            text: AppStrings.orderNow,
            icon: Icons.local_pizza,
            backgroundColor: Colors.white,
            foregroundColor: AppColors.primary,
            onPressed: () => context.push(AppRoutes.menu),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActions(BuildContext context) {
    final actions = [
      _QuickAction(
        icon: Icons.restaurant_menu,
        label: AppStrings.menu,
        color: AppColors.primary,
        onTap: () => context.push(AppRoutes.menu),
      ),
      _QuickAction(
        icon: Icons.receipt_long,
        label: AppStrings.myOrders,
        color: AppColors.statusConfirmed,
        onTap: () => context.push(AppRoutes.orders),
      ),
      _QuickAction(
        icon: Icons.local_offer,
        label: AppStrings.promotions,
        color: AppColors.warning,
        onTap: () {
          // TODO: Navigate to promotions
        },
      ),
      _QuickAction(
        icon: Icons.favorite_border,
        label: 'Favoritos',
        color: AppColors.error,
        onTap: () {
          // TODO: Navigate to favorites
        },
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Acesso rápido',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 16),
        // Use horizontal ListView instead of GridView to avoid text overflow
        SizedBox(
          height: 100,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: actions.length,
            separatorBuilder: (_, __) => const SizedBox(width: 12),
            itemBuilder: (context, index) => SizedBox(
              width: 80, // Largura fixa para cada card no scroll horizontal
              child: _QuickActionCard(action: actions[index]),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLastOrderSection(BuildContext context) {
    // TODO: Verificar se há pedido recente
    const hasRecentOrder = false;

    if (!hasRecentOrder) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Último pedido',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 12),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.border),
            ),
            child: Column(
              children: [
                Icon(
                  Icons.receipt_long,
                  size: 48,
                  color: AppColors.textDisabled,
                ),
                const SizedBox(height: 12),
                Text(
                  AppStrings.noOrdersYet,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                ),
                const SizedBox(height: 8),
                Text(
                  AppStrings.makeFirstOrder,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.textDisabled,
                      ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                CustomButton(
                  text: AppStrings.orderNow,
                  isFullWidth: false,
                  onPressed: () => context.push(AppRoutes.menu),
                ),
              ],
            ),
          ),
        ],
      );
    }

    // Se tivesse pedido, mostraria o status
    // return const SizedBox.shrink();
  }

  Widget _buildPromotionsSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              AppStrings.promotions,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            TextButton(
              onPressed: () {
                // TODO: Ver todas promoções
              },
              child: const Text('Ver todas'),
            ),
          ],
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 180,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 3,
            itemBuilder: (context, index) => _PromotionCard(index: index),
          ),
        ),
      ],
    );
  }
}

class _QuickAction {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _QuickAction({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });
}

class _QuickActionCard extends StatelessWidget {
  final _QuickAction action;

  const _QuickActionCard({required this.action});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: action.onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.border),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: action.color.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(action.icon, color: action.color, size: 28),
            ),
            const SizedBox(height: 10),
            Text(
              action.label,
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}

class _PromoData {
  final String title;
  final String subtitle;
  final Color color;

  const _PromoData({
    required this.title,
    required this.subtitle,
    required this.color,
  });
}

class _PromotionCard extends StatelessWidget {
  final int index;

  const _PromotionCard({required this.index});

  @override
  Widget build(BuildContext context) {
    final promotions = [
      _PromoData(
        title: '2 Pizzas + Refrigerante',
        subtitle: 'R\$ 79,90',
        color: AppColors.primary,
      ),
      _PromoData(
        title: 'Quarta da Pizza',
        subtitle: '50% off na 2ª pizza',
        color: AppColors.warning,
      ),
      _PromoData(
        title: 'Combo Família',
        subtitle: '3 Pizzas + 2L',
        color: AppColors.error,
      ),
    ];

    final promo = promotions[index];

    return Container(
      width: 280,
      margin: const EdgeInsets.only(right: 16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            promo.color.withValues(alpha: 0.2),
            promo.color.withValues(alpha: 0.05),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: promo.color.withValues(alpha: 0.3)),
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: promo.color,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    'PROMOÇÃO',
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
                const Spacer(),
                Text(
                  promo.title,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                ),
                const SizedBox(height: 8),
                Text(
                  promo.subtitle,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                ),
              ],
            ),
          ),
          Positioned(
            right: -20,
            bottom: -20,
            child: Icon(
              Icons.local_pizza,
              size: 100,
              color: promo.color.withValues(alpha: 0.1),
            ),
          ),
        ],
      ),
    );
  }
}