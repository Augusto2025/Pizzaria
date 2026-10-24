/// Rotas da aplicação
class AppRoutes {
  AppRoutes._();

  // Public routes
  static const String login = '/login';
  static const String register = '/register';
  static const String forgotPassword = '/forgot-password';

  // Protected routes
  static const String home = '/home';
  static const String menu = '/menu';
  static const String menuCategory = '/menu/:category';
  static const String productDetail = '/product/:id';
  static const String cart = '/cart';
  static const String checkout = '/checkout';
  static const String orders = '/orders';
  static const String orderDetail = '/orders/:id';
  static const String profile = '/profile';
  static const String editProfile = '/profile/edit';
  static const String addresses = '/profile/addresses';
  static const String addAddress = '/profile/addresses/new';
  static const String editAddress = '/profile/addresses/:id/edit';
  static const String settings = '/settings';
  static const String paymentMethods = '/profile/payment-methods';

  // Helper methods
  static String productDetailRoute(String id) => '/product/$id';
  static String orderDetailRoute(String id) => '/orders/$id';
  static String menuCategoryRoute(String category) => '/menu/$category';
  static String editAddressRoute(String id) => '/profile/addresses/$id/edit';
}