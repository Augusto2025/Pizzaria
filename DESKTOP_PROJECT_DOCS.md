# Pizzaria Delivery App - Documentação do Projeto (Desktop C# WPF)

## Visão Geral
Sistema de delivery para pizzaria - versão desktop Windows (WPF). Clientes fazem pedidos pelo app e acompanham o status em tempo real. **Apenas dados estáticos/mock** - sem backend, sem persistência real, apenas visualização.

## Arquitetura do Projeto

### Estrutura de Pastas
```
PizzariaDesktop/
├── App.xaml                  # Recursos globais, estilos, converters, DataTemplates
├── App.xaml.cs               # Código do Application
├── MainWindow.xaml           # Janela principal com sidebar + ContentControl
├── MainWindow.xaml.cs        # Code-behind mínimo
├── AssemblyInfo.cs           # Atributos de assembly
├── PizzariaDesktop.csproj    # Projeto .NET 11 (preview)
│
├── Converters/
│   └── Converters.cs         # 11 ValueConverters + 3 IMultiValueConverters
│
├── Data/
│   └── MockData.cs           # Factory de dados estáticos (18 produtos, 4 pedidos, 2 endereços, etc.)
│
├── Models/
│   ├── Enums.cs              # Category, OrderStatus, PaymentMethod
│   ├── UserModels.cs         # User, Address
│   ├── ProductModels.cs      # Product, CustomizationOption, CustomizationChoice
│   └── OrderModels.cs        # CartItem, OrderItem, Order, StatusTimeline (INotifyPropertyChanged)
│
├── ViewModels/
│   ├── BaseViewModel.cs      # INotifyPropertyChanged base
│   ├── RelayCommand.cs       # ICommand implementation
│   ├── MainViewModel.cs      # Navegação, estado global, cart, login
│   ├── LoginViewModel.cs     # Login logic, events
│   ├── HomeViewModel.cs      # Promoções, quick actions
│   ├── MenuViewModel.cs      # Produtos por categoria, filtros
│   ├── CartViewModel.cs      # Carrinho, quantities, checkout
│   ├── OrdersViewModel.cs    # Lista de pedidos, detalhe sidebar
│   └── ProfileViewModel.cs   # Perfil, endereços, stats
│
├── Views/
│   ├── Auth/
│   │   ├── LoginView.xaml          # Full-screen split 50/50 (brand + form)
│   │   └── LoginView.xaml.cs       # Show/hide password toggle
│   ├── Home/
│   │   └── HomeView.xaml           # Dashboard com promoções, quick actions
│   ├── Menu/
│   │   └── MenuView.xaml           # Categorias tabs + grid de produtos
│   ├── Cart/
│   │   └── CartView.xaml           # Itens, endereço, pagamento, total
│   ├── Orders/
│   │   └── OrdersView.xaml         # Lista + sidebar detalhe
│   └── Profile/
│       └── ProfileView.xaml        # Dados, endereços, configurações
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
- **Static Mock Data** - MockData.cs com factory methods
- **Converters** para transformações UI (14 converters total)
- **Event-based Navigation** - MainViewModel subscreve eventos dos ViewModels filhos

---

## Funcionalidades Principais (Visual Only)

### 1. Autenticação (Auth)
- **Login**: Email + Senha (qualquer valor funciona no demo)
- **Show/Hide Password**: Botão olho 👁/🙈 no PasswordBox
- **Layout**: Full-screen split 50/50 - esquerda brand (laranja #FF6B35), direita formulário centralizado
- **Sem persistência** - navega para Home ao clicar "Entrar"

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
- Botão "Adicionar" navega para carrinho (demo)

### 4. Carrinho (Cart)
- Lista de itens com: produto, quantidade (+/-), preço unitário, total
- Editar quantidade inline
- Remover item
- Seleção de endereço (ComboBox com endereços mock)
- Forma de pagamento (ComboBox: Dinheiro, Cartão, PIX)
- Resumo: subtotal, taxa entrega, total
- Botão "Finalizar Pedido" (demo)

### 5. Pedidos (Orders)
- Lista de pedidos com status colorido:
  - `Pending` - Aguardando
  - `Confirmed` - Confirmado
  - `Preparing` - Preparando
  - `Baking` - Assando
  - `Ready` - Pronto
  - `OutForDelivery` - Saiu para entrega
  - `Delivered` - Entregue
  - `Cancelled` - Cancelado
- **Sidebar de detalhe** ao clicar no pedido: itens, valores, endereço, pagamento, timeline de status
- Timeline visual com ícones e timestamps

### 6. Perfil (Profile)
- Dados pessoais (nome, email, telefone) - somente leitura no demo
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
    public List<Address> Addresses { get; set; }
    public DateTime CreatedAt { get; set; }
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

// Comandos de navegação
NavigateToHomeCommand    → HomeViewModel
NavigateToMenuCommand    → MenuViewModel
NavigateToCartCommand    → CartViewModel
NavigateToOrdersCommand  → OrdersViewModel
NavigateToProfileCommand → ProfileViewModel
LogoutCommand            → LoginViewModel
```

