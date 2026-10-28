import 'package:flutter/material.dart';

/// Cores do Design System da Pizzaria
class AppColors {
  // Private constructor to prevent instantiation
  AppColors._();

  /// Laranja principal da marca
  static const Color primary = Color(0xFFFF6B35);
  static const Color primaryVariant = Color(0xFFE85D2E);
  static const Color primaryLight = Color(0xFFFF8A5B);
  static const Color primaryDark = Color(0xFFCC562A);

  /// Cinza escuro / quase preto
  static const Color secondary = Color(0xFF2D2D2D);
  static const Color secondaryLight = Color(0xFF4A4A4A);

  /// Backgrounds
  static const Color background = Color(0xFFFFFFFF);
  static const Color surface = Color(0xFFF5F5F5);
  static const Color surfaceVariant = Color(0xFFEEEEEE);

  /// Status colors
  static const Color error = Color(0xFFDC3545);
  static const Color success = Color(0xFF28A745);
  static const Color warning = Color(0xFFFFC107);
  static const Color info = Color(0xFF17A2B8);

  /// Text colors
  static const Color textPrimary = Color(0xFF1A1A1A);
  static const Color textSecondary = Color(0xFF666666);
  static const Color textOnPrimary = Color(0xFFFFFFFF);
  static const Color textOnSecondary = Color(0xFFFFFFFF);
  static const Color textDisabled = Color(0xFF999999);

  /// Border / Divider
  static const Color border = Color(0xFFE0E0E0);
  static const Color divider = Color(0xFFE8E8E8);

  /// Shadows
  static const Color shadow = Color(0x1A000000); // 10% opacity black

  /// Order Status Colors
  static const Color statusPending = Color(0xFFFFC107);
  static const Color statusConfirmed = Color(0xFF17A2B8);
  static const Color statusPreparing = Color(0xFFFD7E14);
  static const Color statusBaking = Color(0xFFE85D2E);
  static const Color statusReady = Color(0xFF28A745);
  static const Color statusOutForDelivery = Color(0xFF6F42C1);
  static const Color statusDelivered = Color(0xFF28A745);
  static const Color statusCancelled = Color(0xFFDC3545);

  /// Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primary, primaryVariant],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient backgroundGradient = LinearGradient(
    colors: [Color(0xFFFFF8F5), Color(0xFFFFFFFF)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}

/// Extensão para facilitar uso de cores de status
extension OrderStatusColor on Color {
  static Color fromStatus(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return AppColors.statusPending;
      case 'confirmed':
        return AppColors.statusConfirmed;
      case 'preparing':
        return AppColors.statusPreparing;
      case 'baking':
        return AppColors.statusBaking;
      case 'ready':
        return AppColors.statusReady;
      case 'out_for_delivery':
        return AppColors.statusOutForDelivery;
      case 'delivered':
        return AppColors.statusDelivered;
      case 'cancelled':
        return AppColors.statusCancelled;
      default:
        return AppColors.textSecondary;
    }
  }
}