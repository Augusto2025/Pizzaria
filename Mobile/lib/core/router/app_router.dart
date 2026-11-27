import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pizza/core/constants/app_routes.dart';
import 'package:pizza/core/providers/cart_providers.dart';
import 'package:pizza/features/auth/presentation/screens/login_screen.dart';
import 'package:pizza/features/auth/presentation/screens/register_screen.dart';
import 'package:pizza/features/home/presentation/screens/home_screen.dart';
import 'package:pizza/features/menu/presentation/screens/menu_screen.dart';
import 'package:pizza/features/menu/presentation/screens/product_detail_screen.dart';
import 'package:pizza/features/cart/presentation/screens/cart_screen.dart';
import 'package:pizza/features/cart/presentation/screens/checkout_screen.dart';
import 'package:pizza/features/orders/presentation/screens/orders_screen.dart';
import 'package:pizza/features/orders/presentation/screens/order_detail_screen.dart';
import 'package:pizza/features/profile/presentation/screens/profile_screen.dart';
import 'package:pizza/features/profile/presentation/screens/addresses_screen.dart';
import 'package:pizza/features/profile/presentation/screens/add_edit_address_screen.dart';
import 'package:pizza/features/profile/presentation/screens/edit_profile_screen.dart';
import 'package:pizza/features/profile/presentation/screens/settings_screen.dart';

/// Configuração de rotas da aplicação usando go_router com ShellRoute para bottom navigation
class AppRouter {
  AppRouter._();

  static final GoRouter router = GoRouter(
    initialLocation: AppRoutes.login,
    debugLogDiagnostics: true,
    routes: [
      // Rotas públicas (sem autenticação)
      GoRoute(
        path: AppRoutes.login,
        name: 'login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: AppRoutes.register,
        name: 'register',
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(
        path: AppRoutes.forgotPassword,
        name: 'forgot-password',
        builder: (context, state) => const ForgotPasswordScreen(),
      ),

      // ShellRoute com bottom navigation para áreas autenticadas
      ShellRoute(
        builder: (context, state, child) => ScaffoldWithBottomNav(child: child),
        routes: [
          GoRoute(
            path: AppRoutes.home,
            name: 'home',
            builder: (context, state) => const HomeScreen(),
          ),
          GoRoute(
            path: AppRoutes.menu,
            name: 'menu',
            builder: (context, state) => const MenuScreen(),
          ),
          GoRoute(
            path: AppRoutes.menuCategory,
            name: 'menu-category',
            builder: (context, state) {
              final category = state.pathParameters['category'] ?? '';
              return MenuScreen(initialCategory: category);
            },
          ),
          GoRoute(
            path: AppRoutes.productDetail,
            name: 'product-detail',
            builder: (context, state) {
              final productId = state.pathParameters['id'] ?? '';
              return ProductDetailScreen(productId: productId);
            },
          ),
          GoRoute(
            path: AppRoutes.cart,
            name: 'cart',
            builder: (context, state) => const CartScreen(),
          ),
          GoRoute(
            path: AppRoutes.checkout,
            name: 'checkout',
            builder: (context, state) => const CheckoutScreen(),
          ),
          GoRoute(
            path: AppRoutes.orders,
            name: 'orders',
            builder: (context, state) => const OrdersScreen(),
          ),
          GoRoute(
            path: AppRoutes.orderDetail,
            name: 'order-detail',
            builder: (context, state) {
              final orderId = state.pathParameters['id'] ?? '';
              return OrderDetailScreen(orderId: orderId);
            },
          ),
          GoRoute(
            path: AppRoutes.profile,
            name: 'profile',
            builder: (context, state) => const ProfileScreen(),
          ),
          GoRoute(
            path: AppRoutes.editProfile,
            name: 'edit-profile',
            builder: (context, state) => const EditProfileScreen(),
          ),
          GoRoute(
            path: AppRoutes.addresses,
            name: 'addresses',
            builder: (context, state) => const AddressesScreen(),
          ),
          GoRoute(
            path: AppRoutes.addAddress,
            name: 'add-address',
            builder: (context, state) => const AddEditAddressScreen(),
          ),
          GoRoute(
            path: AppRoutes.editAddress,
            name: 'edit-address',
            builder: (context, state) {
              final addressId = state.pathParameters['id'] ?? '';
              return AddEditAddressScreen(addressId: addressId);
            },
          ),
          GoRoute(
            path: AppRoutes.settings,
            name: 'settings',
            builder: (context, state) => const SettingsScreen(),
          ),
          GoRoute(
            path: AppRoutes.paymentMethods,
            name: 'payment-methods',
            builder: (context, state) => const PaymentMethodsScreen(),
          ),
        ],
      ),
    ],

    // Redirect para proteção de rotas
    redirect: (context, state) {
      // TODO: Implementar verificação de autenticação
      // final isLoggedIn = AuthService.isLoggedIn();
      // final isLoggingIn = state.matchedLocation == AppRoutes.login ||
      //     state.matchedLocation == AppRoutes.register ||
      //     state.matchedLocation == AppRoutes.forgotPassword;
      //
      // if (!isLoggedIn && !isLoggingIn) {
      //   return AppRoutes.login;
      // }
      //
      // if (isLoggedIn && isLoggingIn) {
      //   return AppRoutes.home;
      // }
      return null;
    },
  );
}

/// Scaffold com bottom navigation bar persistente para o ShellRoute
class ScaffoldWithBottomNav extends ConsumerWidget {
  final Widget child;

