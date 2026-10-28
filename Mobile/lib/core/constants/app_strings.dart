/// Textos e strings da aplicação
class AppStrings {
  AppStrings._();

  // App
  static const String appName = 'Pizzaria Delivery';

  // Auth
  static const String login = 'Entrar';
  static const String register = 'Cadastrar';
  static const String logout = 'Sair';
  static const String email = 'E-mail';
  static const String password = 'Senha';
  static const String confirmPassword = 'Confirmar senha';
  static const String name = 'Nome completo';
  static const String phone = 'Telefone';
  static const String forgotPassword = 'Esqueci a senha';
  static const String dontHaveAccount = 'Não tem conta?';
  static const String alreadyHaveAccount = 'Já tem conta?';
  static const String createAccount = 'Criar conta';
  static const String loginSuccess = 'Login realizado com sucesso!';
  static const String registerSuccess = 'Conta criada com sucesso!';
  static const String invalidCredentials = 'E-mail ou senha inválidos';
  static const String emailAlreadyExists = 'Este e-mail já está cadastrado';
  static const String weakPassword = 'A senha deve ter pelo menos 6 caracteres';
  static const String passwordsDontMatch = 'As senhas não coincidem';
  static const String fillAllFields = 'Preencha todos os campos';

  // Home
  static const String welcome = 'Bem-vindo';
  static const String welcomeBack = 'Bem-vindo de volta';
  static const String orderNow = 'Fazer pedido';
  static const String myOrders = 'Meus pedidos';
  static const String promotions = 'Promoções';
  static const String noOrdersYet = 'Nenhum pedido ainda';
  static const String makeFirstOrder = 'Faça seu primeiro pedido!';

  // Menu
  static const String menu = 'Cardápio';
  static const String categories = 'Categorias';
  static const String pizzas = 'Pizzas';
  static const String drinks = 'Bebidas';
  static const String desserts = 'Sobremesas';
  static const String sides = 'Acompanhamentos';
  static const String addToCart = 'Adicionar ao carrinho';
  static const String customize = 'Personalizar';
  static const String ingredients = 'Ingredientes';
  static const String prepTime = 'Tempo de preparo';
  static const String minutes = 'min';
  static const String unavailable = 'Indisponível';

  // Cart
  static const String cart = 'Carrinho';
  static const String cartEmpty = 'Carrinho vazio';
  static const String addItems = 'Adicione itens do cardápio';
  static const String subtotal = 'Subtotal';
  static const String deliveryFee = 'Taxa de entrega';
  static const String total = 'Total';
  static const String checkout = 'Finalizar pedido';
  static const String quantity = 'Quantidade';
  static const String notes = 'Observações';
  static const String optionalNotes = 'Observações opcionais (ex: sem cebola)';
  static const String removeItem = 'Remover';
  static const String clearCart = 'Limpar carrinho';

  // Checkout
  static const String checkoutTitle = 'Finalizar pedido';
  static const String deliveryAddress = 'Endereço de entrega';
  static const String selectAddress = 'Selecionar endereço';
  static const String addNewAddress = 'Adicionar novo endereço';
  static const String paymentMethod = 'Forma de pagamento';
  static const String cash = 'Dinheiro';
  static const String card = 'Cartão';
  static const String pix = 'PIX';
  static const String wallet = 'Saldo do app';
  static const String changeFor = 'Troco para';
  static const String orderNotes = 'Observações do pedido';
  static const String confirmOrder = 'Confirmar pedido';
  static const String orderConfirmed = 'Pedido confirmado!';
  static const String estimatingTime = 'Tempo estimado:';

  // Orders
  static const String orders = 'Pedidos';
  static const String orderDetails = 'Detalhes do pedido';
  static const String orderNumber = 'Pedido #';
  static const String status = 'Status';
  static const String items = 'Itens';
  static const String deliveryAddressLabel = 'Endereço de entrega';
  static const String paymentMethodLabel = 'Forma de pagamento';
  static const String orderDate = 'Data do pedido';
  static const String estimatedDelivery = 'Previsão de entrega';
  static const String trackOrder = 'Acompanhar pedido';
  static const String reorder = 'Pedir novamente';
  static const String cancelOrder = 'Cancelar pedido';
  static const String orderCancelled = 'Pedido cancelado';
  static const String confirmCancel = 'Tem certeza que deseja cancelar?';

  // Order Status
  static const String statusPending = 'Aguardando confirmação';
  static const String statusConfirmed = 'Confirmado';
  static const String statusPreparing = 'Em preparação';
  static const String statusBaking = 'No forno';
  static const String statusReady = 'Pronto para entrega';
  static const String statusOutForDelivery = 'Saiu para entrega';
  static const String statusDelivered = 'Entregue';
  static const String statusCancelled = 'Cancelado';

  // Profile
  static const String profile = 'Perfil';
  static const String personalInfo = 'Informações pessoais';
  static const String addresses = 'Endereços';
  static const String paymentMethods = 'Formas de pagamento';
  static const String orderHistory = 'Histórico de pedidos';
  static const String settings = 'Configurações';
  static const String editProfile = 'Editar perfil';
  static const String saveChanges = 'Salvar alterações';
  static const String deleteAccount = 'Excluir conta';

  // Addresses
  static const String addAddress = 'Adicionar endereço';
  static const String editAddress = 'Editar endereço';
  static const String addressLabel = 'Apelido (ex: Casa, Trabalho)';
  static const String street = 'Rua';
  static const String number = 'Número';
  static const String complement = 'Complemento';
  static const String neighborhood = 'Bairro';
  static const String city = 'Cidade';
  static const String state = 'Estado';
  static const String zipCode = 'CEP';
  static const String setAsDefault = 'Definir como padrão';
  static const String defaultAddress = 'Endereço padrão';

  // Errors / Generic
  static const String error = 'Erro';
  static const String success = 'Sucesso';
  static const String warning = 'Atenção';
  static const String info = 'Informação';
  static const String tryAgain = 'Tentar novamente';
  static const String cancel = 'Cancelar';
  static const String confirm = 'Confirmar';
  static const String save = 'Salvar';
  static const String edit = 'Editar';
  static const String delete = 'Excluir';
  static const String loading = 'Carregando...';
  static const String noInternet = 'Sem conexão com a internet';
  static const String somethingWentWrong = 'Algo deu errado. Tente novamente.';
  static const String requiredField = 'Campo obrigatório';
  static const String invalidEmail = 'E-mail inválido';
  static const String invalidPhone = 'Telefone inválido';
  static const String invalidZipCode = 'CEP inválido';

  // Search
  static const String search = 'Buscar';
  static const String searchHint = 'Buscar pizzas, bebidas...';
  static const String noResults = 'Nenhum resultado encontrado';

  // Notifications
  static const String notifications = 'Notificações';
  static const String enableNotifications = 'Ativar notificações';
  static const String orderUpdates = 'Atualizações de pedidos';
  static const String promotionsAlerts = 'Promoções e ofertas';
}