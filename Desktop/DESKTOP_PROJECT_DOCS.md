# Pizzaria Delivery App - Documentação do Projeto (Desktop C# WPF)

## Visão Geral
Sistema de delivery para pizzaria - versão desktop Windows (WPF). Clientes fazem pedidos pelo app e acompanham o status em tempo real. **Agora com persistência real via Entity Framework Core** (SQLite local / PostgreSQL produção), autenticação JWT, e fluxo completo de registro/login.

## Arquitetura do Projeto

### Estrutura de Pastas
```
PizzariaDesktop/
├── App.xaml                  # Recursos globais, estilos, converters, DataTemplates
├── App.xaml.cs               # Startup, DI config, DB init, migrações
├── MainWindow.xaml           # Janela principal com sidebar + ContentControl
├── MainWindow.xaml.cs        # Code-behind mínimo
├── AssemblyInfo.cs           # Atributos de assembly
├── PizzariaDesktop.csproj    # Projeto .NET 11 (preview)
│
├── Converters/
│   └── Converters.cs         # 11 ValueConverters + 3 IMultiValueConverters
│
├── Data/
│   ├── MockData.cs           # Factory de dados estáticos (fallback/demo)
│   ├── Entities/
│   │   └── DatabaseEntities.cs   # Entidades EF Core (tabelas DB)
│   ├── Migrations/           # Migrações EF Core (3 migrações)
│   ├── PizzariaDbContext.cs  # DbContext com configuração SQLite/PostgreSQL
│   ├── Repositories/
│   │   ├── IRepositories.cs  # Interfaces dos repositórios
│   │   └── Repositories.cs   # Implementações EF Core
│
├── Models/
│   ├── Enums.cs              # Category, OrderStatus, PaymentMethod
│   ├── UserModels.cs         # User, Address (com CreatedAt, PasswordHash)
│   ├── ProductModels.cs      # Product, CustomizationOption, CustomizationChoice
│   └── OrderModels.cs        # CartItem, OrderItem, Order, StatusTimeline (INotifyPropertyChanged)
│
├── Services/
│   ├── AuthService.cs        # Login, Register, JWT tokens, BCrypt
│   └── ServiceCollectionExtensions.cs  # DI config, DbContext, repos, ServiceLocator
│
├── ViewModels/
│   ├── BaseViewModel.cs      # INotifyPropertyChanged base
│   ├── RelayCommand.cs       # ICommand implementation
│   ├── MainViewModel.cs      # Navegação, estado global, cart, login/register flow
│   ├── LoginViewModel.cs     # Login com AuthService + fallback demo
│   ├── RegisterViewModel.cs  # Registro com validação campo a campo + AuthService
│   ├── HomeViewModel.cs      # Promoções, quick actions
│   ├── MenuViewModel.cs      # Produtos por categoria, filtros
│   ├── CartViewModel.cs      # Carrinho, checkout, OrderConfirmationDialog
│   ├── OrdersViewModel.cs    # Lista de pedidos, detalhe sidebar
│   └── ProfileViewModel.cs   # Perfil, endereços, stats, logout
│
├── Views/
│   ├── Auth/
│   │   ├── LoginView.xaml          # Full-screen split 50/50 + link "Cadastre-se"
│   │   ├── LoginView.xaml.cs       # Show/hide password + Exit button
│   │   ├── RegisterView.xaml       # Full-screen split 50/50 + validação inline
│   │   └── RegisterView.xaml.cs    # Phone mask, show/hide password (2x)
│   ├── Home/
│   │   └── HomeView.xaml           # Dashboard com promoções, quick actions
│   ├── Menu/
│   │   └── MenuView.xaml           # Categorias tabs + grid de produtos
│   ├── Cart/
│   │   ├── CartView.xaml           # Itens, endereço, pagamento, total
│   │   ├── CartView.xaml.cs
│   │   ├── OrderConfirmationDialog.xaml    # Modal animado sucesso do pedido
│   │   └── OrderConfirmationDialog.xaml.cs # ViewModel interno + navegação
│   ├── Orders/
│   │   └── OrdersView.xaml         # Lista + sidebar detalhe + timeline
│   └── Profile/
│       └── ProfileView.xaml        # Dados, endereços, configurações, logout
│
├── bin/                      # Build output (gitignored)
├── obj/                      # Build intermediates (gitignored)
└── Resources/                # Imagens, ícones (futuro)
```

### Padrões de Arquitetura
- **MVVM** (Model-View-ViewModel) com separação clara
- **DataBinding** nativo WPF (INotifyPropertyChanged)
- **DataTemplates** em App.xaml para ViewModel→View mapping automático
- **RelayCommand** para ICommand sem bibliotecas externas
- **Static Mock Data** - MockData.cs como fallback quando sem DI
- **Converters** para transformações UI (14 converters total)
- **Event-based Navigation** - MainViewModel subscreve eventos dos ViewModels filhos
- **Dependency Injection** - Microsoft.Extensions.DI com ServiceLocator opcional
- **Repository Pattern** - Abstração de dados via interfaces
- **Entity Framework Core** - SQLite (dev) / PostgreSQL (prod) com migrações

