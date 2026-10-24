# Pizzaria Delivery App - Documentação do Projeto

## Visão Geral
Sistema de delivery para pizzaria onde clientes fazem pedidos pelo app e acompanham o status em tempo real, evitando filas de espera.

## Arquitetura do Projeto

### Estrutura de Pastas (lib/)
```
lib/
├── main.dart                 # Ponto de entrada do app
├── core/
│   ├── constants/           # Constantes globais (cores, textos, rotas)
│   ├── theme/               # Tema da aplicação
│   ├── router/              # Configuração de rotas (go_router)
│   └── services/            # Serviços (auth, api, storage)
├── features/
│   ├── auth/                # Feature de autenticação
│   │   ├── data/            # Repositories, datasources
│   │   ├── domain/          # Entities, usecases
│   │   └── presentation/    # Screens, widgets, controllers
│   ├── home/                # Feature home/dashboard
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   ├── menu/                # Cardápio de pizzas
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   ├── cart/                # Carrinho de compras
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   ├── orders/              # Pedidos e rastreamento
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   └── profile/             # Perfil do usuário
│       ├── data/
│       ├── domain/
│       └── presentation/
├── shared/
│   ├── widgets/             # Widgets reutilizáveis
│   ├── models/              # Models compartilhados
│   └── utils/               # Helpers, extensions
└── injection.dart           # Dependency injection (get_it)
```

### Padrões de Arquitetura
- **Clean Architecture** com separação em camadas (data, domain, presentation)
- **Feature-first** organization
- **Riverpod** para gerenciamento de estado
- **go_router** para navegação
- **Repository Pattern** para abstração de dados
- **Use Cases** para lógica de negócio

---

## Funcionalidades Principais

### 1. Autenticação (Auth)
- **Login**: Email + Senha
- **Registro**: Nome, Email, Senha, Telefone, Endereço
- **Logout**
- **Persistência de sessão** (SharedPreferences / SecureStorage)
- **Recuperação de senha** (futuro)

### 2. Home / Dashboard
- Boas-vindas personalizada
- Acesso rápido: Cardápio, Meus Pedidos, Perfil
- Promoções em destaque
- Status do último pedido (se houver)

### 3. Cardápio (Menu)
- Listagem de categorias (Pizzas, Bebidas, Sobremesas, etc.)
- Cards de produtos com: imagem, nome, descrição, preço, tempo de preparo
- Filtros por categoria
- Busca por nome
- Personalização de pizza (borda, ingredientes extras, tamanho)

### 4. Carrinho (Cart)
- Adicionar/remover itens
- Alterar quantidade
- Observações por item
- Resumo: subtotal, taxa de entrega, total
- Endereço de entrega (seleção ou novo)
- Forma de pagamento
- Botão "Finalizar Pedido"

### 5. Pedidos (Orders)
- **Lista de pedidos** com status:
  - `PENDING` - Aguardando confirmação
  - `CONFIRMED` - Confirmado pela pizzaria
  - `PREPARING` - Em preparação
  - `BAKING` - No forno
  - `READY` - Pronto para retirada/entrega
  - `OUT_FOR_DELIVERY` - Saiu para entrega
  - `DELIVERED` - Entregue
  - `CANCELLED` - Cancelado
- **Detalhes do pedido**: itens, valores, endereço, forma de pagamento, timeline de status
- **Rastreamento em tempo real** (polling ou WebSocket)
- Notificações de mudança de status
- Histórico de pedidos

### 6. Perfil (Profile)
- Dados pessoais (editar)
- Endereços salvos (CRUD)
- Formas de pagamento salvas
- Histórico de pedidos
- Configurações (notificações, tema)
- Sair da conta

---

## Modelos de Dados

### User
```dart
class User {
  final String id;
  final String name;
  final String email;
  final String phone;
  final List<Address> addresses;
  final DateTime createdAt;
}
```

### Address
```dart
class Address {
  final String id;
  final String label; // "Casa", "Trabalho"
  final String street;
  final String number;
  final String complement;
  final String neighborhood;
  final String city;
  final String state;
  final String zipCode;
  final double latitude;
  final double longitude;
  final bool isDefault;
}
```

