# Pizzaria Delivery App

Sistema completo de delivery para pizzaria com duas plataformas:
- **Desktop**: C# WPF (.NET 11) - App nativo Windows
- **Mobile**: Flutter (Dart) - App iOS/Android

---

## 🖥️ Desktop (WPF) - `Desktop/`

Aplicação Windows nativa com:
- **Autenticação real**: Login/Registro com BCrypt + JWT tokens
- **Persistência**: Entity Framework Core (SQLite dev / PostgreSQL prod)
- **Arquitetura**: MVVM + Repository Pattern + Dependency Injection
- **Checkout completo**: Carrinho → OrderConfirmationDialog animado → Pedidos

### Tech Stack
| Componente | Tecnologia |
|------------|------------|
| Framework | .NET 11 (preview) / WPF |
| Linguagem | C# 13 |
| ORM | Entity Framework Core 9+ |
| Database | SQLite (dev) / PostgreSQL (prod) |
| Auth | JWT (HS256) + BCrypt.Net |
| DI | Microsoft.Extensions.DependencyInjection |
| Config | appsettings.json + .env + EnvVars |

### Quick Start
```bash
cd Desktop
dotnet restore
dotnet build
dotnet run
```

### Documentação Completa
📖 **[DESKTOP_PROJECT_DOCS.md](DESKTOP_PROJECT_DOCS.md)** - Arquitetura, modelos, navegação, DB, comandos, roadmap

---

## 📱 Mobile (Flutter) - `Mobile/`

Aplicação Flutter multiplataforma (em desenvolvimento):
- Clean Architecture + Feature-first
- Riverpod (estado) + go_router (navegação)
- Dio (HTTP) + Freezed/JSON Serializable

### Quick Start
```bash
cd Mobile
flutter pub get
flutter run
```

### Documentação
📖 **[PROJECT_DOCS.md](PROJECT_DOCS.md)** - Arquitetura mobile, modelos, navegação, dependencies

---

## 📁 Estrutura do Repositório

```
Pizzaria/
├── Desktop/                 # App WPF C# (.NET 11)
│   ├── PizzariaDesktop.csproj
│   ├── App.xaml / App.xaml.cs
│   ├── MainWindow.xaml
│   ├── Models/              # Entidades de domínio
│   ├── ViewModels/          # MVVM ViewModels
│   ├── Views/               # XAML Views
│   ├── Services/            # AuthService, DI
│   ├── Data/                # EF Core, Repositories, MockData
│   ├── Converters/          # WPF ValueConverters
│   └── Resources/           # Assets (futuro)
│
├── Mobile/                  # App Flutter (Dart)
│   ├── lib/
│   │   ├── core/            # Constants, Theme, Router, Services
│   │   ├── features/        # Auth, Home, Menu, Cart, Orders, Profile
│   │   └── shared/          # Widgets, Models, Utils
│   └── pubspec.yaml
│
├── DESKTOP_PROJECT_DOCS.md  # Docs completas Desktop
├── PROJECT_DOCS.md          # Docs completas Mobile
└── README.md                # Este arquivo
```

---

## 🚀 Status do Projeto

### Desktop (WPF) - **Produção Ready** ✅
- [x] Login/Registro com JWT + BCrypt
- [x] EF Core com migrações (SQLite/PostgreSQL)
- [x] Repository Pattern + DI
- [x] Home, Menu, Carrinho, Pedidos, Perfil
- [x] Checkout com dialog de confirmação animado
- [x] Design system consistente
- [x] Build limpo, execução funcional

### Mobile (Flutter) - **Em Desenvolvimento** 🚧
- [ ] Setup dependencies (Riverpod, go_router, Dio, etc.)
- [ ] Auth (Login/Register/Logout)
- [ ] Home, Menu, Carrinho, Checkout
- [ ] Pedidos + Rastreamento
- [ ] Perfil + Configurações

---

## 🛠️ Comandos Úteis

### Desktop
```bash
# Build & Run
cd Desktop
dotnet build
dotnet run

# EF Core Migrations
dotnet ef migrations add NomeMigracao
dotnet ef database update
dotnet ef migrations list

# Limpeza
dotnet clean && rm -rf bin obj
Stop-Process -Name "PizzariaDesktop" -Force  # Se travado
```

### Mobile
```bash
cd Mobile
flutter pub get
flutter run
flutter build apk --release
```

---

## 📄 Licença

Projeto privado - Pizzaria Delivery App

---

*Última atualização: 2026-11-12*