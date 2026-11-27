# Pizzaria Delivery App - Documentação do Projeto Mobile (Flutter)

## Visão Geral
Sistema de delivery para pizzaria — versão mobile multiplataforma (iOS/Android) desenvolvida em **Flutter 3.13+** com **Dart 3.0+**. Clientes fazem pedidos pelo app e acompanham o status em tempo real. Arquitetura **Clean Architecture** com organização **feature-first**, gerenciamento de estado via **Riverpod 3.x**, navegação com **go_router**, e comunicação HTTP via **Dio**.

---

## Arquitetura do Projeto

### Estrutura de Pastas (`lib/`)
```
lib/
├── main.dart                 # Ponto de entrada do app
├── injection.dart            # Dependency injection (GetIt)
├── core/
│   ├── constants/           # Constantes globais (cores, textos, rotas)
│   │   ├── app_colors.dart      # Design System - cores
│   │   ├── app_strings.dart     # Textos centralizados
│   │   ├── app_routes.dart      # Definição de rotas
│   │   └── index.dart           # Barrel exports
│   ├── theme/               # Tema da aplicação
│   │   ├── app_theme.dart       # Light/Dark Theme (Material 3)
│   │   └── index.dart
│   ├── router/              # Configuração de rotas (go_router)
│   │   ├── app_router.dart      # GoRouter + ShellRoute + BottomNav
│   │   └── index.dart
│   └── services/            # Serviços transversais
│       ├── auth_service.dart    # Auth (token, login, register, logout)
│       └── index.dart
├── features/
│   ├── auth/                # Feature de autenticação
│   │   └── presentation/
│   │       └── screens/
│   │           ├── login_screen.dart      # Login com validação + show/hide password
│   │           └── register_screen.dart   # Registro completo + validação campo a campo
│   ├── home/                # Feature home/dashboard
│   │   └── presentation/
│   │       └── screens/
│   │           └── home_screen.dart       # Welcome, quick actions, último pedido, promoções
│   ├── menu/                # Cardápio de pizzas
│   │   └── presentation/
│   │       └── screens/
│   │           └── menu_screen.dart       # Tabs categorias + grid produtos + personalização
│   ├── cart/                # Carrinho de compras
│   │   └── presentation/
│   │       └── screens/
│   │           └── cart_screen.dart       # Itens, quantidades, endereço, pagamento, checkout
│   ├── orders/              # Pedidos e rastreamento
│   │   └── presentation/
│   │       └── screens/
│   │           ├── orders_screen.dart     # Lista pedidos + empty state + chips info (Wrap)
│   │           └── order_detail_screen.dart # Timeline animada + detalhes + ações
│   └── profile/             # Perfil do usuário
│       └── presentation/
│           └── screens/
│               └── profile_screen.dart    # Dados, endereços, pagamentos, histórico, logout
├── shared/
│   ├── widgets/             # Widgets reutilizáveis
│   │   ├── custom_button.dart       # Elevated/Outlined + loading + icon
│   │   ├── custom_text_field.dart   # TextFormField padronizado + validação
│   │   ├── custom_search_field.dart # Campo de busca com clear
│   │   └── index.dart
│   ├── models/              # Models compartilhados
│   │   ├── order_models.dart      # Enums: OrderStatus, ProductCategory, PaymentMethod
│   │   └── index.dart
│   └── utils/               # Helpers, extensions (futuro)
└── injection.dart           # GetIt configuration (DI)
```

### Padrões de Arquitetura
- **Clean Architecture** com separação em camadas (data, domain, presentation) — *em implementação*
- **Feature-first** organization — cada feature isolada com sua própria presentation
- **Riverpod 3.x** para gerenciamento de estado (**AsyncNotifier** / **Notifier** + **AsyncNotifierProvider** / **NotifierProvider** — providers migrados)
- **go_router** para navegação declarativa com **ShellRoute** + **BottomNavigationBar** persistente
- **Repository Pattern** para abstração de dados (interfaces definidas no `injection.dart`, implementações pendentes)
- **Use Cases** para lógica de negócio (comentados no `injection.dart`, a implementar)
- **GetIt** para Dependency Injection (service locator)
- **Freezed 3.x + JSON Serializable** para models imutáveis e serialização (configurado no pubspec)

---

## Funcionalidades Principais

### 1. Autenticação (Auth) — **Implementado (UI + Mock)**
- **Login**: Email + Senha
  - Validação de email (regex) e senha (mín. 6 chars)
  - Show/hide password (ícone 👁/🙈)
  - Loading state no botão
  - Link "Esqueci a senha" → `/forgot-password` (placeholder)
- **Registro**: Nome completo, Email, Telefone, Senha, Confirmar Senha
  - Validação campo a campo (inline errors via `TextFormField.validator`)
  - Máscara visual de telefone no hint `(11) 99999-9999`
  - Show/hide password em **ambos** campos (Senha + Confirmar)
  - Validação: nome completo (mín. 2 palavras), email único, senhas coincidem
  - Checkbox "Aceito Termos de Uso e Política de Privacidade" (obrigatório)
  - Loading state no botão
  - Link "Já tem conta? Entrar" → `/login`
- **Logout**: Dialog de confirmação → limpa storage → navega para `/login`
- **Persistência de sessão**: `FlutterSecureStorage` (token) + `SharedPreferences` (user data)
- **AuthService** mock: simula API com delay 1s, aceita qualquer credencial válida
- **Roteamento protegido**: `redirect` no `GoRouter` comentado (TODO: implementar verificação real)

### 2. Home / Dashboard — **Implementado (UI + Mock)**
- Boas-vindas personalizada com gradiente laranja (brand)
- Quick Actions: Cardápio, Meus Pedidos, Promoções, Favoritos
  - **Horizontal `ListView`** com largura fixa (`width: 80`) — evita overflow de texto
  - Cards com ícone colorido + label (max 2 linhas, ellipsis)
- Status do último pedido (empty state com CTA "Fazer pedido")
- Promoções em destaque: horizontal `ListView` com cards gradientes + badge "PROMOÇÃO"