### Product (Pizza/Item)
```dart
class Product {
  final String id;
  final String name;
  final String description;
  final String imageUrl;
  final double price;
  final Category category;
  final int prepTimeMinutes;
  final List<CustomizationOption> customizations;
  final bool isAvailable;
}
```

### Category
```dart
enum Category { pizza, drink, dessert, side }
```

### CustomizationOption
```dart
class CustomizationOption {
  final String id;
  final String name; // "Borda", "Tamanho", "Ingredientes extras"
  final List<CustomizationChoice> choices;
  final bool isRequired;
  final bool allowMultiple;
}
```

### CustomizationChoice
```dart
class CustomizationChoice {
  final String id;
  final String name;
  final double additionalPrice;
}
```

### CartItem
```dart
class CartItem {
  final String id;
  final Product product;
  final int quantity;
  final Map<String, String> selectedCustomizations; // optionId -> choiceId
  final String notes;
  final double totalPrice;
}
```

### Order
```dart
class Order {
  final String id;
  final String userId;
  final List<OrderItem> items;
  final Address deliveryAddress;
  final PaymentMethod paymentMethod;
  final OrderStatus status;
  final double subtotal;
  final double deliveryFee;
  final double total;
  final String notes;
  final DateTime createdAt;
  final DateTime? estimatedDeliveryTime;
  final List<StatusTimeline> timeline;
}
```

### OrderItem
```dart
class OrderItem {
  final String id;
  final Product product;
  final int quantity;
  final Map<String, String> customizations;
  final String notes;
  final double unitPrice;
  final double totalPrice;
}
```

### OrderStatus (enum)
```dart
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
```

### StatusTimeline
```dart
class StatusTimeline {
  final OrderStatus status;
  final DateTime timestamp;
  final String? note;
}
```

### PaymentMethod
```dart
enum PaymentMethod { cash, card, pix, wallet }
```

---

## Fluxo de Navegação

### Rotas Públicas (sem auth)
- `/login` - Tela de login
- `/register` - Tela de registro
- `/forgot-password` - Recuperação de senha

### Rotas Protegidas (requer auth)
- `/home` - Dashboard principal
- `/menu` - Cardápio
- `/menu/:category` - Cardápio filtrado por categoria
- `/product/:id` - Detalhes do produto
- `/cart` - Carrinho
- `/checkout` - Finalização do pedido
- `/orders` - Lista de pedidos
- `/orders/:id` - Detalhes do pedido + rastreamento
- `/profile` - Perfil do usuário
- `/profile/addresses` - Gerenciar endereços
- `/profile/addresses/new` - Novo endereço
- `/profile/addresses/:id/edit` - Editar endereço
- `/settings` - Configurações

---

## Gerenciamento de Estado (Riverpod)

### Providers Principais
- `authProvider` - Estado de autenticação (User?, isLoading, error)
- `cartProvider` - Estado do carrinho (List<CartItem>, subtotal, deliveryFee)
- `menuProvider` - Produtos por categoria
- `ordersProvider` - Lista de pedidos do usuário
- `orderTrackingProvider` - Stream de status do pedido ativo
- `addressesProvider` - Endereços salvos
- `themeProvider` - Tema claro/escuro

---

## Dependências Principais (pubspec.yaml)

```yaml
dependencies:
  flutter:
    sdk: flutter
  # State Management
  flutter_riverpod: ^2.5.0
  riverpod_annotation: ^2.3.0
  
  # Navigation
  go_router: ^14.0.0
  
  # Network
  dio: ^5.5.0
  pretty_dio_logger: ^1.3.0
  
  # Storage
  shared_preferences: ^2.2.0
  flutter_secure_storage: ^9.0.0
  
  # JSON Serialization
  json_annotation: ^4.9.0
  freezed_annotation: ^2.4.0
  
  # UI
  cached_network_image: ^3.3.0
  shimmer: ^3.0.0
  flutter_staggered_animations: ^1.1.0
  
  # Utils
  intl: ^0.19.0
  equatable: ^2.0.5
  uuid: ^4.3.0

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^6.0.0
  riverpod_generator: ^2.4.0
  build_runner: ^2.4.0
  json_serializable: ^6.8.0
  freezed: ^2.5.0
  custom_lint: ^0.6.0
  riverpod_lint: ^2.3.0
```