  const ScaffoldWithBottomNav({super.key, required this.child});

  int _getCurrentIndex(String location) {
    if (location.startsWith(AppRoutes.menu)) return 1;
    if (location.startsWith(AppRoutes.cart)) return 2;
    if (location.startsWith(AppRoutes.orders)) return 3;
    if (location.startsWith(AppRoutes.profile)) return 4;
    if (location.startsWith(AppRoutes.addresses)) return 4;
    if (location.startsWith(AppRoutes.settings)) return 4;
    if (location.startsWith(AppRoutes.paymentMethods)) return 4;
    if (location.startsWith(AppRoutes.editProfile)) return 4;
    return 0; // home
  }

  Widget _buildCartIcon(int count, bool selected) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Icon(
          selected ? Icons.shopping_cart : Icons.shopping_cart_outlined,
          size: 24,
        ),
        if (count > 0)
          Positioned(
            right: -6,
            top: -6,
            child: AnimatedScale(
              scale: count > 0 ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 200),
              curve: Curves.elasticOut,
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.red.withValues(alpha: 0.4),
                      blurRadius: 4,
                      spreadRadius: 1,
                    ),
                  ],
                ),
                constraints: const BoxConstraints(minWidth: 18, minHeight: 18),
                child: Center(
                  child: Text(
                    count > 99 ? '99+' : '$count',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final location = GoRouterState.of(context).uri.toString();
    final currentIndex = _getCurrentIndex(location);
    final cartItemCount = ref.watch(cartItemCountProvider);

    return Scaffold(
      body: child,
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentIndex,
        onDestinationSelected: (index) {
          switch (index) {
            case 0:
              context.go(AppRoutes.home);
              break;
            case 1:
              context.go(AppRoutes.menu);
              break;
            case 2:
              context.go(AppRoutes.cart);
              break;
            case 3:
              context.go(AppRoutes.orders);
              break;
            case 4:
              context.go(AppRoutes.profile);
              break;
          }
        },
        destinations: [
          NavigationDestination(
            icon: Icon(Icons.local_pizza_outlined),
            selectedIcon: Icon(Icons.local_pizza),
            label: 'Início',
          ),
          NavigationDestination(
            icon: Icon(Icons.restaurant_menu_outlined),
            selectedIcon: Icon(Icons.restaurant_menu),
            label: 'Cardápio',
          ),
          NavigationDestination(
            icon: _buildCartIcon(cartItemCount, false),
            selectedIcon: _buildCartIcon(cartItemCount, true),
            label: 'Carrinho',
          ),
          NavigationDestination(
            icon: Icon(Icons.receipt_long_outlined),
            selectedIcon: Icon(Icons.receipt_long),
            label: 'Pedidos',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Perfil',
          ),
        ],
      ),
    );
  }
}

/// Placeholder screens para rotas que ainda não existem
class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Recuperar Senha')),
      body: const Center(child: Text('Tela de recuperar senha - Em desenvolvimento')),
    );
  }
}

class PaymentMethodsScreen extends StatelessWidget {
  const PaymentMethodsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Formas de Pagamento'),
        leading: BackButton(onPressed: () => _safePop(context)),
      ),
      body: const Center(child: Text('Formas de Pagamento - Em desenvolvimento')),
    );
  }
}

/// Helper para navegação segura: pop se possível, senão vai para home
void _safePop(BuildContext context) {
  if (context.canPop()) {
    context.pop();
  } else {
    context.go(AppRoutes.home);
  }
}