### 3. Cardápio (Menu) — **Implementado (UI + Mock + API Real)**
- Abas de categoria via `TabBar` + `TabBarView`: Pizzas, Bebidas, Sobremesas, Acompanhamentos
- Lista de produtos por categoria (`ListView.builder`) — **filtro por `categoryDisplayName` (português) vindo da API**
- **ProductCard** otimizado para evitar overflow:
  - Nome: `maxLines: 1` + `overflow: TextOverflow.ellipsis`
  - Badge "Indisponível" **abaixo** do nome (não inline) — evita overflow horizontal
  - Descrição: `maxLines: 2` + ellipsis
  - Preço + botão: `SizedBox(width: 70)` com `IconButton` (apenas ícone carrinho) — compacto
  - Imagem: `ClipRRect` 100x100 com `Image.network` + error builder
- Navega para `/product/:id` (placeholder `ProductDetailScreen`)

### 4. Carrinho (Cart) — **Implementado (UI + Mock)**
- Empty state: ilustração + CTA "Cardápio"
- Lista de itens: imagem, nome, descrição, preço unitário, **controle quantidade** (+/-), total por item
  - Quantidade 1 → botão "-" remove item
- Resumo fixo no bottom: Subtotal, Taxa entrega (R$ 5,90), Total
- Botão "Finalizar pedido - R$ XX,XX" → navega para `/checkout` (placeholder)

### 5. Pedidos (Orders) — **Implementado (UI + Mock)**
- **OrdersScreen**: Lista de pedidos com cards
  - Header: ID + badge status colorido (container com cor do status + label)
  - Data formatada `dd/MM/yyyy HH:mm` (pt_BR via `intl`)
  - **Chips de info em `Wrap`** (não `Row`) — quebra automática em telas estreitas:
    - Ícone + "X itens"
    - Ícone + "R$ XX,XX"
    - Ícone + "Entregue dd/MM/yyyy HH:mm" (se houver)
  - Pedidos ativos: divider + "Toque para acompanhar"
  - Empty state: ilustração + CTA "Fazer pedido"
- **OrderDetailScreen**: Rastreamento completo
  - **Timeline animada** vertical com `AnimationController`:
    - Círculos: cinza (futuro), cor do status (atual/concluído), checkmark (concluído)
    - Linha conectando: cor do status se concluído, cinza se futuro
    - Badge pulsante "AGORA" no status atual (animated)
    - Timestamps mock por status
  - Se cancelado: card vermelho explicativo (sem timeline)
  - Informações do pedido: data, previsão, endereço, pagamento
  - Itens: lista com quantidade + preço total por item
  - Totais: Subtotal, Taxa, Total (destacado)
  - Ações: "Pedir novamente" (outlined), "Cancelar pedido" (vermelho outlined + dialog confirmação)

### 6. Perfil (Profile) — **Implementado (UI + Mock)**
- Card do usuário: avatar (inicial do nome), nome, email, telefone, botão "Editar perfil"
- Menu options (ListTile cards):
  - Endereços → `/profile/addresses` (placeholder)
  - Formas de pagamento → `/profile/payment-methods` (placeholder)
  - Histórico de pedidos → `/orders`
  - Configurações → `/settings` (placeholder)
- **Logout**: Dialog confirmação → `AuthService.logout()` → `/login`
- **Excluir conta**: Dialog confirmação (placeholder)

---

## Modelos de Dados (Dart)

### Enums (shared/models/order_models.dart)
```dart
enum OrderStatus {
  pending, confirmed, preparing, baking, ready, outForDelivery, delivered, cancelled
}

extension OrderStatusExtension on OrderStatus {
  String get label { ... }  // "Aguardando", "Confirmado", "Preparando", "No Forno", "Pronto", "Saiu p/ Entrega", "Entregue", "Cancelado"
  Color get color { ... }   // Cores do AppColors por status
  bool get isActive => index < OrderStatus.delivered.index;
}

enum ProductCategory { pizza, drink, dessert, side }
extension ProductCategoryExtension on ProductCategory {
  String get label { ... }  // "Pizzas", "Bebidas", "Sobremesas", "Acompanhamentos"
}

enum PaymentMethod { cash, card, pix, wallet }
extension PaymentMethodExtension on PaymentMethod {
  String get label { ... }  // "Dinheiro", "Cartão", "PIX", "Saldo do App"
}
```

### Models Mock (definidos inline nas telas — *futuro: mover para domain*)
```dart
// Produto (MenuScreen)
class _MockProduct {
  final String id, name, description, imageUrl;
  final double price;
  final int prepTime;
  final bool isAvailable;
}

// Item do Carrinho (CartScreen)
class _CartItem {
  final String id, name, description, imageUrl;
  final double price;
  final int quantity;
  double get totalPrice => price * quantity;
}

// Pedido Lista (OrdersScreen)
class _MockOrder {
  final String id;
  final DateTime date;
  final OrderStatus status;
  final double total;
  final int itemsCount;
  final DateTime? estimatedDelivery;
}

// Pedido Detalhe (OrderDetailScreen)
class _MockOrderDetail {
  final String id;
  final DateTime createdAt;
  final OrderStatus status;
  final DateTime estimatedDelivery;
  final double subtotal, deliveryFee, total;
  final String address, paymentMethod;
  final List<_MockOrderItem> items;
}
class _MockOrderItem { final String name; final int quantity; final double price; }
```

---

## Fluxo de Navegação

### Rotas Públicas (sem auth)
- `/login` — `LoginScreen`
- `/register` — `RegisterScreen`
- `/forgot-password` — `ForgotPasswordScreen` (placeholder)