---

## Convenções de Código

### Naming
- **Arquivos**: snake_case (`login_screen.dart`, `order_repository.dart`)
- **Classes**: PascalCase (`LoginScreen`, `OrderRepository`)
- **Variáveis/Functions**: camelCase (`userName`, `fetchOrders()`)
- **Constantes**: SCREAMING_SNAKE_CASE (`API_BASE_URL`, `DEFAULT_DELIVERY_FEE`)
- **Providers**: camelCase com sufixo `Provider` (`authProvider`, `cartProvider`)

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
- `main` - Produção
- `develop` - Desenvolvimento
- `feature/*` - Novas features
- `fix/*` - Correções
- `release/*` - Preparação de release

---

## Checklist para Novos Desenvolvedores/Agentes

Ao trabalhar neste projeto, **SEMPRE**:

1. **Leia este arquivo** antes de começar qualquer tarefa
2. **Siga a estrutura de pastas** definida acima
3. **Use Riverpod** para todo gerenciamento de estado
4. **Use go_router** para navegação
5. **Crie Use Cases** para lógica de negócio (não coloque lógica nos widgets)
6. **Use Repository Pattern** para acesso a dados
7. **Escreva testes** para Use Cases e Repositories
8. **Atualize este arquivo** quando:
   - Adicionar nova feature
   - Mudar arquitetura
   - Adicionar dependência importante
   - Mudar convenções
9. **Mantenha consistência visual** com o Design System definido
10. **Trate erros** adequadamente (try/catch, error states na UI)

---

## Design System (Básico)

### Cores Principais
```dart
// Tema Padrão (Laranja Pizzaria)
primaryColor: Color(0xFFFF6B35)      // Laranja principal
primaryVariant: Color(0xFFE85D2E)
secondaryColor: Color(0xFF2D2D2D)    // Cinza escuro
backgroundColor: Color(0xFFFFFFFF)
surfaceColor: Color(0xFFF5F5F5)
errorColor: Color(0xFFDC3545)
successColor: Color(0xFF28A745)
warningColor: Color(0xFFFFC107)
textPrimary: Color(0xFF1A1A1A)
textSecondary: Color(0xFF666666)
```

### Tipografia
- **Headline**: Poppins / Roboto, Bold
- **Body**: Roboto, Regular
- **Button**: Roboto, Medium
- **Caption**: Roboto, Regular, 12sp

### Espaçamento
- Base: 8px
- xs: 4px, sm: 8px, md: 16px, lg: 24px, xl: 32px, xxl: 48px

### Border Radius
- sm: 4px, md: 8px, lg: 12px, xl: 16px, full: 999px

---

## Próximos Passos (Roadmap)

### Fase 1 - MVP (Atual)
- [ ] Configurar dependências (Riverpod, go_router, Dio, etc.)
- [ ] Implementar Auth (Login/Register/Logout)
- [ ] Implementar Home básica
- [ ] Implementar Menu/Listagem de produtos
- [ ] Implementar Carrinho
- [ ] Implementar Checkout
- [ ] Implementar Lista de Pedidos + Detalhes
- [ ] Implementar Perfil básico

### Fase 2 - Melhorias
- [ ] Rastreamento em tempo real (WebSocket)
- [ ] Notificações push (Firebase)
- [ ] Pagamento online (Stripe/MercadoPago)
- [ ] Avaliação de pedidos
- [ ] Programa de fidelidade
- [ ] Cupons de desconto

### Fase 3 - Admin (Futuro)
- [ ] Painel administrativo web
- [ ] Gestão de pedidos (cozinha)
- [ ] Gestão de cardápio
- [ ] Relatórios de vendas
- [ ] Gestão de entregadores

---

## Comandos Úteis

```bash
# Instalar dependências
flutter pub get

# Gerar código (freezed, json_serializable, riverpod)
dart run build_runner build --delete-conflicting-outputs

# Watch mode para geração contínua
dart run build_runner watch

# Rodar app
flutter run

# Build release
flutter build apk --release
flutter build ios --release

# Analisar código
flutter analyze

# Rodar testes
flutter test

# Ver dependências desatualizadas
flutter pub outdated
```

