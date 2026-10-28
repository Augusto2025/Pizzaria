import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pizza/core/constants/app_routes.dart';
import 'package:pizza/features/auth/presentation/screens/login_screen.dart';
import 'package:pizza/features/auth/presentation/screens/register_screen.dart';
import 'package:pizza/features/home/presentation/screens/home_screen.dart';
import 'package:pizza/features/menu/presentation/screens/menu_screen.dart';
import 'package:pizza/features/cart/presentation/screens/cart_screen.dart';
import 'package:pizza/features/orders/presentation/screens/orders_screen.dart';
import 'package:pizza/features/orders/presentation/screens/order_detail_screen.dart';
import 'package:pizza/features/profile/presentation/screens/profile_screen.dart';

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
class ScaffoldWithBottomNav extends StatelessWidget {
  final Widget child;

  const ScaffoldWithBottomNav({super.key, required this.child});

  int _getCurrentIndex(String location) {
    if (location.startsWith(AppRoutes.menu)) return 1;
    if (location.startsWith(AppRoutes.orders)) return 2;
    if (location.startsWith(AppRoutes.profile)) return 3;
    if (location.startsWith(AppRoutes.addresses)) return 3;
    if (location.startsWith(AppRoutes.settings)) return 3;
    if (location.startsWith(AppRoutes.paymentMethods)) return 3;
    if (location.startsWith(AppRoutes.editProfile)) return 3;
    return 0; // home
  }

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();
    final currentIndex = _getCurrentIndex(location);

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
              context.go(AppRoutes.orders);
              break;
            case 3:
              context.go(AppRoutes.profile);
              break;
          }
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Início',
          ),
          NavigationDestination(
            icon: Icon(Icons.restaurant_menu_outlined),
            selectedIcon: Icon(Icons.restaurant_menu),
            label: 'Cardápio',
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

class ProductDetailScreen extends StatelessWidget {
  final String productId;
  const ProductDetailScreen({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhes do Produto'),
        leading: BackButton(onPressed: () => _safePop(context)),
      ),
      body: Center(child: Text('Produto: $productId - Em desenvolvimento')),
    );
  }
}

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Finalizar Pedido'),
        leading: BackButton(onPressed: () => _safePop(context)),
      ),
      body: const Center(child: Text('Checkout - Em desenvolvimento')),
    );
  }
}

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Perfil'),
        leading: BackButton(onPressed: () => _safePop(context)),
      ),
      body: const Center(child: Text('Editar Perfil - Em desenvolvimento')),
    );
  }
}

class AddressesScreen extends StatelessWidget {
  const AddressesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Endereços'),
        leading: BackButton(onPressed: () => _safePop(context)),
      ),
      body: const Center(child: Text('Endereços - Em desenvolvimento')),
    );
  }
}

class AddEditAddressScreen extends StatelessWidget {
  final String? addressId;
  const AddEditAddressScreen({super.key, this.addressId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(addressId == null ? 'Novo Endereço' : 'Editar Endereço'),
        leading: BackButton(onPressed: () => _safePop(context)),
      ),
      body: Center(child: Text('Endereço: ${addressId ?? 'novo'} - Em desenvolvimento')),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Configurações'),
        leading: BackButton(onPressed: () => _safePop(context)),
      ),
      body: const Center(child: Text('Configurações - Em desenvolvimento')),
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