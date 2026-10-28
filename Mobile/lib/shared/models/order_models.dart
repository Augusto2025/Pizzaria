import 'package:flutter/material.dart';
import 'package:pizza/core/constants/app_colors.dart';

/// Modelos compartilhados entre features

/// Status do pedido
enum OrderStatus {
  pending,
  confirmed,
  preparing,
  baking,
  ready,
  outForDelivery,
  delivered,
  cancelled,
}

extension OrderStatusExtension on OrderStatus {
  String get label {
    switch (this) {
      case OrderStatus.pending:
        return 'Aguardando';
      case OrderStatus.confirmed:
        return 'Confirmado';
      case OrderStatus.preparing:
        return 'Preparando';
      case OrderStatus.baking:
        return 'No Forno';
      case OrderStatus.ready:
        return 'Pronto';
      case OrderStatus.outForDelivery:
        return 'Saiu p/ Entrega';
      case OrderStatus.delivered:
        return 'Entregue';
      case OrderStatus.cancelled:
        return 'Cancelado';
    }
  }

  Color get color {
    switch (this) {
      case OrderStatus.pending:
        return AppColors.warning;
      case OrderStatus.confirmed:
        return AppColors.statusConfirmed;
      case OrderStatus.preparing:
        return AppColors.statusPreparing;
      case OrderStatus.baking:
        return AppColors.statusBaking;
      case OrderStatus.ready:
        return AppColors.success;
      case OrderStatus.outForDelivery:
        return AppColors.statusOutForDelivery;
      case OrderStatus.delivered:
        return AppColors.success;
      case OrderStatus.cancelled:
        return AppColors.error;
    }
  }

  bool get isActive {
    return index < OrderStatus.delivered.index;
  }
}

/// Categoria de produto
enum ProductCategory {
  pizza,
  drink,
  dessert,
  side,
}

extension ProductCategoryExtension on ProductCategory {
  String get label {
    switch (this) {
      case ProductCategory.pizza:
        return 'Pizzas';
      case ProductCategory.drink:
        return 'Bebidas';
      case ProductCategory.dessert:
        return 'Sobremesas';
      case ProductCategory.side:
        return 'Acompanhamentos';
    }
  }
}

/// Forma de pagamento
enum PaymentMethod {
  cash,
  card,
  pix,
  wallet,
}

extension PaymentMethodExtension on PaymentMethod {
  String get label {
    switch (this) {
      case PaymentMethod.cash:
        return 'Dinheiro';
      case PaymentMethod.card:
        return 'Cartão';
      case PaymentMethod.pix:
        return 'PIX';
      case PaymentMethod.wallet:
        return 'Saldo do App';
    }
  }
}