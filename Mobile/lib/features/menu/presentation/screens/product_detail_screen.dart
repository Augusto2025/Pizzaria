import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pizza/core/constants/app_colors.dart';
import 'package:pizza/core/constants/app_strings.dart';
import 'package:pizza/core/constants/app_routes.dart';
import 'package:pizza/core/providers/cart_providers.dart';
import 'package:pizza/core/providers/menu_providers.dart';
import 'package:pizza/data/models/cart_models.dart';
import 'package:pizza/data/models/menu_models.dart';
import 'package:pizza/shared/widgets/custom_button.dart';
import 'package:pizza/shared/widgets/skeleton_loader.dart';

/// Tela de Detalhes do Produto
class ProductDetailScreen extends ConsumerStatefulWidget {
  final String productId;

  const ProductDetailScreen({super.key, required this.productId});

  @override
  ConsumerState<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends ConsumerState<ProductDetailScreen> {
  int _quantity = 1;
  final Map<String, String> _selectedCustomizations = {};
  final _notesController = TextEditingController();

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  // Helper to flatten customization options for easy selection
  List<String> _getCustomizationChoices(CustomizationOptionDto option) {
    return option.choices.map((c) => c.name).toList();
  }

  @override
  Widget build(BuildContext context) {
    final productAsync = ref.watch(productProvider(widget.productId));

    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.customize),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            if (context.canPop()) {
              context.pop();
            } else {
              context.go(AppRoutes.menu);
            }
          },
        ),
      ),
      body: productAsync.when(
        data: (product) => _buildProductDetail(product),
        loading: () => _buildProductDetailSkeleton(),
        error: (error, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.error_outline, size: 64, color: AppColors.error),
              const SizedBox(height: 16),
              Text(
                'Erro ao carregar produto',
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
                onPressed: () => ref.invalidate(productProvider(widget.productId)),
                child: const Text('Tentar novamente'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProductDetail(ProductDto product) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product Image
          SizedBox(
            width: double.infinity,
            height: 280,
            child: Image.network(
              product.imageUrl,
              fit: BoxFit.cover,
              errorBuilder: (_, _, _) => Container(
                color: AppColors.surface,
                child: const Icon(Icons.local_pizza, size: 80, color: AppColors.textDisabled),
              ),
            ),
          ),

          // Content
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Name & Availability
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        product.name,
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ),
                    if (!product.isAvailable)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: AppColors.error.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          AppStrings.unavailable,
                          style: const TextStyle(
                            color: AppColors.error,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 8),

                // Price & Prep Time
                Row(
                  children: [
                    Text(
                      'R\$ ${product.price.toStringAsFixed(2).replaceAll('.', ',')}',
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary,
                          ),
                    ),
                    const SizedBox(width: 16),
                    Icon(Icons.timer_outlined, size: 18, color: AppColors.textSecondary),
                    const SizedBox(width: 4),
                    Text(
                      '${product.prepTimeMinutes} ${AppStrings.minutes}',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: AppColors.textSecondary,
                          ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Description
                Text(
                  AppStrings.ingredients,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
                const SizedBox(height: 8),
                Text(
                  product.description,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                ),
                const SizedBox(height: 24),

                // Customizations (if any)
                if (product.customizationOptions.isNotEmpty) ...[
                  Text(
                    'Personalizações',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  const SizedBox(height: 12),
                  ...product.customizationOptions.map((option) {
                    final choices = _getCustomizationChoices(option);
                    return _buildCustomizationSection(option.name, choices, option);
                  }),
                  const SizedBox(height: 24),
                ],

                // Quantity Selector
                Text(
                  AppStrings.quantity,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
                const SizedBox(height: 12),
                _buildQuantitySelector(),
                const SizedBox(height: 24),

                // Notes
                Text(
                  AppStrings.orderNotes,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _notesController,
                  maxLines: 3,
                  decoration: InputDecoration(
                    hintText: AppStrings.optionalNotes,
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    prefixIcon: const Icon(Icons.edit_outlined),
                  ),
                ),
                const SizedBox(height: 24),

                // Add to Cart Button
                if (product.isAvailable)
                  CustomButton(
                    text: '${AppStrings.addToCart} - R\$ ${(product.price * _quantity).toStringAsFixed(2).replaceAll('.', ',')}',
                    icon: Icons.add_shopping_cart,
                    onPressed: () => _addToCart(context, product),
                  )
                else
                  CustomButton(
                    text: AppStrings.unavailable,
                    icon: Icons.block,
                    onPressed: null,
                  ),

                const SizedBox(height: 24),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCustomizationSection(String name, List<String> options, CustomizationOptionDto optionDto) {
    final isRequired = optionDto.isRequired;
    final allowMultiple = optionDto.allowMultiple;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              name,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
            ),
            if (isRequired)
              Text(
                ' *',
                style: TextStyle(color: AppColors.error, fontWeight: FontWeight.bold),
              ),
          ],
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: options.map((optionName) {
            final isSelected = _selectedCustomizations[name] == optionName;
            return FilterChip(
              label: Text(optionName),
              selected: isSelected,
              onSelected: (selected) {
                setState(() {
                  if (selected) {
                    if (!allowMultiple) {
                      // Clear other selections for this customization group
                      _selectedCustomizations.remove(name);
                    }
                    _selectedCustomizations[name] = optionName;
                  } else {
                    _selectedCustomizations.remove(name);
                  }
                });
              },
              selectedColor: AppColors.primary.withValues(alpha: 0.2),
              checkmarkColor: AppColors.primary,
              labelStyle: TextStyle(
                color: isSelected ? AppColors.primary : AppColors.textPrimary,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildQuantitySelector() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.border),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: const Icon(Icons.remove, size: 20),
            onPressed: _quantity > 1 ? () => setState(() => _quantity--) : null,
            padding: const EdgeInsets.all(12),
            constraints: const BoxConstraints(minWidth: 44, minHeight: 44),
          ),
          Container(
            width: 60,
            alignment: Alignment.center,
            child: Text(
              '$_quantity',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.add, size: 20),
            onPressed: () => setState(() => _quantity++),
            padding: const EdgeInsets.all(12),
            constraints: const BoxConstraints(minWidth: 44, minHeight: 44),
          ),
        ],
      ),
    );
  }

  Future<void> _addToCart(BuildContext context, ProductDto product) async {
    // Build the selectedCustomizations map with optionId -> choiceId
    final Map<String, String> selectedCustomizations = {};
    for (final entry in _selectedCustomizations.entries) {
      final optionName = entry.key;
      final choiceName = entry.value;
      // Find the option and choice IDs
      final option = product.customizationOptions.where((o) => o.name == optionName).firstOrNull;
      if (option != null) {
        final choice = option.choices.where((c) => c.name == choiceName).firstOrNull;
        if (choice != null) {
          selectedCustomizations[option.id] = choice.id;
        }
      }
    }

    final request = AddCartItemRequest(
      productId: product.id,
      quantity: _quantity,
      selectedCustomizations: selectedCustomizations.isEmpty ? null : selectedCustomizations,
      notes: _notesController.text.trim().isEmpty ? null : _notesController.text.trim(),
    );

    // Show add to cart animation
    _showAddToCartAnimation(context);

    await ref.read(cartProvider.notifier).addItem(request);

    if (context.mounted) {
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
          duration: const Duration(milliseconds: 800),
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

  Widget _buildProductDetailSkeleton() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image skeleton
          SkeletonLoader.rectangular(
            width: double.infinity,
            height: 280,
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Name skeleton
                SkeletonText(lines: 1, width: double.infinity, height: 28),
                const SizedBox(height: 8),
                // Price skeleton
                SkeletonText(lines: 1, width: 120, height: 24),
                const SizedBox(height: 16),
                // Description skeleton
                SkeletonText(lines: 3, height: 18),
                const SizedBox(height: 24),
                // Customization skeleton
                SkeletonText(lines: 1, width: 150, height: 20),
                const SizedBox(height: 12),
                SkeletonLoader.rectangular(
                  width: double.infinity,
                  height: 50,
                  borderRadius: BorderRadius.circular(8),
                ),
                const SizedBox(height: 24),
                // Quantity skeleton
                SkeletonText(lines: 1, width: 100, height: 20),
                const SizedBox(height: 12),
                SkeletonLoader.rectangular(
                  width: 140,
                  height: 56,
                  borderRadius: BorderRadius.circular(12),
                ),
                const SizedBox(height: 24),
                // Notes skeleton
                SkeletonText(lines: 1, width: 120, height: 20),
                const SizedBox(height: 12),
                SkeletonLoader.rectangular(
                  width: double.infinity,
                  height: 100,
                  borderRadius: BorderRadius.circular(12),
                ),
                const SizedBox(height: 24),
                // Button skeleton
                SkeletonLoader.rectangular(
                  width: double.infinity,
                  height: 48,
                  borderRadius: BorderRadius.circular(12),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ],
      ),
    );
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