### Rotas Protegidas (requer auth) — **ShellRoute com BottomNavigationBar**
```
ShellRoute (ScaffoldWithBottomNav)
├── /home                    → HomeScreen (index 0)
├── /menu                    → MenuScreen (index 1)
│   └── /menu/:category      → MenuScreen(initialCategory)
├── /product/:id             → ProductDetailScreen (placeholder)
├── /cart                    → CartScreen (no bottom nav - dentro do shell)
├── /checkout                → CheckoutScreen (placeholder)
├── /orders                  → OrdersScreen (index 2)
│   └── /orders/:id          → OrderDetailScreen
├── /profile                 → ProfileScreen (index 3)
│   ├── /profile/edit        → EditProfileScreen (placeholder)
│   ├── /profile/addresses   → AddressesScreen (placeholder)
│   │   ├── /profile/addresses/new     → AddEditAddressScreen
│   │   └── /profile/addresses/:id/edit → AddEditAddressScreen
│   ├── /settings            → SettingsScreen (placeholder)
│   └── /profile/payment-methods → PaymentMethodsScreen (placeholder)
```

### Navegação Bottom Nav (ScaffoldWithBottomNav)
| Index | Rota Base | Label | Ícone |
|-------|-----------|-------|-------|
| 0 | `/home` | Início | `home_outlined` / `home` |
| 1 | `/menu` | Cardápio | `restaurant_menu_outlined` / `restaurant_menu` |
| 2 | `/orders` | Pedidos | `receipt_long_outlined` / `receipt_long` |
| 3 | `/profile` | Perfil | `person_outline` / `person` |

**Lógica de seleção**: `_getCurrentIndex(location)` verifica prefixo da rota (`startsWith`).

### Helpers de Rota (AppRoutes)
```dart
static String productDetailRoute(String id) => '/product/$id';
static String orderDetailRoute(String id) => '/orders/$id';
static String menuCategoryRoute(String category) => '/menu/$category';
static String editAddressRoute(String id) => '/profile/addresses/$id/edit';
```

---

## Gerenciamento de Estado (Riverpod 3.x)

### Providers Implementados (Migração Riverpod 2.x → 3.x)
```dart
// auth_providers.dart — Notifier<UserDto?> + AsyncNotifier<void>
final currentUserProvider = NotifierProvider<CurrentUserNotifier, UserDto?>(CurrentUserNotifier.new);
final authProvider = AsyncNotifierProvider<AuthNotifier, void>(AuthNotifier.new);

// cart_providers.dart — AsyncNotifier<void>
final cartProvider = FutureProvider<CartResponse>((ref) async { ... });
final cartNotifierProvider = AsyncNotifierProvider<CartNotifier, void>(CartNotifier.new);

// menu_providers.dart — FutureProvider + family
final menuProvider = FutureProvider<MenuResponse>((ref) async { ... });
final productsByCategoryProvider = Provider.family<List<ProductDto>, String>((ref, categoryName) { ... });
final productProvider = FutureProvider.family<ProductDto, String>((ref, id) async { ... });

// order_providers.dart — AsyncNotifier<void>
final ordersProvider = FutureProvider<OrdersResponse>((ref) async { ... });
final orderProvider = FutureProvider.family<OrderDto, String>((ref, id) async { ... });
final orderNotifierProvider = AsyncNotifierProvider<OrderNotifier, void>(OrderNotifier.new);

// address_providers.dart — AsyncNotifier<void>
final addressesProvider = FutureProvider<List<AddressDto>>((ref) async { ... });
final addressProvider = FutureProvider.family<AddressDto, String>((ref, id) async { ... });
final addressNotifierProvider = AsyncNotifierProvider<AddressNotifier, void>(AddressNotifier.new);
```

### Mudanças Riverpod 3.x (Breaking Changes)
| Antes (2.x) | Agora (3.x) |
|-------------|-------------|
| `StateNotifier<T>` | `Notifier<T>` (simples) ou `AsyncNotifier<T>` (async) |
| `StateNotifierProvider<Notifier, State>` | `NotifierProvider<Notifier, State>` ou `AsyncNotifierProvider<Notifier, State>` |
| `state = value` no construtor | `build()` retorna estado inicial; `state = value` nos métodos |
| `ref.watch(provider.notifier)` | Igual (acessa o notifier para chamar métodos) |
| `AsyncValue<T>` manual | `AsyncNotifier` gerencia `AsyncValue` automaticamente |

### Integração
- Providers **implementados** em `lib/core/providers/*_providers.dart`
- Telas usam `ref.watch(provider)` / `ref.read(provider.notifier).method()`
- `injection.dart` configura DI (GetIt) para repositories e services

---

## Dependências Principais (`pubspec.yaml`)

```yaml
dependencies:
  flutter:
    sdk: flutter
  # State Management — Riverpod 3.x
  flutter_riverpod: ^3.5.0
  riverpod_annotation: ^4.0.8
  
  # Navigation
  go_router: ^14.2.0
  
  # Network
  dio: ^5.5.0+1
  pretty_dio_logger: ^1.3.1
  
  # Storage
  shared_preferences: ^2.2.2
  flutter_secure_storage: ^9.0.0
  
  # JSON Serialization — freezed 3.x
  json_annotation: ^4.9.0
  freezed_annotation: ^3.1.0
  
  # UI
  cached_network_image: ^3.3.1
  shimmer: ^3.0.0
  flutter_staggered_animations: ^1.1.1
  
  # Utils
  intl: ^0.20.3
  equatable: ^2.0.5
  uuid: ^4.3.3
  get_it: ^8.0.0
  
  # Icons
  cupertino_icons: ^1.0.6

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^6.0.0
  riverpod_generator: ^4.0.10
  build_runner: ^2.17.1
  json_serializable: ^6.8.0
  freezed: ^4.0.3
  riverpod_lint: ^3.2.0
  analyzer_plugin: ^0.14.0
```

### Comandos de Geração de Código
```bash
# Gerar código (freezed, json_serializable, riverpod)
dart run build_runner build --delete-conflicting-outputs

# Watch mode para geração contínua
dart run build_runner watch
```

---

## Convenções de Código

