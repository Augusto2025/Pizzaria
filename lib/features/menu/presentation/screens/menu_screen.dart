import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pizza/core/constants/app_colors.dart';
import 'package:pizza/core/constants/app_strings.dart';
import 'package:pizza/core/constants/app_routes.dart';
import 'package:pizza/shared/widgets/custom_button.dart';

/// Tela do Cardápio/Menu
class MenuScreen extends StatefulWidget {
  final String? initialCategory;

  const MenuScreen({super.key, this.initialCategory});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> with SingleTickerProviderStateMixin {
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
    // Dados mockados - futuramente virão do backend
    final products = _getMockProducts(category);

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
  }

  List<_MockProduct> _getMockProducts(String category) {
    switch (category) {
      case 'Pizzas':
        return [
          _MockProduct(
            id: '1',
            name: 'Pizza Margherita',
            description: 'Molho de tomate, mussarela, manjericão e azeite',
            price: 42.90,
            imageUrl: 'https://picsum.photos/seed/pizza1/300/300',
            prepTime: 25,
            isAvailable: true,
          ),
          _MockProduct(
            id: '2',
            name: 'Pizza Pepperoni',
            description: 'Molho de tomate, mussarela, pepperoni e orégano',
            price: 48.90,
            imageUrl: 'https://picsum.photos/seed/pizza2/300/300',
            prepTime: 25,
            isAvailable: true,
          ),
          _MockProduct(
            id: '3',
            name: 'Pizza Portuguesa',
            description: 'Molho de tomate, mussarela, presunto, ovos, cebola, azeitona e ervilha',
            price: 52.90,
            imageUrl: 'https://picsum.photos/seed/pizza3/300/300',
            prepTime: 30,
            isAvailable: true,
          ),
          _MockProduct(
            id: '4',
            name: 'Pizza Quatro Queijos',
            description: 'Mussarela, provolone, gorgonzola e parmesão',
            price: 55.90,
            imageUrl: 'https://picsum.photos/seed/pizza4/300/300',
            prepTime: 25,
            isAvailable: false,
          ),
        ];
      case 'Bebidas':
        return [
          _MockProduct(
            id: '5',
            name: 'Coca-Cola 2L',
            description: 'Refrigerante Coca-Cola 2 litros',
            price: 12.90,
            imageUrl: 'https://picsum.photos/seed/drink1/300/300',
            prepTime: 0,
            isAvailable: true,
          ),
          _MockProduct(
            id: '6',
            name: 'Guaraná Antarctica 2L',
            description: 'Refrigerante Guaraná 2 litros',
            price: 10.90,
            imageUrl: 'https://picsum.photos/seed/drink2/300/300',
            prepTime: 0,
            isAvailable: true,
          ),
          _MockProduct(
            id: '7',
            name: 'Suco de Laranja 1L',
            description: 'Suco natural de laranja 1 litro',
            price: 14.90,
            imageUrl: 'https://picsum.photos/seed/drink3/300/300',
            prepTime: 0,
            isAvailable: true,
          ),
        ];
      case 'Sobremesas':
        return [
          _MockProduct(
            id: '8',
            name: 'Petit Gateau',
            description: 'Bolo de chocolate com sorvete de creme',
            price: 18.90,
            imageUrl: 'https://picsum.photos/seed/dessert1/300/300',
            prepTime: 10,
            isAvailable: true,
          ),
          _MockProduct(
            id: '9',
            name: 'Pudim de Leite',
            description: 'Pudim caseiro com calda de caramelo',
            price: 12.90,
            imageUrl: 'https://picsum.photos/seed/dessert2/300/300',
            prepTime: 5,
            isAvailable: true,
          ),
        ];
      case 'Acompanhamentos':
        return [
          _MockProduct(
            id: '10',
            name: 'Batata Frita',
            description: 'Porção de batata frita crocante',
            price: 15.90,
            imageUrl: 'https://picsum.photos/seed/side1/300/300',
            prepTime: 15,
            isAvailable: true,
          ),
          _MockProduct(
            id: '11',
            name: 'Onion Rings',
            description: 'Anéis de cebola empanados',
            price: 16.90,
            imageUrl: 'https://picsum.photos/seed/side2/300/300',
            prepTime: 15,
            isAvailable: true,
          ),
        ];
      default:
        return [];
    }
  }
}

class _MockProduct {
  final String id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  final int prepTime;
  final bool isAvailable;

  const _MockProduct({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.prepTime,
    required this.isAvailable,
  });
}

class _ProductCard extends StatelessWidget {
  final _MockProduct product;

  const _ProductCard({required this.product});

  @override
  Widget build(BuildContext context) {
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
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            product.name,
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: product.isAvailable ? AppColors.textPrimary : AppColors.textDisabled,
                                ),
                          ),
                        ),
                        if (!product.isAvailable)
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: AppColors.error.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              AppStrings.unavailable,
                              style: const TextStyle(
                                color: AppColors.error,
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                      ],
                    ),
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
                          '${product.prepTime} ${AppStrings.minutes}',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: AppColors.textSecondary,
                              ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Price & Add Button
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
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
                    CustomButton(
                      text: AppStrings.addToCart,
                      isFullWidth: false,
                      icon: Icons.add_shopping_cart,
                      onPressed: () {
                        // TODO: Adicionar ao carrinho
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('${product.name} adicionado ao carrinho')),
                        );
                      },
                    )
                  else
                    const SizedBox.shrink(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}