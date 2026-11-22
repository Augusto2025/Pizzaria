import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pizza/core/constants/app_colors.dart';
import 'package:pizza/core/constants/app_strings.dart';
import 'package:pizza/core/constants/app_routes.dart';
import 'package:pizza/core/providers/menu_providers.dart';
import 'package:pizza/core/providers/cart_providers.dart';
import 'package:pizza/data/models/menu_models.dart';
import 'package:pizza/data/models/cart_models.dart';
import 'package:pizza/shared/widgets/skeleton_loader.dart';

/// Tela do Cardápio/Menu
class MenuScreen extends ConsumerStatefulWidget {
  final String? initialCategory;

  const MenuScreen({super.key, this.initialCategory});

  @override
  ConsumerState<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends ConsumerState<MenuScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final List<String> _categories = [
    AppStrings.pizzas,
    AppStrings.drinks,
    AppStrings.desserts,
    AppStrings.sides,
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: _categories.length,
      vsync: this,
      initialIndex: _getInitialCategoryIndex(),
    );
  }

  int _getInitialCategoryIndex() {
    if (widget.initialCategory == null) return 0;
    final index = _categories.indexWhere(
      (cat) => cat.toLowerCase() == widget.initialCategory!.toLowerCase(),
    );
    return index >= 0 ? index : 0;
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.menu),
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          tabs: _categories.map((cat) => Tab(text: cat)).toList(),
          labelColor: AppColors.primary,
          unselectedLabelColor: AppColors.textDisabled,
          indicatorColor: AppColors.primary,
          labelStyle: const TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: _categories.map((category) => _buildCategoryList(category)).toList(),
      ),
    );
  }

  Widget _buildCategoryList(String category) {
    // Watch the menu provider to get loading state
    final menuAsync = ref.watch(menuProvider);
    final products = ref.watch(productsByCategoryProvider(category));

    return menuAsync.when(
      loading: () => _buildCategorySkeleton(),
      error: (error, stack) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 64, color: AppColors.error),
            const SizedBox(height: 16),
            Text(
              'Erro ao carregar cardápio',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: AppColors.textSecondary,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              error.toString(),
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.textDisabled,
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => ref.invalidate(menuProvider),
              child: const Text('Tentar novamente'),
            ),
          ],
        ),
      ),
      data: (menu) {
        if (products.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.restaurant_menu, size: 64, color: AppColors.textDisabled),
                const SizedBox(height: 16),
                Text(
                  'Nenhum item nesta categoria',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                ),
              ],
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: products.length,
          itemBuilder: (context, index) => _ProductCard(product: products[index]),
        );
      },
    );
  }

  Widget _buildCategorySkeleton() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: 6, // Show 6 skeleton items
      itemBuilder: (context, index) => const SkeletonGridItem(),
    );
  }
}

class _ProductCard extends ConsumerWidget {
  final ProductDto product;

  const _ProductCard({required this.product});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: InkWell(
        onTap: product.isAvailable
            ? () => context.push('${AppRoutes.productDetail}/${product.id}')
            : null,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              // Image
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: SizedBox(
                  width: 100,
                  height: 100,
                  child: product.isAvailable
                      ? Image.network(
                          product.imageUrl,
                          fit: BoxFit.cover,
                          errorBuilder: (_, _, _) => Container(
                            color: AppColors.surface,
                            child: const Icon(Icons.local_pizza, size: 40, color: AppColors.textDisabled),
                          ),
                        )
                      : Container(
                          color: AppColors.surface,
                          child: const Icon(Icons.local_pizza, size: 40, color: AppColors.textDisabled),
                        ),
                ),
              ),
              const SizedBox(width: 16),

              // Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Name with "Indisponível" badge below (not beside) to avoid overflow on long names
                    Text(
                      product.name,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: product.isAvailable ? AppColors.textPrimary : AppColors.textDisabled,
                          ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (!product.isAvailable) ...[
                      const SizedBox(height: 4),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: AppColors.error.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          AppStrings.unavailable,
                          style: const TextStyle(
                            color: AppColors.error,
                            fontSize: 9,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                    const SizedBox(height: 4),
                    Text(
                      product.description,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppColors.textSecondary,
                          ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(Icons.timer_outlined, size: 14, color: AppColors.textDisabled),
                        const SizedBox(width: 4),
                        Text(
                          '${product.prepTimeMinutes} ${AppStrings.minutes}',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: AppColors.textSecondary,
                              ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Price & Add Button - Only cart icon next to price (compact, no overflow)
              SizedBox(
                width: 70,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'R\$ ${product.price.toStringAsFixed(2).replaceAll('.', ',')}',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: product.isAvailable ? AppColors.primary : AppColors.textDisabled,
                          ),
                    ),
                    const SizedBox(height: 8),
                    if (product.isAvailable)
                      IconButton(
                        icon: const Icon(Icons.add_shopping_cart, color: AppColors.primary, size: 28),
                        onPressed: () => _addToCart(ref, context),
                        tooltip: 'Adicionar ao carrinho',
                        style: IconButton.styleFrom(
                          backgroundColor: AppColors.primary.withValues(alpha: 0.1),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      )
                    else
                      const SizedBox.shrink(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _addToCart(WidgetRef ref, BuildContext context) async {
    final request = AddCartItemRequest(
      productId: product.id,
      quantity: 1,
      selectedCustomizations: null,
      notes: null,
    );

    // Show add to cart animation
    _showAddToCartAnimation(context);

    await ref.read(cartProvider.notifier).addItem(request);

    if (ref.read(cartProvider).hasError) {
      // Error handling is done by the notifier
    } else if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              Icon(Icons.check_circle, color: Colors.white, size: 20),
              const SizedBox(width: 8),
              Expanded(child: Text('${product.name} adicionado ao carrinho')),
            ],
          ),
          backgroundColor: AppColors.success,
          duration: const Duration(seconds: 2),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          action: SnackBarAction(
            label: 'Ver Carrinho',
            textColor: Colors.white,
            onPressed: () => context.go(AppRoutes.cart),
          ),
        ),
      );
    }
  }

  void _showAddToCartAnimation(BuildContext context) {
    // Get the overlay to add animation
    final overlay = Overlay.of(context);
    final overlayEntry = OverlayEntry(
      builder: (context) => const _AddToCartAnimationOverlay(),
    );

    overlay.insert(overlayEntry);

    // Remove animation after duration
    Future.delayed(const Duration(milliseconds: 800), () {
      if (overlayEntry.mounted) {
        overlayEntry.remove();
      }
    });
  }
}

/// Overlay widget para animação de adicionar ao carrinho
class _AddToCartAnimationOverlay extends StatefulWidget {
  const _AddToCartAnimationOverlay();

  @override
  State<_AddToCartAnimationOverlay> createState() => _AddToCartAnimationOverlayState();
}

class _AddToCartAnimationOverlayState extends State<_AddToCartAnimationOverlay>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _positionAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 0.5, end: 1.5).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutBack),
    );

    _positionAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _opacityAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.5, 1.0, curve: Curves.easeOut)),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        // Position near bottom right (cart icon area)
        final screenSize = MediaQuery.of(context).size;
        final startX = screenSize.width * 0.8;
        final startY = screenSize.height * 0.7;
        final endX = screenSize.width * 0.9;
        final endY = screenSize.height * 0.92;

        final currentX = startX + (endX - startX) * _positionAnimation.value;
        final currentY = startY + (endY - startY) * _positionAnimation.value;

        return Positioned(
          left: currentX,
          top: currentY,
          child: Opacity(
            opacity: _opacityAnimation.value,
            child: Transform.scale(
              scale: _scaleAnimation.value,
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.4),
                      blurRadius: 8,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.add_shopping_cart,
                  color: Colors.white,
                  size: 24,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}