### Naming
| Tipo | Convenção | Exemplo |
|------|-----------|---------|
| Arquivos | snake_case | `login_screen.dart`, `order_models.dart` |
| Classes | PascalCase | `LoginScreen`, `OrderStatus` |
| Variáveis/Functions | camelCase | `userName`, `fetchOrders()` |
| Constantes | SCREAMING_SNAKE_CASE | `API_BASE_URL`, `DEFAULT_DELIVERY_FEE` |
| Providers | camelCase + sufixo `Provider` | `authProvider`, `cartProvider` |
| Enums | PascalCase singular | `OrderStatus`, `ProductCategory` |
| Extensions | PascalCase + `Extension` | `OrderStatusExtension` |

### Commits (Conventional Commits)
```
feat: nova funcionalidade
fix: correção de bug
refactor: refatoração sem mudança de comportamento
style: formatação, ponto e vírgula, etc
docs: documentação
test: testes
chore: tarefas de build, dependências
```

### Branch Strategy
- `main` — Produção
- `develop` — Desenvolvimento
- `feature/*` — Novas features
- `fix/*` — Correções
- `release/*` — Preparação de release

---

## Design System

### Cores Principais (`AppColors`)
```dart
// Brand
primary: Color(0xFFFF6B35)        // Laranja principal
primaryVariant: Color(0xFFE85D2E)
primaryLight: Color(0xFFFF8A5B)
primaryDark: Color(0xFFCC562A)

// Neutros
secondary: Color(0xFF2D2D2D)      // Cinza escuro
secondaryLight: Color(0xFF4A4A4A)
background: Color(0xFFFFFFFF)     // Branco
surface: Color(0xFFF5F5F5)        // Cinza claro
surfaceVariant: Color(0xFFEEEEEE)

// Status
error: Color(0xFFDC3545)
success: Color(0xFF28A745)
warning: Color(0xFFFFC107)
info: Color(0xFF17A2B8)

// Textos
textPrimary: Color(0xFF1A1A1A)
textSecondary: Color(0xFF666666)
textOnPrimary: Color(0xFFFFFFFF)
textOnSecondary: Color(0xFFFFFFFF)
textDisabled: Color(0xFF999999)

// Bordas
border: Color(0xFFE0E0E0)
divider: Color(0xFFE8E8E8)

// Sombras
shadow: Color(0x1A000000)         // 10% opacity black

// Status de Pedido
statusPending: Color(0xFFFFC107)
statusConfirmed: Color(0xFF17A2B8)
statusPreparing: Color(0xFFFD7E14)
statusBaking: Color(0xFFE85D2E)
statusReady: Color(0xFF28A745)
statusOutForDelivery: Color(0xFF6F42C1)
statusDelivered: Color(0xFF28A745)
statusCancelled: Color(0xFFDC3545)

// Gradientes
primaryGradient: LinearGradient([primary, primaryVariant], TL → BR)
backgroundGradient: LinearGradient([#FFF8F5, #FFFFFF], Top → Bottom)
```

### Tipografia (Material 3 via `AppTheme`)
| Style | Tamanho | Peso | Cor |
|-------|---------|------|-----|
| displayLarge | 32 | Bold | textPrimary |
| displayMedium | 28 | Bold | textPrimary |
| displaySmall | 24 | w600 | textPrimary |
| headlineLarge | 22 | w600 | textPrimary |
| headlineMedium | 20 | w600 | textPrimary |
| headlineSmall | 18 | w600 | textPrimary |
| titleLarge | 16 | w600 | textPrimary |
| titleMedium | 14 | w500 | textPrimary |
| titleSmall | 12 | w500 | textPrimary |
| bodyLarge | 16 | Normal | textPrimary |
| bodyMedium | 14 | Normal | textPrimary |
| bodySmall | 12 | Normal | textSecondary |
| labelLarge | 14 | w500 | textPrimary |
| labelMedium | 12 | w500 | textSecondary |
| labelSmall | 10 | w500 | textDisabled |

### Espaçamento (Base 8px)
- xs: 4px, sm: 8px, md: 16px, lg: 24px, xl: 32px, xxl: 48px

### Border Radius
- sm: 4px, md: 8px, lg: 12px, xl: 16px, xxl: 20px, full: 999px

### Sombras (Cards)
```dart
BoxShadow(
  color: AppColors.shadow,
  blurRadius: 8,
  offset: Offset(0, 2),
)
```

### Componentes de Tema Configurados (`AppTheme.lightTheme`)
- `AppBarTheme`: background branco, título centralizado, elevation 0
- `CardTheme`: elevation 2, radius 12, margin horizontal 16/vertical 8
- `ElevatedButtonTheme`: primary background, radius 12, padding 24x14
- `OutlinedButtonTheme`: primary border 1.5, radius 12
- `TextButtonTheme`: primary text, radius 8
- `InputDecorationTheme`: filled surface, radius 12, focused border primary 2px
- `ChipTheme`: surface background, primary selected, radius 20
- `NavigationBarTheme` (M3): height 70, indicator primary 15%, label/icon color states
- `BottomNavigationBarTheme`: fixed type, elevation 8
- `DialogTheme`: radius 16, elevation 8
- `BottomSheetTheme`: radius top 20, elevation 8
- `SnackBarTheme`: floating, radius 12, secondary background
- `TabBarTheme`: label primary, indicator primary, label size
- `SliderTheme`, `ProgressIndicatorTheme`, `FloatingActionButtonTheme`, `ListTileTheme`, `DividerTheme` — todos configurados

### Skeleton Loading (Shimmer) — **Implementado**
Widget `SkeletonLoader` reutilizável em `lib/shared/widgets/skeleton_loader.dart` com animação shimmer reversa (1.5s). Inclui variantes especializadas:

