using System;
using Microsoft.EntityFrameworkCore.Migrations;
using Npgsql.EntityFrameworkCore.PostgreSQL.Metadata;

#nullable disable

#pragma warning disable CA1814 // Prefer jagged arrays over multidimensional

namespace PizzariaDesktop.Data.Migrations
{
    /// <inheritdoc />
    public partial class InitialCreate : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "Categories",
                columns: table => new
                {
                    Id = table.Column<int>(type: "integer", nullable: false)
                        .Annotation("Npgsql:ValueGenerationStrategy", NpgsqlValueGenerationStrategy.IdentityByDefaultColumn),
                    Name = table.Column<string>(type: "character varying(20)", maxLength: 20, nullable: false),
                    DisplayName = table.Column<string>(type: "character varying(50)", maxLength: 50, nullable: false),
                    SortOrder = table.Column<int>(type: "integer", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Categories", x => x.Id);
                });

            migrationBuilder.CreateTable(
                name: "Users",
                columns: table => new
                {
                    Id = table.Column<string>(type: "character varying(50)", maxLength: 50, nullable: false),
                    Name = table.Column<string>(type: "character varying(100)", maxLength: 100, nullable: false),
                    Email = table.Column<string>(type: "character varying(150)", maxLength: 150, nullable: false),
                    PasswordHash = table.Column<string>(type: "character varying(255)", maxLength: 255, nullable: false),
                    Phone = table.Column<string>(type: "character varying(20)", maxLength: 20, nullable: false),
                    CreatedAt = table.Column<DateTime>(type: "timestamp with time zone", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Users", x => x.Id);
                });

            migrationBuilder.CreateTable(
                name: "Products",
                columns: table => new
                {
                    Id = table.Column<string>(type: "character varying(50)", maxLength: 50, nullable: false),
                    Name = table.Column<string>(type: "character varying(100)", maxLength: 100, nullable: false),
                    Description = table.Column<string>(type: "character varying(500)", maxLength: 500, nullable: false),
                    ImageUrl = table.Column<string>(type: "character varying(255)", maxLength: 255, nullable: false),
                    Price = table.Column<float>(type: "REAL", nullable: false),
                    CategoryId = table.Column<int>(type: "integer", nullable: false),
                    PrepTimeMinutes = table.Column<int>(type: "integer", nullable: false),
                    IsAvailable = table.Column<bool>(type: "boolean", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Products", x => x.Id);
                    table.ForeignKey(
                        name: "FK_Products_Categories_CategoryId",
                        column: x => x.CategoryId,
                        principalTable: "Categories",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Restrict);
                });

            migrationBuilder.CreateTable(
                name: "Addresses",
                columns: table => new
                {
                    Id = table.Column<string>(type: "character varying(50)", maxLength: 50, nullable: false),
                    UserId = table.Column<string>(type: "character varying(50)", maxLength: 50, nullable: false),
                    Label = table.Column<string>(type: "character varying(50)", maxLength: 50, nullable: false),
                    Street = table.Column<string>(type: "character varying(100)", maxLength: 100, nullable: false),
                    Number = table.Column<string>(type: "character varying(20)", maxLength: 20, nullable: false),
                    Complement = table.Column<string>(type: "character varying(50)", maxLength: 50, nullable: false),
                    Neighborhood = table.Column<string>(type: "character varying(50)", maxLength: 50, nullable: false),
                    City = table.Column<string>(type: "character varying(50)", maxLength: 50, nullable: false),
                    State = table.Column<string>(type: "character varying(2)", maxLength: 2, nullable: false),
                    ZipCode = table.Column<string>(type: "character varying(10)", maxLength: 10, nullable: false),
                    Latitude = table.Column<double>(type: "double precision", nullable: false),
                    Longitude = table.Column<double>(type: "double precision", nullable: false),
                    IsDefault = table.Column<bool>(type: "boolean", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Addresses", x => x.Id);
                    table.ForeignKey(
                        name: "FK_Addresses_Users_UserId",
                        column: x => x.UserId,
                        principalTable: "Users",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "CartItems",
                columns: table => new
                {
                    Id = table.Column<string>(type: "character varying(50)", maxLength: 50, nullable: false),
                    UserId = table.Column<string>(type: "character varying(50)", maxLength: 50, nullable: false),
                    ProductId = table.Column<string>(type: "character varying(50)", maxLength: 50, nullable: false),
                    Quantity = table.Column<int>(type: "integer", nullable: false),
                    SelectedCustomizationsJson = table.Column<string>(type: "character varying(2000)", maxLength: 2000, nullable: false, defaultValue: "{}"),
                    Notes = table.Column<string>(type: "character varying(500)", maxLength: 500, nullable: false),
                    CreatedAt = table.Column<DateTime>(type: "timestamp with time zone", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_CartItems", x => x.Id);
                    table.ForeignKey(
                        name: "FK_CartItems_Products_ProductId",
                        column: x => x.ProductId,
                        principalTable: "Products",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Restrict);
                    table.ForeignKey(
                        name: "FK_CartItems_Users_UserId",
                        column: x => x.UserId,
                        principalTable: "Users",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "CustomizationOptions",
                columns: table => new
                {
                    Id = table.Column<string>(type: "character varying(50)", maxLength: 50, nullable: false),
                    ProductId = table.Column<string>(type: "character varying(50)", maxLength: 50, nullable: false),
                    Name = table.Column<string>(type: "character varying(50)", maxLength: 50, nullable: false),
                    IsRequired = table.Column<bool>(type: "boolean", nullable: false),
                    AllowMultiple = table.Column<bool>(type: "boolean", nullable: false),
                    SortOrder = table.Column<int>(type: "integer", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_CustomizationOptions", x => x.Id);
                    table.ForeignKey(
                        name: "FK_CustomizationOptions_Products_ProductId",
                        column: x => x.ProductId,
                        principalTable: "Products",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "Orders",
                columns: table => new
                {
                    Id = table.Column<string>(type: "character varying(50)", maxLength: 50, nullable: false),
                    UserId = table.Column<string>(type: "character varying(50)", maxLength: 50, nullable: false),
                    DeliveryAddressId = table.Column<string>(type: "character varying(50)", maxLength: 50, nullable: false),
                    PaymentMethod = table.Column<int>(type: "integer", nullable: false),
                    Status = table.Column<int>(type: "integer", nullable: false),
                    Subtotal = table.Column<float>(type: "REAL", nullable: false),
                    DeliveryFee = table.Column<float>(type: "REAL", nullable: false),
                    Notes = table.Column<string>(type: "character varying(500)", maxLength: 500, nullable: false),
                    CreatedAt = table.Column<DateTime>(type: "timestamp with time zone", nullable: false),
                    EstimatedDeliveryTime = table.Column<DateTime>(type: "timestamp with time zone", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Orders", x => x.Id);
                    table.ForeignKey(
                        name: "FK_Orders_Addresses_DeliveryAddressId",
                        column: x => x.DeliveryAddressId,
                        principalTable: "Addresses",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Restrict);
                    table.ForeignKey(
                        name: "FK_Orders_Users_UserId",
                        column: x => x.UserId,
                        principalTable: "Users",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Restrict);
                });

            migrationBuilder.CreateTable(
                name: "CustomizationChoices",
                columns: table => new
                {
                    Id = table.Column<string>(type: "character varying(50)", maxLength: 50, nullable: false),
                    OptionId = table.Column<string>(type: "character varying(50)", maxLength: 50, nullable: false),
                    Name = table.Column<string>(type: "character varying(50)", maxLength: 50, nullable: false),
                    AdditionalPrice = table.Column<double>(type: "double precision", nullable: false),
                    SortOrder = table.Column<int>(type: "integer", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_CustomizationChoices", x => x.Id);
                    table.ForeignKey(
                        name: "FK_CustomizationChoices_CustomizationOptions_OptionId",
                        column: x => x.OptionId,
                        principalTable: "CustomizationOptions",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "OrderItems",
                columns: table => new
                {
                    Id = table.Column<string>(type: "character varying(50)", maxLength: 50, nullable: false),
                    OrderId = table.Column<string>(type: "character varying(50)", maxLength: 50, nullable: false),
                    ProductId = table.Column<string>(type: "character varying(50)", maxLength: 50, nullable: false),
                    Quantity = table.Column<int>(type: "integer", nullable: false),
                    UnitPrice = table.Column<float>(type: "REAL", nullable: false),
                    CustomizationsJson = table.Column<string>(type: "character varying(2000)", maxLength: 2000, nullable: false, defaultValue: "{}"),
                    Notes = table.Column<string>(type: "character varying(500)", maxLength: 500, nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_OrderItems", x => x.Id);
                    table.ForeignKey(
                        name: "FK_OrderItems_Orders_OrderId",
                        column: x => x.OrderId,
                        principalTable: "Orders",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_OrderItems_Products_ProductId",
                        column: x => x.ProductId,
                        principalTable: "Products",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Restrict);
                });

            migrationBuilder.CreateTable(
                name: "OrderStatusTimeline",
                columns: table => new
                {
                    Id = table.Column<int>(type: "integer", nullable: false)
                        .Annotation("Npgsql:ValueGenerationStrategy", NpgsqlValueGenerationStrategy.IdentityByDefaultColumn),
                    OrderId = table.Column<string>(type: "character varying(50)", maxLength: 50, nullable: false),
                    Status = table.Column<int>(type: "integer", nullable: false),
                    Timestamp = table.Column<DateTime>(type: "timestamp with time zone", nullable: false),
                    Note = table.Column<string>(type: "character varying(500)", maxLength: 500, nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_OrderStatusTimeline", x => x.Id);
                    table.ForeignKey(
                        name: "FK_OrderStatusTimeline_Orders_OrderId",
                        column: x => x.OrderId,
                        principalTable: "Orders",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.InsertData(
                table: "Categories",
                columns: new[] { "Id", "DisplayName", "Name", "SortOrder" },
                values: new object[,]
                {
                    { 1, "Pizzas", "Pizza", 1 },
                    { 2, "Bebidas", "Drink", 2 },
                    { 3, "Sobremesas", "Dessert", 3 },
                    { 4, "Acompanhamentos", "Side", 4 }
                });

            migrationBuilder.InsertData(
                table: "Users",
                columns: new[] { "Id", "CreatedAt", "Email", "Name", "PasswordHash", "Phone" },
                values: new object[,]
                {
                    { "user-001", new DateTime(2024, 1, 15, 0, 0, 0, DateTimeKind.Utc), "gabriel@email.com", "Gabriel Silva", "$2a$12$hyLlmL2oqmEYNcJcYsDd7.u7l7TSVENyH/mEnTxFjxM1f1PvUSvfe", "(11) 99999-9999" },
                    { "user-002", new DateTime(2024, 2, 20, 0, 0, 0, DateTimeKind.Utc), "maria@email.com", "Maria Santos", "$2a$12$hyLlmL2oqmEYNcJcYsDd7.u7l7TSVENyH/mEnTxFjxM1f1PvUSvfe", "(11) 88888-8888" }
                });

            migrationBuilder.InsertData(
                table: "Addresses",
                columns: new[] { "Id", "City", "Complement", "IsDefault", "Label", "Latitude", "Longitude", "Neighborhood", "Number", "State", "Street", "UserId", "ZipCode" },
                values: new object[,]
                {
                    { "addr-001", "São Paulo", "Apto 45", true, "Casa", -23.5505, -46.633299999999998, "Jardim Primavera", "123", "SP", "Rua das Flores", "user-001", "01234-567" },
                    { "addr-002", "São Paulo", "Sala 1200", false, "Trabalho", -23.561299999999999, -46.656399999999998, "Bela Vista", "1000", "SP", "Av. Paulista", "user-001", "01310-100" },
                    { "addr-003", "São Paulo", "", true, "Casa", -23.555800000000001, -46.660800000000002, "Consolação", "500", "SP", "Rua Augusta", "user-002", "01305-000" }
                });

            migrationBuilder.InsertData(
                table: "Products",
                columns: new[] { "Id", "CategoryId", "Description", "ImageUrl", "IsAvailable", "Name", "PrepTimeMinutes", "Price" },
                values: new object[,]
                {
                    { "prod-001", 1, "Molho de tomate, mussarela, manjericão fresco e azeite de oliva", "🍕", true, "Pizza Margherita", 25, 42.9f },
                    { "prod-002", 1, "Molho de tomate, mussarela, pepperoni e orégano", "🍕", true, "Pizza Pepperoni", 25, 48.9f },
                    { "prod-003", 1, "Molho de tomate, mussarela, provolone, gorgonzola e parmesão", "🍕", true, "Pizza Quatro Queijos", 30, 52.9f },
                    { "prod-004", 1, "Molho de tomate, mussarela, frango desfiado, catupiry, milho e azeitonas", "🍕", true, "Pizza Frango com Catupiry", 28, 49.9f },
                    { "prod-005", 1, "Molho de tomate, mussarela, calabresa fatiada, cebola e orégano", "🍕", true, "Pizza Calabresa", 25, 44.9f },
                    { "prod-006", 1, "Molho de tomate, mussarela, presunto, ovos, cebola, azeitonas, ervilha e orégano", "🍕", false, "Pizza Portuguesa", 30, 51.9f },
                    { "prod-007", 2, "Refrigerante Coca-Cola original 2 litros", "🥤", true, "Coca-Cola 2L", 2, 12.9f },
                    { "prod-008", 2, "Refrigerante Coca-Cola Zero açúcar 2 litros", "🥤", true, "Coca-Cola Zero 2L", 2, 12.9f },
                    { "prod-009", 2, "Refrigerante Guaraná Antarctica 2 litros", "🥤", true, "Guaraná Antarctica 2L", 2, 10.9f },
                    { "prod-010", 2, "Suco natural de laranja 1 litro", "🧃", true, "Suco de Laranja 1L", 3, 14.9f },
                    { "prod-011", 2, "Água mineral sem gás 500ml", "💧", true, "Água Mineral 500ml", 1, 4.5f },
                    { "prod-012", 2, "Cerveja Heineken long neck 600ml", "🍺", true, "Cerveja Heineken 600ml", 2, 16.9f },
                    { "prod-013", 3, "Bolinho de chocolate com recheio cremoso, servido com sorvete de creme", "🍫", true, "Petit Gateau", 10, 18.9f },
                    { "prod-014", 3, "Pudim caseiro de leite condensado com calda de caramelo", "🍮", true, "Pudim de Leite Condensado", 5, 12.9f },
                    { "prod-015", 3, "Brownie de chocolate quente com bola de sorvete de creme e calda de chocolate", "🍰", true, "Brownie com Sorvete", 8, 16.9f },
                    { "prod-016", 4, "Porção grande de batatas fritas crocantes", "🍟", true, "Batata Frita Grande", 12, 18.9f },
                    { "prod-017", 4, "Anéis de cebola empanados e fritos", "🧅", true, "Onion Rings", 10, 16.9f },
                    { "prod-018", 4, "Pães de alho artesanais com queijo derretido", "🧄", true, "Pão de Alho (4 unidades)", 8, 14.9f }
                });

            migrationBuilder.InsertData(
                table: "CustomizationOptions",
                columns: new[] { "Id", "AllowMultiple", "IsRequired", "Name", "ProductId", "SortOrder" },
                values: new object[,]
                {
                    { "cust-001", false, true, "Tamanho", "prod-001", 1 },
                    { "cust-002", false, false, "Borda", "prod-001", 2 },
                    { "cust-003", true, false, "Ingredientes extras", "prod-001", 3 },
                    { "cust-004", false, true, "Tamanho", "prod-002", 1 },
                    { "cust-005", false, false, "Borda", "prod-002", 2 },
                    { "cust-006", false, true, "Tamanho", "prod-003", 1 },
                    { "cust-007", false, true, "Tamanho", "prod-004", 1 },
                    { "cust-008", false, true, "Tamanho", "prod-005", 1 },
                    { "cust-009", false, true, "Tamanho", "prod-006", 1 }
                });

            migrationBuilder.InsertData(
                table: "CustomizationChoices",
                columns: new[] { "Id", "AdditionalPrice", "Name", "OptionId", "SortOrder" },
                values: new object[,]
                {
                    { "choice-001", 0.0, "Pequena (6 fatias)", "cust-001", 1 },
                    { "choice-002", 8.0, "Média (8 fatias)", "cust-001", 2 },
                    { "choice-003", 15.0, "Grande (10 fatias)", "cust-001", 3 },
                    { "choice-004", 0.0, "Sem borda", "cust-002", 1 },
                    { "choice-005", 6.0, "Borda recheada com catupiry", "cust-002", 2 },
                    { "choice-006", 6.0, "Borda recheada com cheddar", "cust-002", 3 },
                    { "choice-007", 3.0, "Tomate seco", "cust-003", 1 },
                    { "choice-008", 2.5, "Rúcula", "cust-003", 2 },
                    { "choice-009", 3.5, "Parmesão", "cust-003", 3 },
                    { "choice-010", 2.0, "Azeitonas", "cust-003", 4 },
                    { "choice-011", 0.0, "Pequena (6 fatias)", "cust-004", 1 },
                    { "choice-012", 8.0, "Média (8 fatias)", "cust-004", 2 },
                    { "choice-013", 15.0, "Grande (10 fatias)", "cust-004", 3 },
                    { "choice-014", 0.0, "Sem borda", "cust-005", 1 },
                    { "choice-015", 6.0, "Borda recheada com catupiry", "cust-005", 2 },
                    { "choice-016", 0.0, "Pequena (6 fatias)", "cust-006", 1 },
                    { "choice-017", 8.0, "Média (8 fatias)", "cust-006", 2 },
                    { "choice-018", 15.0, "Grande (10 fatias)", "cust-006", 3 },
                    { "choice-019", 0.0, "Pequena (6 fatias)", "cust-007", 1 },
                    { "choice-020", 8.0, "Média (8 fatias)", "cust-007", 2 },
                    { "choice-021", 15.0, "Grande (10 fatias)", "cust-007", 3 },
                    { "choice-022", 0.0, "Pequena (6 fatias)", "cust-008", 1 },
                    { "choice-023", 8.0, "Média (8 fatias)", "cust-008", 2 },
                    { "choice-024", 15.0, "Grande (10 fatias)", "cust-008", 3 },
                    { "choice-025", 0.0, "Pequena (6 fatias)", "cust-009", 1 },
                    { "choice-026", 8.0, "Média (8 fatias)", "cust-009", 2 },
                    { "choice-027", 15.0, "Grande (10 fatias)", "cust-009", 3 }
                });

            migrationBuilder.CreateIndex(
                name: "IX_Addresses_UserId",
                table: "Addresses",
                column: "UserId");

            migrationBuilder.CreateIndex(
                name: "IX_CartItems_ProductId",
                table: "CartItems",
                column: "ProductId");

            migrationBuilder.CreateIndex(
                name: "IX_CartItems_UserId",
                table: "CartItems",
                column: "UserId");

            migrationBuilder.CreateIndex(
                name: "IX_CustomizationChoices_OptionId",
                table: "CustomizationChoices",
                column: "OptionId");

            migrationBuilder.CreateIndex(
                name: "IX_CustomizationOptions_ProductId",
                table: "CustomizationOptions",
                column: "ProductId");

            migrationBuilder.CreateIndex(
                name: "IX_OrderItems_OrderId",
                table: "OrderItems",
                column: "OrderId");

            migrationBuilder.CreateIndex(
                name: "IX_OrderItems_ProductId",
                table: "OrderItems",
                column: "ProductId");

            migrationBuilder.CreateIndex(
                name: "IX_Orders_DeliveryAddressId",
                table: "Orders",
                column: "DeliveryAddressId");

            migrationBuilder.CreateIndex(
                name: "IX_Orders_Status",
                table: "Orders",
                column: "Status");

            migrationBuilder.CreateIndex(
                name: "IX_Orders_UserId",
                table: "Orders",
                column: "UserId");

            migrationBuilder.CreateIndex(
                name: "IX_OrderStatusTimeline_OrderId",
                table: "OrderStatusTimeline",
                column: "OrderId");

            migrationBuilder.CreateIndex(
                name: "IX_Products_CategoryId",
                table: "Products",
                column: "CategoryId");

            migrationBuilder.CreateIndex(
                name: "IX_Users_Email",
                table: "Users",
                column: "Email",
                unique: true);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "CartItems");

            migrationBuilder.DropTable(
                name: "CustomizationChoices");

            migrationBuilder.DropTable(
                name: "OrderItems");

            migrationBuilder.DropTable(
                name: "OrderStatusTimeline");

            migrationBuilder.DropTable(
                name: "CustomizationOptions");

            migrationBuilder.DropTable(
                name: "Orders");

            migrationBuilder.DropTable(
                name: "Products");

            migrationBuilder.DropTable(
                name: "Addresses");

            migrationBuilder.DropTable(
                name: "Categories");

            migrationBuilder.DropTable(
                name: "Users");
        }
    }
}