---

## Contatos / Referências

- **Projeto**: Pizzaria Delivery App
- **Framework**: Flutter 3.13+
- **Linguagem**: Dart 3.0+
- **Arquitetura**: Clean Architecture + Feature-first
- **Estado**: Riverpod
- **Navegação**: go_router

---

## Histórico de Correções de Bugs (2024-10-24)

### 1. LocaleDataException — Tela Vermelha nos Pedidos
**Problema:** `DateFormat('dd/MM/yyyy HH:mm', 'pt_BR')` lançava `LocaleDataException` porque o locale `pt_BR` não foi inicializado antes do `runApp()`.

**Arquivos:** `lib/main.dart`, `lib/features/orders/presentation/screens/orders_screen.dart`, `lib/features/orders/presentation/screens/order_detail_screen.dart`

**Correção:** Inicialização do locale no `main.dart`:
```dart
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  await initializeDateFormatting('pt_BR', null); // Necessário para DateFormat com 'pt_BR'
  runApp(const MeuAplicativo());
}
```

**Padrão estabelecido:** Sempre chamar `initializeDateFormatting('pt_BR', null)` antes de `runApp()` quando usar `intl` com locale brasileiro.

---

### 2. RenderFlex Overflows — Três Telas Afetadas

#### A) Home / Início — Quick Actions (BOTTOM OVERFLOWED 5.3px)
**Problema:** `GridView` com 4 colunas e `childAspectRatio: 0.85` deixava cards muito achatados; textos de 2 linhas ("Meus Pedidos", "Promoções") cortavam.

**Arquivo:** `lib/features/home/presentation/screens/home_screen.dart`

**Correção:** Substituído `GridView` por `ListView` horizontal com largura fixa por card:
```dart
// ANTES
GridView.builder(
  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 4,
    childAspectRatio: 1.0,
  ),
)

// DEPOIS
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

#### B) Cardápio / Menu — Botão "Adicionar ao carrinho" (BOTTOM OVERFLOWED 113px)
**Problema:** `CustomButton` com texto "Adicionar ao carrinho" + ícone em coluna de 110-130px → texto quebrava em 3-4 linhas, letras apareciam sobrepostas ao botão. Nome "Pizza Quatro Queijos" + badge "Indisponível" lado a lado também causava overflow horizontal.

**Arquivo:** `lib/features/menu/presentation/screens/menu_screen.dart`

**Correções:**
1. **Badge "Indisponível" movido para BAIXO do nome** (não mais ao lado):
```dart
Text(product.name, maxLines: 1, overflow: TextOverflow.ellipsis),
if (!product.isAvailable) ...[
  SizedBox(height: 4),
  Container(/* badge menor, fonte 9px */),
],
```

2. **Botão substituído por `IconButton` compacto** (apenas ícone de carrinho):
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

#### C) Pedidos / Orders — Chips de Info (Faixa Preta/Amarela - BOTTOM OVERFLOWED 37px)
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

### 3. Limpeza de Código
- Removido import não usado `package:pizza/shared/widgets/custom_button.dart` do `menu_screen.dart`
- Adicionado `maxLines: 1` + `overflow: TextOverflow.ellipsis` no nome do produto no cardápio

---

### Resumo de Padrões Reforçados
| Situação | Padrão Aplicado |
|----------|-----------------|
| Ações rápidas em grid | `ListView` horizontal + `SizedBox(width: fixo)` |
| Botões de ação em cards/lista | `IconButton` com `tooltip` (sem texto) |
| Chips/tags dinâmicos | `Wrap(spacing, runSpacing)` |
| Badge de status + título longo | Badge **abaixo** do título (coluna), não ao lado (linha) |
| Colunas em `Row` com filhos variados | `width` fixo no filho que não deve crescer |
| Textos que podem ser longos | `maxLines` + `overflow: TextOverflow.ellipsis` |
| Locale `pt_BR` com `intl` | `await initializeDateFormatting('pt_BR', null)` no `main()` |

---

*Última atualização: 2024-10-24*
*Este documento deve ser mantido atualizado a cada mudança significativa no projeto.*