| Widget | Uso | Tela |
|--------|-----|------|
| `SkeletonLoader` | Base circular/retangular | Todos |
| `SkeletonText` | Linhas de texto (títulos, descrições) | Todos |
| `SkeletonGridItem` | Cards de produto (imagem + título + desc + preço) | Menu |
| `SkeletonOrderCard` | Cards de pedido (ID + status + chips + endereço) | Pedidos |
| `SkeletonCartItem` | Itens do carrinho (imagem + nome + qty + preço) | Carrinho |
| `SkeletonPromotionCard` | Cards de promoção horizontal | Home |
| `SkeletonQuickActionCard` | Ações rápidas (ícone + label) | Home |
| `SkeletonUserInfoCard` | Perfil (avatar + nome + email + telefone + botão) | Perfil |
| `SkeletonProfileOption` | Menu perfil (ícone + título + subtítulo + chevron) | Perfil |
| `ShimmerSkeleton` | Wrapper genérico para skeletons customizados | Qualquer |

**Aplicado nas telas:**
- **HomeScreen**: Quick Actions, Último Pedido, Promoções
- **MenuScreen**: Lista de produtos por categoria (TabBarView)
- **OrdersScreen**: Lista de pedidos
- **OrderDetailScreen**: Timeline, Info, Itens, Pagamento/Endereço, Ações
- **CartScreen**: Lista de itens + Resumo fixo
- **ProfileScreen**: Card usuário + Menu options
- **AddressesScreen**: Lista de endereços
- **AddEditAddressScreen**: Formulário (quando editando endereço existente)

**Padrão de uso:**
```dart
// No build do ConsumerWidget/ConsumerStatefulWidget
final dataAsync = ref.watch(dataProvider);

body: dataAsync.when(
  data: (data) => _buildContent(data),
  loading: () => _buildSkeleton(),  // Método privado retorna skeleton
  error: (e, s) => _buildError(e),
),

// Exemplo skeleton method
Widget _buildSkeleton() {
  return ListView.builder(
    padding: const EdgeInsets.all(16),
    itemCount: 6,
    itemBuilder: (_, __) => const SkeletonGridItem(),
  );
}
```

---

## Próximos Passos (Roadmap)