---

## Funcionalidades Principais

### 1. Autenticação (Auth) - **NOVO: Registro + JWT**
- **Login**: Email + Senha (validação real via BCrypt + JWT)
- **Registro**: Nome, Email, Telefone, Senha, Confirmar Senha
  - Validação campo a campo (inline errors)
  - Máscara de telefone `(XX) XXXXX-XXXX`
  - Show/hide password (olho 👁/🙈) em Senha e Confirmar Senha
  - Password mínimo 6 caracteres
  - Verifica email único no banco
- **JWT Tokens**: HS256, expiração configurável (padrão 24h)
- **BCrypt**: Work factor 12 para hash de senha
- **Fallback Demo**: Funciona sem banco (qualquer credencial) se DI não disponível
- **Layout**: Full-screen split 50/50 - esquerda brand (laranja #FF6B35), direita formulário centralizado
- **Link "Cadastre-se" / "Entrar"** entre Login ↔ Register
- **Botão "Sair do Sistema"** no Login (fecha app)

### 2. Home / Dashboard
- Boas-vindas personalizada com nome do usuário
- Quick Actions: Cardápio, Meus Pedidos, Perfil (cards clicáveis)
- Promoções em destaque (mock)
- Status do último pedido (se houver)
- Navegação via sidebar ou cards

### 3. Cardápio (Menu)
- Abas de categoria: Pizzas, Bebidas, Sobremesas, Acompanhamentos
- Grid de produtos com: imagem (emoji), nome, descrição, preço, tempo preparo
- Filtro por categoria via tabs
- Cards mostram badge de categoria colorido
- Botão "Adicionar" navega para carrinho

### 4. Carrinho (Cart)
- Lista de itens com: produto, quantidade (+/-), preço unitário, total
- Editar quantidade inline
- Remover item
- Seleção de endereço (ComboBox com endereços salvos)
- Forma de pagamento (ComboBox: PIX, Cartão Crédito/Débito, Dinheiro, Carteira Digital)
- Observações do pedido
- Resumo: subtotal, taxa entrega (R$ 5,00), total
- **Botão "Finalizar Pedido"** → processa pagamento simulado → **OrderConfirmationDialog** → navega para Pedidos

### 5. Pedidos (Orders)
- Lista de pedidos com status colorido:
  - `Pending` - Aguardando (amarelo)
  - `Confirmed` - Confirmado (azul)
  - `Preparing` - Preparando (azul)
  - `Baking` - Assando (laranja)
  - `Ready` - Pronto (verde)
  - `OutForDelivery` - Saiu para entrega (roxo)
  - `Delivered` - Entregue (verde)
  - `Cancelled` - Cancelado (vermelho)
- **Sidebar de detalhe** ao clicar no pedido: itens, valores, endereço, pagamento, timeline de status
- Timeline visual com ícones e timestamps

### 6. Perfil (Profile)
- Dados pessoais (nome, email, telefone) - somente leitura
- Endereços salvos (lista com 2 mocks)
- Formas de pagamento salvas
- Stats: Total pedidos, Entregues, Total gasto
- Botões: Editar Perfil, Gerenciar Endereços, Pagamentos, Configurações, Sair
- **Logout** volta para Login

---

## Modelos de Dados (C#)

### Enums
```csharp
public enum Category { Pizza, Drink, Dessert, Side }
public enum OrderStatus { Pending, Confirmed, Preparing, Baking, Ready, OutForDelivery, Delivered, Cancelled }
public enum PaymentMethod { Cash, Card, Pix, Wallet }
```

### User / Address
```csharp
public class User {
    public string Id { get; set; }
    public string Name { get; set; }
    public string Email { get; set; }
    public string Phone { get; set; }
    public string PasswordHash { get; set; }  // NOVO: BCrypt hash
    public List<Address> Addresses { get; set; }
    public DateTime CreatedAt { get; set; }   // NOVO: timestamp criação
}

public class Address {
    public string Id { get; set; }
    public string Label { get; set; }
    public string Street { get; set; }
    public string Number { get; set; }
    public string Complement { get; set; }
    public string Neighborhood { get; set; }
    public string City { get; set; }
    public string State { get; set; }
    public string ZipCode { get; set; }
    public bool IsDefault { get; set; }
    
    // Helpers
    public string FullAddress => $"{Street}, {Number} {Complement} - {Neighborhood}, {City}/{State}";
    public static Address FromFullAddress(string full) { ... }
}
```

### Product / Customization
```csharp
public class Product : INotifyPropertyChanged {
    public string Id { get; set; }
    public string Name { get; set; }
    public string Description { get; set; }
    public string ImageUrl { get; set; }  // Emoji no demo
    public decimal Price { get; set; }
    public Category Category { get; set; }
    public int PrepTimeMinutes { get; set; }
    public List<CustomizationOption> Customizations { get; set; }
    public bool IsAvailable { get; set; }
}

public class CustomizationOption {
    public string Id { get; set; }
    public string Name { get; set; }
    public List<CustomizationChoice> Choices { get; set; }
    public bool IsRequired { get; set; }
    public bool AllowMultiple { get; set; }
}

public class CustomizationChoice {
    public string Id { get; set; }
    public string Name { get; set; }
    public decimal AdditionalPrice { get; set; }
}
```

### CartItem / OrderItem / Order
```csharp
public class CartItem : INotifyPropertyChanged {
    public string Id { get; set; }
    public Product Product { get; set; }
    public int Quantity { get; set; }
    public Dictionary<string, string> SelectedCustomizations { get; set; }
    public string Notes { get; set; }
    public decimal TotalPrice => Product.Price * Quantity;
}

public class OrderItem : INotifyPropertyChanged {
    public string Id { get; set; }
    public Product Product { get; set; }
    public int Quantity { get; set; }
    public Dictionary<string, string> Customizations { get; set; }
    public string Notes { get; set; }
    public decimal UnitPrice { get; set; }
    public decimal TotalPrice => UnitPrice * Quantity;
}

public class Order : INotifyPropertyChanged {
    public string Id { get; set; }
    public string UserId { get; set; }
    public List<OrderItem> Items { get; set; }
    public Address DeliveryAddress { get; set; }
    public PaymentMethod PaymentMethod { get; set; }
    public OrderStatus Status { get; set; }
    public decimal Subtotal { get; set; }
    public decimal DeliveryFee { get; set; }
    public decimal Total => Subtotal + DeliveryFee;
    public string Notes { get; set; }
    public DateTime CreatedAt { get; set; }
    public DateTime? EstimatedDeliveryTime { get; set; }
    public List<StatusTimeline> Timeline { get; set; }
    
    // Helpers
    public string ShortId => Id.Length > 12 ? Id[..12] : Id;
    public string FormattedCreatedAt => CreatedAt.ToString("dd/MM/yyyy HH:mm");
    public string FormattedSubtotal => $"R$ {Subtotal:F2}";
    public string FormattedDeliveryFee => $"R$ {DeliveryFee:F2}";
    public string FormattedTotal => $"R$ {Total:F2}";
}

public class StatusTimeline : INotifyPropertyChanged {
    public OrderStatus Status { get; set; }
    public DateTime Timestamp { get; set; }
    public string Note { get; set; }
}
```

---

## Navegação (MVVM Pattern)

### MainViewModel - Navegação Central
```csharp
public BaseViewModel CurrentView { get; set; }
public bool IsLoggedIn { get; set; }
public User CurrentUser { get; set; }
public ObservableCollection<CartItem> CartItems { get; }
public ObservableCollection<Order> UserOrders { get; }
public int CartItemCount => CartItems.Sum(c => c.Quantity);
public double CartSubtotal => CartItems.Sum(c => c.TotalPrice);

// Comandos de navegação
NavigateToHomeCommand    → HomeViewModel
NavigateToMenuCommand    → MenuViewModel
NavigateToCartCommand    → CartViewModel
NavigateToOrdersCommand  → OrdersViewModel
NavigateToProfileCommand → ProfileViewModel
LogoutCommand            → LoginViewModel
NavigateToRegister()     → RegisterViewModel  // NOVO
```

### Login Flow
1. `MainViewModel` cria `LoginViewModel` (via `ServiceLocator` se DI disponível) e subscreve `OnLoginSuccess` + `OnGoToRegister`
2. `LoginViewModel.LoginAsync()` valida via `AuthService` (ou fallback demo) e dispara `OnLoginSuccess(user)`
3. `MainViewModel.Login(user)` define `CurrentUser`, `IsLoggedIn=true`, navega para `HomeViewModel`

### Register Flow (NOVO)
1. LoginView tem botão "Cadastre-se" → `MainViewModel.NavigateToRegister()`
2. Cria `RegisterViewModel` (com `AuthService` se DI) e subscreve `OnRegisterSuccess` + `OnGoToLogin`
3. `RegisterViewModel.RegisterAsync()` valida campos, chama `AuthService.RegisterAsync()`, dispara `OnRegisterSuccess(user)`
4. `MainViewModel.Login(user)` → mesmo fluxo do login

### DataTemplates (App.xaml)
```xml
<DataTemplate DataType="{x:Type vm:LoginViewModel}"><viewsAuth:LoginView /></DataTemplate>
<DataTemplate DataType="{x:Type vm:RegisterViewModel}"><viewsAuth:RegisterView /></DataTemplate>  <!-- NOVO -->
<DataTemplate DataType="{x:Type vm:HomeViewModel}"><viewsHome:HomeView /></DataTemplate>
<DataTemplate DataType="{x:Type vm:MenuViewModel}"><viewsMenu:MenuView /></DataTemplate>
<DataTemplate DataType="{x:Type vm:CartViewModel}"><viewsCart:CartView /></DataTemplate>
<DataTemplate DataType="{x:Type vm:OrdersViewModel}"><viewsOrders:OrdersView /></DataTemplate>
<DataTemplate DataType="{x:Type vm:ProfileViewModel}"><viewsProfile:ProfileView /></DataTemplate>
```
- Views **NÃO** definem `DataContext` no XAML - o ContentControl injeta automaticamente

---

## Serviços (Services)

### AuthService (IAuthService) - NOVO
```csharp
public interface IAuthService {
    Task<AuthResult> LoginAsync(string email, string password);
    Task<AuthResult> RegisterAsync(string name, string email, string password, string phone);
    Task<User?> GetCurrentUserAsync();
    Task<bool> LogoutAsync();
    string GenerateJwtToken(User user);
    ClaimsPrincipal? ValidateToken(string token);
    bool IsTokenExpired(string token);
}

public class AuthResult {
    public bool Success { get; set; }
    public string ErrorMessage { get; set; }
    public User? User { get; set; }
    public string? Token { get; set; }
}
```
- **BCrypt.Net** para hash de senha (work factor 12)
- **JWT** com `System.IdentityModel.Tokens.Jwt` (HS256)
- Claims: `sub`, `email`, `name`, `jti`, `nameidentifier`
- Configuração via `appsettings.json` / `.env` / Environment Variables
- Fallback demo mode se `_authService == null`

### ServiceCollectionExtensions - NOVO
```csharp
public static class ServiceCollectionExtensions {
    public static IServiceCollection AddPizzariaServices(this IServiceCollection services, IConfiguration? configuration = null)
}
```
Configura:
- `IConfiguration` (appsettings.json, .env, env vars)
- `DbContext` (SQLite ou PostgreSQL auto-detectado)
- Repositórios: `IUserRepository`, `IAddressRepository`, `IProductRepository`, `ICartRepository`, `IOrderRepository`, `ICategoryRepository`
- `IAuthService`
- `ServiceLocator` para acesso global opcional

### ServiceLocator (Opcional) - NOVO
```csharp
public static class ServiceLocator {
    public static void Initialize(IServiceProvider provider);
    public static T GetService<T>() where T : notnull;
    public static T? GetServiceOrDefault<T>() where T : class;
}
```
Usado por `MainViewModel` para obter `IAuthService` sem construtor injection

---

## Banco de Dados & Entity Framework Core - NOVO

### PizzariaDbContext
```csharp
public class PizzariaDbContext : DbContext {
    public DbSet<User> Users { get; set; }
    public DbSet<Address> Addresses { get; set; }
    public DbSet<Product> Products { get; set; }
    public DbSet<Category> Categories { get; set; }
    public DbSet<CustomizationOption> CustomizationOptions { get; set; }
    public DbSet<CustomizationChoice> CustomizationChoices { get; set; }
    public DbSet<Order> Orders { get; set; }
    public DbSet<OrderItem> OrderItems { get; set; }
    public DbSet<StatusTimeline> StatusTimelines { get; set; }
    public DbSet<CartItem> CartItems { get; set; }
}
```

### Migrações (3 migrações)
1. `20261112144120_InitialCreate` - Schema inicial
2. `20261112144934_InitialCreateLowercase` - Nomes de tabelas/colunas em snake_case
3. `20261112152309_AddCreatedAtColumns` - Colunas CreatedAt

### DatabaseEntities.cs
Entidades EF Core completas com anotações:
- Tabelas: `users`, `addresses`, `products`, `categories`, `customization_options`, `customization_choices`, `orders`, `order_items`, `order_status_timeline`, `cart_items`
- Índices, foreign keys, constraints
- JSON columns para customizações (`customizations_json`)

### Providers Suportados
- **SQLite** (padrão dev): `Data Source=pizzaria.db;Cache=Shared`
- **PostgreSQL** (produção): via `DATABASE_CONNECTION_STRING` (URL ou formato padrão)
  - Suporta `postgresql://user:pass@host:port/db?sslmode=require`
  - Auto-converte URL para connection string Npgsql

### Inicialização (App.xaml.cs)
```csharp
// OnStartup:
1. BuildConfiguration() → carrega .env, appsettings.json, env vars
2. AddPizzariaServices() → configura DI
3. ServiceLocator.Initialize(Services)
4. InitializeDatabaseAsync():
   - Aplica migrações pendentes (MigrateAsync)
   - Se sem migrações: EnsureCreatedAsync()
   - FixColumnNamesAsync() → cria tabelas faltantes via SQL raw (PostgreSQL)
```

### Configuração (appsettings.json / .env)
```json
{
  "JWT_SECRET_KEY": "sua-chave-secreta-super-segura-aqui",
  "JWT_ISSUER": "PizzariaDesktop",
  "JWT_AUDIENCE": "PizzariaDesktopUsers",
  "JWT_EXPIRY_HOURS": "24",
  "DATABASE_CONNECTION_STRING": "Data Source=pizzaria.db;Cache=Shared"
}
```
```env
# .env (opcional, para development)
DATABASE_CONNECTION_STRING=postgresql://user:pass@localhost:5432/pizzaria?sslmode=require
JWT_SECRET_KEY=chave-desenvolvimento-nao-usar-em-producao
```

---

## Repositórios - NOVO

### Interfaces (IRepositories.cs)
```csharp
public interface IUserRepository {
    Task<User?> GetByEmailAsync(string email);
    Task<User?> GetByEmailWithAddressesAsync(string email);
    Task<User?> GetByIdAsync(string id);
    Task<bool> ExistsAsync(string email);
    Task<bool> VerifyPasswordAsync(string email, string password);
    Task<User> CreateAsync(User user, string passwordHash);
    Task<User> UpdateAsync(User user);
}

public interface IAddressRepository { ... }
public interface IProductRepository { ... }
public interface ICartRepository { ... }
public interface IOrderRepository { ... }
public interface ICategoryRepository { ... }
```

### Implementações (Repositories.cs)
- EF Core com `AsNoTracking()` para queries de leitura
- `Include()` para eager loading (ex: User com Addresses)
- Transações implícitas via `SaveChangesAsync()`

---

## Converters (14 total)

### ValueConverters (IValueConverter)
| Converter | Uso |
|-----------|-----|
| `BoolToVisibilityConverter` | bool → Visibility (True=Visible) |
| `InverseBoolToVisibilityConverter` | bool → Visibility (True=Collapsed) |
| `InverseBoolConverter` | bool → !bool |
| `OrderStatusToColorConverter` | OrderStatus → Brush (cor do status) |
| `CategoryToIconConverter` | Category → string (emoji) |
| `CategoryDisplayNameConverter` | Category → string (nome amigável) |
| `CategoryBackgroundConverter` | Category → Brush (bg do badge) - **COMBOBOX WORKAROUND** |
| `CategoryBorderConverter` | Category → Brush (borda do badge) - **COMBOBOX WORKAROUND** |
| `CategoryForegroundConverter` | Category → Brush (texto do badge) - **COMBOBOX WORKAROUND** |
| `BoolToBackgroundConverter` | bool → Brush (seleção) |
| `EmptyToVisibilityConverter` | string/IEnumerable → Visibility (vazio=Collapsed) |

### MultiValueConverters (IMultiValueConverter) - Para ConverterParameter com Binding
| Converter | Uso |
|-----------|-----|
| `CategoryBackgroundMultiConverter` | (Category, IsSelected) → Brush |
| `CategoryBorderMultiConverter` | (Category, IsSelected) → Brush |
| `CategoryForegroundMultiConverter` | (Category, IsSelected) → Brush |

**Nota:** WPF não permite Binding no `ConverterParameter`. Solution: `MultiBinding` com `IMultiValueConverter` recebendo `(value, parameter)` como array.

---

## Design System

### Cores
```xml
<!-- Cores -->
<Color x:Key="PrimaryColor">#FF6B35</Color>        <!-- Laranja principal -->
<Color x:Key="PrimaryVariantColor">#E85D2E</Color>
<Color x:Key="SecondaryColor">#2D2D2D</Color>      <!-- Cinza escuro -->
<Color x:Key="BackgroundColor">#FFFFFFFF</Color>   <!-- Branco -->
<Color x:Key="SurfaceColor">#FFF5F5F5</Color>      <!-- Cinza claro -->
<Color x:Key="ErrorColor">#DC3545</Color>
<Color x:Key="SuccessColor">#28A745</Color>
<Color x:Key="WarningColor">#FFC107</Color>
<Color x:Key="TextPrimaryColor">#FF1A1A1A</Color>
<Color x:Key="TextSecondaryColor">#FF666666</Color>
<Color x:Key="BorderColor">#FFE0E0E0</Color>
<Color x:Key="CardBackgroundColor">#FFFFFFFF</Color>

<!-- Brushes (usar estes nas propriedades Background/Border/etc) -->
<SolidColorBrush x:Key="PrimaryBrush" Color="{StaticResource PrimaryColor}" />
<SolidColorBrush x:Key="SurfaceBrush" Color="{StaticResource SurfaceColor}" />
<SolidColorBrush x:Key="CardBackgroundBrush" Color="{StaticResource CardBackgroundColor}" />
<SolidColorBrush x:Key="ErrorBrush" Color="{StaticResource ErrorColor}" />
<SolidColorBrush x:Key="SuccessBrush" Color="{StaticResource SuccessColor}" />
<SolidColorBrush x:Key="WarningBrush" Color="{StaticResource WarningColor}" />
<SolidColorBrush x:Key="TextPrimaryBrush" Color="{StaticResource TextPrimaryColor}" />
<SolidColorBrush x:Key="TextSecondaryBrush" Color="{StaticResource TextSecondaryColor}" />
<SolidColorBrush x:Key="BorderBrush" Color="{StaticResource BorderColor}" />
```

### Tipografia (Segoe UI)
| Style | Tamanho | Peso | Cor |
|-------|---------|------|-----|
| HeadlineStyle | 28 | Bold | TextPrimary |
| TitleStyle | 22 | SemiBold | TextPrimary |
| SubtitleStyle | 16 | Medium | TextSecondary |
| BodyStyle | 14 | Normal | TextPrimary |
| CaptionStyle | 12 | Normal | TextSecondary |

### Espaçamento (Base 8px)
- xs: 4px, sm: 8px, md: 16px, lg: 24px, xl: 32px, xxl: 48px

### Border Radius
- sm: 4px, md: 8px, lg: 12px, xl: 16px, full: 999px

### Sombras (Cards)
```xml
<DropShadowEffect BlurRadius="8" ShadowDepth="0" Opacity="0.08" Color="#FF000000" />
```

---

## Janela Principal (MainWindow)
- **WindowState="Maximized"** - Tela cheia
- **Sidebar** (260px) à esquerda - visível apenas quando logado
- **ContentControl** à direita - bind para `CurrentView`
- **TopBar** colapsada (mobile future)
- Sidebar contém: Logo, 5 botões navegação (com badge no Carrinho), User info, Logout

---

## Dados Mock (MockData.cs) - Fallback

### Inicialização Order (importante para evitar circular dependency)
```csharp
// Ordem: Addresses → Products → CurrentUser → Orders → CartItems
public static readonly List<Address> Addresses = CreateAddresses();
public static readonly List<Product> Products = CreateProducts();
public static readonly User CurrentUser = CreateUser();
public static readonly List<Order> Orders = CreateOrders();  // Usa Addresses, Products, CurrentUser
public static readonly List<CartItem> CartItems = CreateCartItems();  // Usa Products
```

### Conteúdo
- **18 Produtos**: 8 Pizzas, 4 Bebidas, 3 Sobremesas, 3 Acompanhamentos
- **4 Pedidos** com status variados e timelines completas
- **2 Endereços** (Casa, Trabalho)
- **1 Usuário** mock logado
- **2 Itens no carrinho** iniciais

> **Nota:** MockData é usado como fallback quando `ServiceLocator` não está inicializado (design-time, testes, ou modo demo sem banco).

---

## Fluxo de Checkout Completo - NOVO

```mermaid
sequenceDiagram
    participant User
    participant CartView
    participant CartVM
    participant MainVM
    participant OrderConfirmationDialog
    
    User->>CartView: Clica "Finalizar Pedido"
    CartView->>CartVM: GoToCheckoutCommand
    CartVM->>CartVM: IsProcessing = true
    CartVM->>CartVM: CreateOrderFromCart() (status=Confirmed, timeline)
    CartVM->>MainVM: AddOrderToHistory(order)
    CartVM->>MainVM: ClearCart()
    CartVM->>OrderConfirmationDialog: ShowDialog(order)
    OrderConfirmationDialog->>User: Animação sucesso + detalhes
    User->>OrderConfirmationDialog: "Acompanhar Pedido" ou "Fazer Outro Pedido"
    OrderConfirmationDialog->>MainVM: NavigateToOrders() / NavigateToMenu()
```

### OrderConfirmationDialog - NOVO
- **Window** sem chrome (`WindowStyle=None`, `AllowsTransparency=True`)
- **Animações**: Fade+Scale (card), Checkmark com BackEase, Pulse ring, Stagger content
- **Conteúdo**:
  - Header verde com checkmark animado + "Pedido Confirmado e Pago!"
  - Card "Previsão de Entrega" (grande, destaque) com horário, janela, endereço
  - Card "Forma de Pagamento" com badge "PAGO" verde
  - Lista de itens do pedido
  - Card totais (Subtotal, Taxa, Total Pago)
  - Dica: "Acompanhe o status em tempo real na aba Meus Pedidos"
  - Botões: "Acompanhar Pedido" (Primary) → Orders, "Fazer Outro Pedido" (Secondary) → Menu

---

## Problemas Conhecidos & Soluções Aplicadas

| Problema | Solução |
|----------|---------|
| `x:Key "SurfaceBrush"` typo | Corrigido para `x:Key="SurfaceBrush"` |
| XAML Parse: ConverterParameter Binding | `IMultiValueConverter` + `MultiBinding` |
| SurfaceColor (Color) usado como Brush | Usar `SurfaceBrush` |
| ComboBox com Style de TextBox | Remover `Style="{StaticResource InputStyle}"` do ComboBox |
| Input text invisível | `Foreground="{TemplateBinding Foreground}"` no ScrollViewer do template |
| PasswordBox binding não funciona | Remover binding, usar `PasswordChanged` event handler |
| x:Name não acessível no code-behind | Build necessário para gerar .g.cs |
| App.exe locked on rebuild | `Stop-Process -Name "PizzariaDesktop"` antes do build |
| Duplicate types (old folder) | `<Compile Remove="ProgramasJanelasPizzariaDesktop\**" />` no csproj |
| EF Core migrations SQLite vs PostgreSQL | Provider auto-detectado pela connection string |
| Tabelas PostgreSQL case-sensitive | `FixColumnNamesAsync()` cria tabelas snake_case via SQL raw |
| PasswordBox show/hide | PasswordBox ↔ TextBox swap no code-behind |

---

## Comandos Úteis

```bash
# Build
dotnet build PizzariaDesktop.csproj

# Run (GUI app - bloqueia terminal)
dotnet run --project PizzariaDesktop.csproj

# Run built exe directly
bin\Debug\net11.0-windows\PizzariaDesktop.exe

# Kill running app
Stop-Process -Name "PizzariaDesktop" -Force

# Clean build artifacts
dotnet clean
rm -rf bin obj

# Entity Framework Core
dotnet ef migrations add NovaMigracao --project PizzariaDesktop.csproj
dotnet ef database update --project PizzariaDesktop.csproj
dotnet ef migrations list --project PizzariaDesktop.csproj

# Ver versão .NET
dotnet --version  # 11.0.100-rc.1+
```

---

## Checklist para Novos Desenvolvedores/Agentes

Ao trabalhar neste projeto, **SEMPRE**:

1. **Leia este arquivo** antes de começar qualquer tarefa
2. **Siga a estrutura MVVM** - Views só XAML, lógica no ViewModel
3. **Use DataTemplates** em App.xaml para navegação (não instancie Views no código)
4. **Converters** em `PizzariaDesktop.Converters` namespace (ou App.xaml.cs para os básicos)
5. **Dados estáticos** só em `MockData.cs` - não hardcode nas Views
6. **INotifyPropertyChanged** via `BaseViewModel.SetProperty()`
7. **Commands** via `RelayCommand` (action ou async)
8. **Nomeamento**: PascalCase classes, camelCase propriedades/métodos, SCREAMING_SNAKE_CASE consts
9. **DI**: Use `ServiceLocator.GetService<T>()` ou injete via construtor quando possível
10. **Auth**: Use `IAuthService` para login/register - não coloque lógica direta no ViewModel
11. **Banco**: Repositórios via interfaces - não use DbContext direto nos ViewModels
12. **Atualize este arquivo** quando:
    - Adicionar nova feature/View/ViewModel
    - Mudar arquitetura ou padrões
    - Adicionar converter novo
    - Corrigir bug estrutural
    - Adicionar migração/mudar schema DB
13. **Teste visual** - rode o app (`dotnet run`) após mudanças no XAML

---

## Roadmap / Próximos Passos

### Fase Atual - Visual + Backend Local ✅
- [x] Login full-screen split com show/hide password
- [x] **Registro completo** com validação + BCrypt + JWT
- [x] Home com quick actions e promoções
- [x] Menu com tabs de categoria e grid produtos
- [x] Carrinho com quantidades, endereço, pagamento
- [x] **Checkout com OrderConfirmationDialog animado**
- [x] Orders com lista + sidebar detalhe + timeline
- [x] Profile com dados, endereços, stats, logout
- [x] Navegação sidebar + DataTemplates + Register flow
- [x] **Entity Framework Core** (SQLite/PostgreSQL) + Migrações
- [x] **Repository Pattern** + DI (Microsoft.Extensions.DI)
- [x] Design system consistente
- [x] Build limpo, run funcional

### Futuro (Backend Real / Produção)
- [ ] API Service (HttpClient + interfaces) para substituir repositórios locais
- [ ] SignalR para tracking real-time de pedidos
- [ ] Persistência local (SQLite) para cache offline + sync
- [ ] Testes unitários (xUnit + Moq) - ViewModels, Services, Repositories
- [ ] Testes de integração (EF Core InMemory / Testcontainers)
- [ ] CI/CD (GitHub Actions) - build, test, publish
- [ ] Installer (MSIX/ClickOnce)
- [ ] Logging estruturado (Serilog)
- [ ] Configuração por ambiente (Development/Staging/Production)
- [ ] Refresh tokens + armazenamento seguro (DPAPI/Keychain)
- [ ] Push notifications (Windows Push Notification Services)

---

## Referências Técnicas

- **Framework**: .NET 11 (preview) / WPF
- **Linguagem**: C# 13
- **Arquitetura**: MVVM + Repository Pattern + DI
- **ORM**: Entity Framework Core 9+
- **Database**: SQLite (dev) / PostgreSQL (prod)
- **Auth**: JWT (HS256) + BCrypt.Net (work factor 12)
- **DI**: Microsoft.Extensions.DependencyInjection
- **Config**: Microsoft.Extensions.Configuration (JSON, .env, EnvVars)
- **Build**: MSBuild / dotnet CLI
- **IDE**: VS Code + C# Dev Kit ou Visual Studio 2022+

---

## Histórico de Correções (2026-11-12)

### 1. App.xaml - SurfaceBrush typo
**Erro:** `x:Key "SurfaceBrush"` (aspas erradas)
**Fix:** `x:Key="SurfaceBrush"`

### 2. MockData.cs - CreateOrders() syntax errors
**Erro:** Object initializers aninhados com propriedades obrigatórias
**Fix:** Refatorado para uso imperativo `Add()` com inicialização separada

### 3. Tela Branca - DataTemplates faltando
**Erro:** ContentControl não renderizava ViewModels
**Fix:** 6 DataTemplates em App.xaml com xmlns separados (viewsAuth, viewsHome, etc.)

### 4. Login não navegava
**Erro:** MainViewModel não subscrevia `LoginViewModel.OnLoginSuccess`
**Fix:** Subscrição no construtor do MainViewModel antes de setar CurrentView

### 5. Crash na navegação sidebar
**Erro:** Views criavam próprio DataContext no XAML → conflito com DataTemplate
**Fix:** Removido `UserControl.DataContext` de todas as 6 Views

### 6. Converters não existiam
**Erro:** XAML referenciava converters inexistentes
**Fix:** Criado `Converters.cs` com 11 IValueConverter + 3 IMultiValueConverter

### 7. Category enum mismatch
**Erro:** Converters esperavam enum Flutter (pizza, drink...) mas C# usa (Pizza, Drink...)
**Fix:** Ajustado switches para valores PascalCase

### 8. ConverterParameter Binding inválido
**Erro:** `<Binding ... ConverterParameter={Binding IsSelected}>` não compila
**Fix:** `MultiBinding` + `IMultiValueConverter` recebendo `(value, parameter)` array

### 9. Propriedades faltando nos ViewModels
**Erro:** `CartItemCount`, `IsSelected`, `ReorderCommand`, `GoToMenuCommand`
**Fix:** Adicionadas propriedades e commands necessários

### 10. ComboBox com InputStyle
**Erro:** Style de TextBox aplicado em ComboBox quebra rendering
**Fix:** Removido Style do ComboBox, usa template padrão

### 11. Texto invisível nos inputs
**Erro:** ScrollViewer no template não propagava Foreground
**Fix:** `Foreground="{TemplateBinding Foreground}"` no ScrollViewer

### 12. PasswordBox binding
**Erro:** Password não é DependencyProperty
**Fix:** Removido binding, mantido `PasswordChanged` handler para sync ViewModel

### 13. Show/Hide Password eye button
**Feature:** Toggle 👁/🙈 com PasswordBox ↔ TextBox swap
**Implementação:** Code-behind em LoginView.xaml.cs com 3 handlers

### 14. Projeto movido para pasta pai
**Mudança:** `c:\Programas\Janelas\ProgramasJanelasPizzariaDesktop` → `c:\Programas\Janelas`
**Fix:** csproj com `<Compile Remove="ProgramasJanelasPizzariaDesktop\**" />` para excluir pasta antiga

---

## Novidades da Versão 2.0 (2026-11-12) - **MAJOR UPDATE**

### 🔐 Autenticação Real
- **AuthService** com BCrypt (work factor 12) + JWT (HS256, 24h)
- **Registro** completo: Nome, Email, Telefone (máscara), Senha, Confirmar Senha
- **Validação campo a campo** com erros inline (HasNameError, HasEmailError, etc.)
- **Show/Hide Password** em ambos campos (Senha + Confirmar Senha)
- **Fallback Demo Mode** - funciona sem banco para desenvolvimento

### 🗄️ Persistência Real (Entity Framework Core)
- **PizzariaDbContext** com 10 DbSets
- **3 Migrações**: InitialCreate → Lowercase → AddCreatedAtColumns
- **Dual Provider**: SQLite (dev) + PostgreSQL (prod) auto-detectado
- **Repository Pattern**: 6 repositórios tipados via interfaces
- **ServiceCollectionExtensions** - DI completo estilo ASP.NET Core
- **ServiceLocator** para acesso global em ViewModels

### 🛒 Checkout & Confirmação
- **CartViewModel.GoToCheckoutAsync()** - cria Order com timeline completa
- **OrderConfirmationDialog** - Window animada (fade, scale, checkmark, pulse, stagger)
  - Previsão de entrega em destaque (grande, verde)
  - Badge "PAGO" animado
  - Lista itens + totais
  - Botões: Acompanhar Pedido / Fazer Outro Pedido
- **Navegação pós-checkout** → Orders ou Menu

### 📁 Estrutura Nova
```
Services/
  AuthService.cs              # Login, Register, JWT, BCrypt
  ServiceCollectionExtensions.cs  # DI, DbContext, Repos, ServiceLocator

Data/
  Entities/DatabaseEntities.cs    # Entidades EF Core
  Migrations/                     # 3 migrações
  PizzariaDbContext.cs           # DbContext dual provider
  Repositories/
    IRepositories.cs             # 6 interfaces
    Repositories.cs              # Implementações EF Core

ViewModels/
  RegisterViewModel.cs           # Registro com validação + AuthService

Views/Auth/
  RegisterView.xaml/.cs          # Split 50/50 + phone mask + 2x show/hide

Views/Cart/
  OrderConfirmationDialog.xaml/.cs  # Modal animado sucesso
```

### ⚙️ Configuração
- `appsettings.json` / `appsettings.Development.json`
- `.env` support via `DotNetEnv`
- Environment Variables (produção)
- `DATABASE_CONNECTION_STRING` aceita URL PostgreSQL (`postgresql://...`) ou formato padrão

---

*Última atualização: 2026-11-12*
*Este documento deve ser mantido atualizado a cada mudança significativa no projeto.*