### Login Flow
1. `MainViewModel` cria `LoginViewModel` e subscreve `OnLoginSuccess`
2. `LoginViewModel.LoginAsync()` valida e dispara `OnLoginSuccess(user)`
3. `MainViewModel.Login(user)` define `CurrentUser`, `IsLoggedIn=true`, navega para `HomeViewModel`

### DataTemplates (App.xaml)
```xml
<DataTemplate DataType="{x:Type vm:LoginViewModel}"><viewsAuth:LoginView /></DataTemplate>
<DataTemplate DataType="{x:Type vm:HomeViewModel}"><viewsHome:HomeView /></DataTemplate>
<DataTemplate DataType="{x:Type vm:MenuViewModel}"><viewsMenu:MenuView /></DataTemplate>
<DataTemplate DataType="{x:Type vm:CartViewModel}"><viewsCart:CartView /></DataTemplate>
<DataTemplate DataType="{x:Type vm:OrdersViewModel}"><viewsOrders:OrdersView /></DataTemplate>
<DataTemplate DataType="{x:Type vm:ProfileViewModel}"><viewsProfile:ProfileView /></DataTemplate>
```
- Views **NÃO** definem `DataContext` no XAML - o ContentControl injeta automaticamente

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
...
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

## Dados Mock (MockData.cs)

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

# Ver versão .NET
dotnet --version  # 11.0.100-rc.1+
```

---

## Checklist para Novos Desenvolvedores/Agentes

Ao trabalhar neste projeto, **SEMPRE**:

1. **Leia este arquivo** antes de começar qualquer tarefa
2. **Siga a estrutura MVVM** - Views só XAML, lógica no ViewModel
3. **Use DataTemplates** em App.xaml para navegação (não instancie Views no código)
4. **Converters** em `PizzariaDesktop.Converters` namespace
5. **Dados estáticos** só em `MockData.cs` - não hardcode nas Views
6. **INotifyPropertyChanged** via `BaseViewModel.SetProperty()`
7. **Commands** via `RelayCommand` (action ou async)
8. **Nomeamento**: PascalCase classes, camelCase propriedades/métodos, SCREAMING_SNAKE_CASE consts
9. **Atualize este arquivo** quando:
   - Adicionar nova feature/View/ViewModel
   - Mudar arquitetura ou padrões
   - Adicionar converter novo
   - Corrigir bug estrutural
10. **Teste visual** - rode o app (`dotnet run`) após mudanças no XAML

---

## Roadmap / Próximos Passos

### Fase Atual - Visual Complete ✅
- [x] Login full-screen split com show/hide password
- [x] Home com quick actions e promoções
- [x] Menu com tabs de categoria e grid produtos
- [x] Carrinho com quantidades, endereço, pagamento
- [x] Orders com lista + sidebar detalhe + timeline
- [x] Profile com dados, endereços, stats, logout
- [x] Navegação sidebar + DataTemplates
- [x] Design system consistente
- [x] Build limpo, run funcional

### Futuro (se backend for adicionado)
- [ ] API Service (HttpClient + interfaces)
- [ ] Auth real (JWT, refresh tokens)
- [ ] SignalR para tracking real-time
- [ ] Persistência local (SQLite/LiteDB) para cache offline
- [ ] Testes unitários (xUnit + Moq)
- [ ] CI/CD (GitHub Actions)
- [ ] Installer (MSIX/ClickOnce)

---

## Referências Técnicas

- **Framework**: .NET 11 (preview) / WPF
- **Linguagem**: C# 13
- **Arquitetura**: MVVM
- **DI**: Manual (MainViewModel cria filhos) - sem container externo
- **Build**: MSBuild / dotnet CLI
- **IDE**: VS Code + C# Dev Kit ou Visual Studio 2022+

---

## Histórico de Correções (2026-10-25)

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

*Última atualização: 2026-10-25*
*Este documento deve ser mantido atualizado a cada mudança significativa no projeto.*