### Fase 1 - MVP (UI Mock Completa + Providers Riverpod 3.x + API Real)
- [x] Configurar dependências (Riverpod 3.x, go_router, Dio, Freezed 3.x, GetIt)
- [x] Auth UI: Login + Registro + Validação + Show/Hide Password
- [x] Home: Welcome, Quick Actions (ListView horizontal), Último Pedido, Promoções
- [x] Menu: Tabs categorias + Lista produtos + ProductCard otimizado + **filtro categoryDisplayName**
- [x] Carrinho: Itens, quantidade (+/-), resumo, checkout button
- [x] Pedidos: Lista + Empty State + Chips (Wrap) + Detalhe + Timeline animada
- [x] Perfil: Dados, Menu options, Logout dialog, Excluir conta dialog
- [x] Navegação: GoRouter + ShellRoute + BottomNav + Rotas protegidas
- [x] Design System: Cores, Tipografia, Tema M3 completo, Widgets compartilhados
- [x] DI: GetIt configurado (Dio, SecureStorage, SharedPrefs, AuthService)
- [x] **Riverpod 3.x providers migrados** (AsyncNotifier/Notifier + AsyncNotifierProvider/NotifierProvider)
- [x] **API Render conectada** (https://pizzaria-api-ffie.onrender.com)
- [ ] Conectar Riverpod providers às telas (substituir mock data)
- [ ] Implementar Repositories + Use Cases + Auth real (JWT + refresh)
- [ ] Persistência de carrinho local
- [ ] Testes unitários (ViewModels/Notifiers, Use Cases, Repositories)

### Fase 2 - Melhorias
- [ ] Rastreamento em tempo real (WebSocket / Server-Sent Events / Polling)
- [ ] Notificações push (Firebase Cloud Messaging)
- [ ] Pagamento online (Stripe / Mercado Pago / PIX nativo)
- [ ] Personalização de pizza (borda, ingredientes extras, tamanho) — `ProductDetailScreen`
- [ ] Busca e filtros no cardápio
- [ ] Avaliação de pedidos entregues
- [ ] Programa de fidelidade / Cupons de desconto
- [ ] Favoritos / Reordenar rápido
- [ ] Tema escuro completo (já preparado no `AppTheme.darkTheme`)
- [ ] Internacionalização (i18n) — pt_BR / en_US

### Fase 3 - Admin / Futuro
- [ ] Painel administrativo web (Flutter Web ou separada)
- [ ] Gestão de pedidos (cozinha) — tempo real
- [ ] Gestão de cardápio (CRUD produtos, categorias, promoções)
- [ ] Relatórios de vendas
- [ ] Gestão de entregadores + tracking GPS

---

## Comandos Úteis

```bash
# Instalar dependências
cd Mobile
flutter pub get

# Gerar código (freezed, json_serializable, riverpod)
dart run build_runner build --delete-conflicting-outputs

# Watch mode para geração contínua
dart run build_runner watch

# Rodar app (debug)
flutter run

# Rodar em device específico
flutter run -d <device_id>

# Build release
flutter build apk --release           # Android
flutter build ios --release           # iOS (precisa macOS)
flutter build web --release           # Web

# Analisar código
flutter analyze

# Rodar testes
flutter test

# Ver dependências desatualizadas
flutter pub outdated

# Upgrade dependências
flutter pub upgrade

# Limpar build
flutter clean && flutter pub get

# Ver logs device
flutter logs
```

---

## Checklist para Novos Desenvolvedores/Agentes

Ao trabalhar neste projeto, **SEMPRE**:

1. **Leia este arquivo** antes de começar qualquer tarefa
2. **Siga a estrutura de pastas** feature-first definida acima
3. **Use Riverpod** para todo gerenciamento de estado (não use setState para estado global)
4. **Use go_router** para navegação (não use `Navigator.push` direto)
5. **Crie Use Cases** para lógica de negócio (não coloque lógica nos widgets)
6. **Use Repository Pattern** para acesso a dados (interfaces em `injection.dart`)
7. **Escreva testes** para Notifiers, Use Cases e Repositories
8. **Atualize este arquivo** quando:
   - Adicionar nova feature/tela
   - Mudar arquitetura ou padrões
   - Adicionar dependência importante
   - Mudar convenções
9. **Mantenha consistência visual** com o Design System (`AppColors`, `AppTheme`, `AppStrings`)
10. **Trate erros** adequadamente (try/catch, error states na UI, SnackBars informativos)
11. **Use widgets compartilhados** (`CustomButton`, `CustomTextField`, `CustomSearchField`)
12. **Strings sempre em `AppStrings`** — nada de hardcoded text nos widgets
13. **Cores sempre via `AppColors`** — nada de `Colors.orange` ou hex literais
14. **Rotas via `AppRoutes`** + helpers — nada de strings mágicas
15. **Validação em `CustomTextField.validator`** — reutilize padrões existentes
16. **Mock data apenas para desenvolvimento** — marque com `// TODO: substituir por provider`
17. **Execute `flutter analyze`** antes de commit — zero warnings
18. **Teste visual** — rode o app (`flutter run`) após mudanças no UI

---

## Problemas Conhecidos & Soluções Aplicadas

| Problema | Solução / Padrão Estabelecido |
|----------|-------------------------------|
| `LocaleDataException` com `DateFormat('pt_BR')` | `await initializeDateFormatting('pt_BR', null)` no `main()` **antes** de `runApp()` |
| `GridView` overflow em quick actions (4 colunas) | **`ListView` horizontal + `SizedBox(width: fixo)`** — textos sempre legíveis |
| Botão "Adicionar" com texto quebra em 3-4 linhas no card | **`IconButton` compacto** (apenas ícone) + `tooltip` — sem texto para quebrar |
| Badge "Indisponível" ao lado do nome causa overflow horizontal | Badge **abaixo** do título (coluna), não inline (linha) |
| Chips de info (`Row`) não quebram em telas estreitas | **`Wrap(spacing, runSpacing)`** — responsivo automático sem media queries |
| Coluna de preço/ação expande e quebra layout | `SizedBox(width: 70)` fixo no filho que não deve crescer |
| Textos longos estouram container | `maxLines` + `overflow: TextOverflow.ellipsis` obrigatório |
| `BottomNavigationBar` some em rotas de detalhe | **`ShellRoute`** mantém `ScaffoldWithBottomNav` persistente |
| `context.go()` vs `context.push()` confusão | `go` = substitui stack (navegação principal), `push` = adiciona (detalhes, modais) |
| `TextFormField` validator não dispara no submit | `onFieldSubmitted` no último campo chama handler; `Form` key no widget pai |

### Resumo de Padrões Reforçados
| Situação | Padrão Aplicado |
|----------|-----------------|
| Ações rápidas em grid | `ListView` horizontal + `SizedBox(width: fixo)` |
| Botões de ação em cards/lista | `IconButton` com `tooltip` (sem texto) |
| Chips/tags dinâmicos | `Wrap(spacing, runSpacing)` |
| Badge de status + título longo | Badge **abaixo** do título (coluna) |
| Colunas em `Row` com filhos variados | `width` fixo no filho que não deve crescer |
| Textos que podem ser longos | `maxLines` + `overflow: TextOverflow.ellipsis` |
| Locale `pt_BR` com `intl` | `await initializeDateFormatting('pt_BR', null)` no `main()` |
| Navegação principal com estado | `ShellRoute` + `ScaffoldWithBottomNav` |
| Loading em botão | `CustomButton(isLoading: true)` — mostra `CircularProgressIndicator` |

---

## Histórico de Correções (2026-11-17)

### Riverpod 3.x + freezed 3.x Migration (Upgrade Completo)
**Motivo:** Dependency hell entre Riverpod 2.x, freezed 2.5.x, custom_lint, analyzer — resolvido com upgrade major.
**Arquivos:** `pubspec.yaml`, `pubspec.lock`, `lib/core/providers/*_providers.dart`, `lib/data/models/menu_models.dart`

**Mudanças principais:**
| Pacote | Antes | Agora |
|--------|-------|-------|
| `flutter_riverpod` | `^2.5.1` | `^3.5.0` |
| `riverpod_annotation` | `^2.3.5` | `^4.0.8` |
| `riverpod_generator` | `^2.4.0` | `^4.0.10` |
| `freezed` | `^2.5.0` | `^4.0.3` |
| `freezed_annotation` | `^2.4.1` | `^3.1.0` |
| `build_runner` | `^2.4.8` | `^2.17.1` |
| `intl` | `^0.19.0` | `^0.20.3` |
| `riverpod_lint` | `^2.3.0` | `^3.2.0` |
| `custom_lint` | `^0.6.4` | **removido** |
| `analyzer_plugin` | — | `^0.14.0` |

**Migração Providers (4 arquivos):**
- `StateNotifier<T>` → `Notifier<T>` / `AsyncNotifier<T>`
- `StateNotifierProvider` → `NotifierProvider` / `AsyncNotifierProvider`
- Construtor `super(initialState)` → método `build()` retorna estado inicial
- `state = value` mantido nos métodos (funciona igual)

**Fix Menu:** `menu_providers.dart` — filtro `productsByCategoryProvider` usa `categoryDisplayName` (português) em vez de `categoryName` (inglês) para bater com `AppStrings`.

---

### 1. main.dart — Locale pt_BR
**Problema:** `DateFormat('dd/MM/yyyy HH:mm', 'pt_BR')` lançava `LocaleDataException` porque o locale não foi inicializado.
**Arquivo:** `lib/main.dart`
**Correção:**
```dart
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  await initializeDateFormatting('pt_BR', null); // Obrigatório para pt_BR
  runApp(const MeuAplicativo());
}
```
**Padrão:** Sempre chamar `initializeDateFormatting('pt_BR', null)` antes de `runApp()` quando usar `intl` com locale brasileiro.

---

### 2. HomeScreen — Quick Actions Overflow (BOTTOM OVERFLOWED)
**Problema:** `GridView` com 4 colunas e `childAspectRatio` fixo deixava cards achatados; textos de 2 linhas ("Meus Pedidos", "Promoções") cortavam.
**Arquivo:** `lib/features/home/presentation/screens/home_screen.dart`
**Correção:** Substituído `GridView` por `ListView` horizontal com largura fixa por card:
```dart
// ANTES (problemático)
GridView.builder(
  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 4,
    childAspectRatio: 1.0,
  ),
)

// DEPOIS (corrigido)
SizedBox(
  height: 100,
  child: ListView.separated(
    scrollDirection: Axis.horizontal,
    itemBuilder: (context, index) => SizedBox(
      width: 80,  // Largura fixa = texto não estoura
      child: _QuickActionCard(action: actions[index]),
    ),
  ),
)
```
**Decisão:** `ListView` horizontal > `GridView` para ações rápidas — melhor UX mobile, scroll natural, textos sempre legíveis.

---

### 3. MenuScreen — ProductCard Overflow (Botão + Badge)
**Problema:** Duas situações:
1. Botão "Adicionar ao carrinho" com texto + ícone em coluna estreita → texto quebrava em 3-4 linhas, letras sobrepostas
2. Badge "Indisponível" ao lado do nome "Pizza Quatro Queijos" → overflow horizontal
**Arquivo:** `lib/features/menu/presentation/screens/menu_screen.dart`
**Correções:**
1. **Badge movido para BAIXO do nome** (coluna):
```dart
Text(product.name, maxLines: 1, overflow: TextOverflow.ellipsis),
if (!product.isAvailable) ...[
  SizedBox(height: 4),
  Container(/* badge menor, fonte 9px */),
],
```
2. **Botão substituído por `IconButton` compacto** (apenas ícone):
```dart
SizedBox(width: 70, child: Column(
  children: [
    Text('R$ XX,XX'),
    SizedBox(height: 8),
    IconButton(
      icon: Icon(Icons.add_shopping_cart, size: 28),
      tooltip: 'Adicionar ao carrinho',
      style: IconButton.styleFrom(
        backgroundColor: AppColors.primary.withValues(alpha: 0.1),
      ),
    ),
  ],
))
```
**Decisões:**
- `IconButton` > `CustomButton` em listas — economiza espaço horizontal, sem texto para quebrar
- Badge de status **abaixo** do título (não inline) — nomes longos não competem por largura
- Largura fixa (`width: 70`) na coluna de preço/ação — garante que `Expanded` da coluna de detalhes funcione

---

### 4. OrdersScreen — Chips de Info Overflow (BOTTOM OVERFLOWED 37px)
**Problema:** `Row` com 3 `_InfoChip` fixos (`itens` + `preço` + `Entregue dd/MM/yyyy HH:mm`) não quebrava em telas estreitas.
**Arquivo:** `lib/features/orders/presentation/screens/orders_screen.dart`
**Correção:** `Row` → `Wrap` com quebra automática:
```dart
// ANTES
Row(children: [
  _InfoChip(...),
  SizedBox(width: 12),
  _InfoChip(...),
  if (estimatedDelivery != null) ...[
    SizedBox(width: 12),
    _InfoChip(...),
  ],
])

// DEPOIS
Wrap(spacing: 8, runSpacing: 8, children: [
  _InfoChip(...),
  _InfoChip(...),
  if (estimatedDelivery != null) _InfoChip(...),
])
```
**Decisão:** `Wrap` > `Row` para chips dinâmicos — responsivo automático sem media queries.

---

### 5. OrderDetailScreen — Timeline Animada
**Implementação:** Timeline vertical com `AnimationController` para status atual:
- Círculos: cinza (futuro), cor do status (atual/concluído), checkmark branco (concluído)
- Linha conectora: cor do status se concluído, cinza se futuro
- Badge "AGORA" pulsante no status atual (`AnimatedBuilder` + `repeat(reverse: true)`)
- Timestamps mock calculados a partir de `createdAt` + offsets por status
- Caso cancelado: card vermelho explicativo (sem timeline)

---

### 6. Injeção de Dependência (GetIt)
**Arquivo:** `lib/injection.dart`
- `Dio` com `PrettyDioLogger` + interceptor de auth (adiciona `Bearer token` do `AuthService`)
- `FlutterSecureStorage` singleton (token)
- `SharedPreferences` singleton (user data)
- `AuthService` singleton (login, register, logout, token management)
- Repositories e Use Cases comentados como template para implementação futura

---

### 7. Design System Completo (AppTheme)
**Arquivo:** `lib/core/theme/app_theme.dart`
- Material 3 (`useMaterial3: true`)
- `ColorScheme.fromSeed` com `AppColors.primary` como seed
- Todos os temas de componentes configurados: AppBar, Card, Buttons, Inputs, Chips, NavigationBar, Dialog, BottomSheet, SnackBar, ProgressIndicator, Slider, TabBar, ListTile, Divider, FAB
- `darkTheme` esqueleto preparado para implementação futura

---

## Referências Técnicas

- **Framework**: Flutter 3.13+
- **Linguagem**: Dart 3.0+
- **Arquitetura**: Clean Architecture + Feature-first
- **Estado**: Riverpod 3.5 (AsyncNotifier + Notifier + FutureProvider)
- **Navegação**: go_router 14.2 (ShellRoute + Redirect Guards)
- **Network**: Dio 5.5 + PrettyDioLogger
- **Storage**: flutter_secure_storage 9.0 + shared_preferences 2.2
- **Serialization**: Freezed 4.0 + JSON Serializable 6.8
- **DI**: GetIt 8.0
- **Utils**: intl 0.20 (pt_BR), equatable 2.0, uuid 4.3
- **UI Extras**: cached_network_image 3.3, shimmer 3.0, flutter_staggered_animations 1.1
- **Code Gen**: build_runner 2.17, riverpod_generator 4.0, riverpod_lint 3.2, analyzer_plugin 0.14

---

## Histórico de Correções Recentes (2026-11-27)

### 1. Retry Automático com Backoff Exponencial (Timeout da API Render)
**Problema:** API no Render Free Tier "dorme" após inatividade (cold start 30-60s), causando `DioExceptionType.receiveTimeout` no login e outras chamadas.

**Solução:** Adicionado `RetryInterceptor` em `lib/injection.dart`:
- **Máx. 3 tentativas** com backoff exponencial: 3s → 6s → 12s (capped em 30s)
- **Tipos de erro que dão retry:** timeout (connect/receive/send), connection error, 5xx server errors
- **Usa a mesma instância Dio** → mantém interceptors de auth, logging, etc.
- **Log de tentativas** no console para debug

**Arquivos:** `lib/injection.dart` (novas classes `RetryOptions`, `RetryInterceptor`)

---

### 2. Correção de Layout — OrderDetailScreen (Unbounded Height)
**Problema:** `RenderFlex children have non-zero flex but incoming height constraints are unbounded` ao acessar detalhes do pedido.

**Causa:** No `_TimelineStep`, o `Row` continha uma `Column` com `Expanded` (linha do timeline), mas o `Row` não passava restrição de altura finita.

**Solução:** Envolveu o `Row` com `IntrinsicHeight` no `_TimelineStep.build()`:
```dart
return IntrinsicHeight(child: Row(...));
```

**Arquivo:** `lib/features/orders/presentation/screens/order_detail_screen.dart`

---

### 3. Strings Hardcoded — OrderDetailScreen
**Problema:** Referências `AppStrings` aparecendo literalmente na UI (ex: "AppStrings.cancelOrder").

**Solução:** Substituídas 15 referências `AppStrings` pelos textos reais em português:
- `AppStrings.orderNumber` → `'Pedido #'`
- `AppStrings.trackOrder` → `'Acompanhar pedido'`
- `AppStrings.orderDate` → `'Data do pedido'`
- `AppStrings.estimatedDelivery` → `'Previsão de entrega'`
- `AppStrings.deliveryAddressLabel` → `'Endereço de entrega'`
- `AppStrings.paymentMethodLabel` → `'Forma de pagamento'`
- `AppStrings.items` → `'Itens'`
- `AppStrings.subtotal` → `'Subtotal'`
- `AppStrings.deliveryFee` → `'Taxa de entrega'`
- `AppStrings.total` → `'Total'`
- `AppStrings.reorder` → `'Pedir novamente'`
- `AppStrings.cancelOrder` → `'Cancelar pedido'`
- `AppStrings.confirmCancel` → `'Tem certeza que deseja cancelar?'`
- `AppStrings.cancel` → `'Cancelar'`
- `AppStrings.confirm` → `'Confirmar'`

**Arquivo:** `lib/features/orders/presentation/screens/order_detail_screen.dart` (removido import `app_strings.dart`)

---

### 4. Skeleton Loading — OrderDetailScreen (Já Existia)
**Nota:** O skeleton loading já estava implementado no método `_buildOrderDetailSkeleton()` e usado no estado `loading` do `orderAsync.when()`. Cobre todas as seções: Timeline (7 passos), Info do Pedido, Itens, Pagamento/Endereço, Ações.

---

### 5. Botão "Último Acesso" — LoginScreen
**Implementação:** Botão de login automático usando credenciais salvas.
- **Verifica credenciais salvas** no `initState` via `AuthService.getLastLogin()`
- **Mostra `OutlinedButton`** com ícone de histórico e email do último acesso quando disponível
- **Ao clicar:** Preenche automaticamente email/senha e chama `AuthNotifier.login()`
- **Credenciais salvas** no `flutter_secure_storage` após login/registro bem-sucedido
- **Método `AuthService.saveLoginData()`** aceita `password` opcional para salvar último acesso

**Arquivos alterados:**
- `lib/core/services/auth_service.dart` — `_lastLoginEmailKey`, `_lastLoginPasswordKey`, `saveLastLogin()`, `getLastLogin()`, `clearLastLogin()`, `saveLoginData()` com password opcional
- `lib/core/providers/auth_providers.dart` — `login()` e `register()` passam `password` para `AuthService.saveLoginData()`
- `lib/features/auth/presentation/screens/login_screen.dart` — `_loadLastLogin()`, `_handleLastLogin()`, UI do botão "Último acesso"

---

## Referências Técnicas

- **Framework**: Flutter 3.13+
- **Linguagem**: Dart 3.0+
- **Arquitetura**: Clean Architecture + Feature-first
- **Estado**: Riverpod 3.5 (AsyncNotifier + Notifier + FutureProvider)
- **Navegação**: go_router 14.2 (ShellRoute + Redirect Guards)
- **Network**: Dio 5.5 + PrettyDioLogger
- **Storage**: flutter_secure_storage 9.0 + shared_preferences 2.2
- **Serialization**: Freezed 4.0 + JSON Serializable 6.8
- **DI**: GetIt 8.0
- **Utils**: intl 0.20 (pt_BR), equatable 2.0, uuid 4.3
- **UI Extras**: cached_network_image 3.3, shimmer 3.0, flutter_staggered_animations 1.1
- **Code Gen**: build_runner 2.17, riverpod_generator 4.0, riverpod_lint 3.2, analyzer_plugin 0.14

---

## Estrutura de Arquivos de Índice (Barrel Exports)
Cada pasta `core/`, `features/*/presentation/`, `shared/` possui `index.dart` exportando o conteúdo público:
```dart
// core/constants/index.dart
export 'app_colors.dart';
export 'app_strings.dart';
export 'app_routes.dart';

// core/theme/index.dart
export 'app_theme.dart';

// core/router/index.dart
export 'app_router.dart';

// core/services/index.dart
export 'auth_service.dart';

// shared/widgets/index.dart
export 'custom_button.dart';
export 'custom_text_field.dart';
export 'custom_search_field.dart';

// shared/models/index.dart
export 'order_models.dart';
```

---

*Última atualização: 2026-11-27*
*Este documento deve ser mantido atualizado a cada mudança significativa no projeto.*