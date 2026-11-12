using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace PizzariaDesktop.Data.Migrations
{
    /// <inheritdoc />
    public partial class AddCreatedAtColumns : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_addresses_users_UserId",
                table: "addresses");

            migrationBuilder.DropForeignKey(
                name: "FK_cart_items_products_ProductId",
                table: "cart_items");

            migrationBuilder.DropForeignKey(
                name: "FK_cart_items_users_UserId",
                table: "cart_items");

            migrationBuilder.DropForeignKey(
                name: "FK_customization_choices_customization_options_OptionId",
                table: "customization_choices");

            migrationBuilder.DropForeignKey(
                name: "FK_customization_options_products_ProductId",
                table: "customization_options");

            migrationBuilder.DropForeignKey(
                name: "FK_order_items_orders_OrderId",
                table: "order_items");

            migrationBuilder.DropForeignKey(
                name: "FK_order_items_products_ProductId",
                table: "order_items");

            migrationBuilder.DropForeignKey(
                name: "FK_order_status_timeline_orders_OrderId",
                table: "order_status_timeline");

            migrationBuilder.DropForeignKey(
                name: "FK_orders_addresses_DeliveryAddressId",
                table: "orders");

            migrationBuilder.DropForeignKey(
                name: "FK_orders_users_UserId",
                table: "orders");

            migrationBuilder.DropForeignKey(
                name: "FK_products_categories_CategoryId",
                table: "products");

            migrationBuilder.DropPrimaryKey(
                name: "PK_users",
                table: "users");

            migrationBuilder.DropPrimaryKey(
                name: "PK_products",
                table: "products");

            migrationBuilder.DropPrimaryKey(
                name: "PK_orders",
                table: "orders");

            migrationBuilder.DropPrimaryKey(
                name: "PK_order_status_timeline",
                table: "order_status_timeline");

            migrationBuilder.DropPrimaryKey(
                name: "PK_order_items",
                table: "order_items");

            migrationBuilder.DropPrimaryKey(
                name: "PK_customization_options",
                table: "customization_options");

            migrationBuilder.DropPrimaryKey(
                name: "PK_customization_choices",
                table: "customization_choices");

            migrationBuilder.DropPrimaryKey(
                name: "PK_categories",
                table: "categories");

            migrationBuilder.DropPrimaryKey(
                name: "PK_cart_items",
                table: "cart_items");

            migrationBuilder.DropPrimaryKey(
                name: "PK_addresses",
                table: "addresses");

            migrationBuilder.RenameColumn(
                name: "Phone",
                table: "users",
                newName: "phone");

            migrationBuilder.RenameColumn(
                name: "Name",
                table: "users",
                newName: "name");

            migrationBuilder.RenameColumn(
                name: "Email",
                table: "users",
                newName: "email");

            migrationBuilder.RenameColumn(
                name: "Id",
                table: "users",
                newName: "id");

            migrationBuilder.RenameColumn(
                name: "PasswordHash",
                table: "users",
                newName: "password_hash");

            migrationBuilder.RenameColumn(
                name: "CreatedAt",
                table: "users",
                newName: "created_at");

            migrationBuilder.RenameIndex(
                name: "IX_users_Email",
                table: "users",
                newName: "IX_users_email");

            migrationBuilder.RenameColumn(
                name: "Price",
                table: "products",
                newName: "price");

            migrationBuilder.RenameColumn(
                name: "Name",
                table: "products",
                newName: "name");

            migrationBuilder.RenameColumn(
                name: "Description",
                table: "products",
                newName: "description");

            migrationBuilder.RenameColumn(
                name: "Id",
                table: "products",
                newName: "id");

            migrationBuilder.RenameColumn(
                name: "PrepTimeMinutes",
                table: "products",
                newName: "prep_time_minutes");

            migrationBuilder.RenameColumn(
                name: "IsAvailable",
                table: "products",
                newName: "is_available");

            migrationBuilder.RenameColumn(
                name: "ImageUrl",
                table: "products",
                newName: "image_url");

            migrationBuilder.RenameColumn(
                name: "CategoryId",
                table: "products",
                newName: "category_id");

            migrationBuilder.RenameIndex(
                name: "IX_products_CategoryId",
                table: "products",
                newName: "ix_products_category_id");

            migrationBuilder.RenameColumn(
                name: "Subtotal",
                table: "orders",
                newName: "subtotal");

            migrationBuilder.RenameColumn(
                name: "Status",
                table: "orders",
                newName: "status");

            migrationBuilder.RenameColumn(
                name: "Notes",
                table: "orders",
                newName: "notes");

            migrationBuilder.RenameColumn(
                name: "Id",
                table: "orders",
                newName: "id");

            migrationBuilder.RenameColumn(
                name: "UserId",
                table: "orders",
                newName: "user_id");

            migrationBuilder.RenameColumn(
                name: "PaymentMethod",
                table: "orders",
                newName: "payment_method");

            migrationBuilder.RenameColumn(
                name: "EstimatedDeliveryTime",
                table: "orders",
                newName: "estimated_delivery_time");

            migrationBuilder.RenameColumn(
                name: "DeliveryFee",
                table: "orders",
                newName: "delivery_fee");

            migrationBuilder.RenameColumn(
                name: "DeliveryAddressId",
                table: "orders",
                newName: "delivery_address_id");

            migrationBuilder.RenameColumn(
                name: "CreatedAt",
                table: "orders",
                newName: "created_at");

            migrationBuilder.RenameIndex(
                name: "IX_orders_Status",
                table: "orders",
                newName: "IX_orders_status");

            migrationBuilder.RenameIndex(
                name: "IX_orders_UserId",
                table: "orders",
                newName: "ix_orders_user_id");

            migrationBuilder.RenameIndex(
                name: "IX_orders_DeliveryAddressId",
                table: "orders",
                newName: "ix_orders_delivery_address_id");

            migrationBuilder.RenameColumn(
                name: "Timestamp",
                table: "order_status_timeline",
                newName: "timestamp");

            migrationBuilder.RenameColumn(
                name: "Status",
                table: "order_status_timeline",
                newName: "status");

            migrationBuilder.RenameColumn(
                name: "Note",
                table: "order_status_timeline",
                newName: "note");

            migrationBuilder.RenameColumn(
                name: "Id",
                table: "order_status_timeline",
                newName: "id");

            migrationBuilder.RenameColumn(
                name: "OrderId",
                table: "order_status_timeline",
                newName: "order_id");

            migrationBuilder.RenameIndex(
                name: "IX_order_status_timeline_OrderId",
                table: "order_status_timeline",
                newName: "ix_order_status_timeline_order_id");

            migrationBuilder.RenameColumn(
                name: "Quantity",
                table: "order_items",
                newName: "quantity");

            migrationBuilder.RenameColumn(
                name: "Notes",
                table: "order_items",
                newName: "notes");

            migrationBuilder.RenameColumn(
                name: "Id",
                table: "order_items",
                newName: "id");

            migrationBuilder.RenameColumn(
                name: "UnitPrice",
                table: "order_items",
                newName: "unit_price");

            migrationBuilder.RenameColumn(
                name: "ProductId",
                table: "order_items",
                newName: "product_id");

            migrationBuilder.RenameColumn(
                name: "OrderId",
                table: "order_items",
                newName: "order_id");

            migrationBuilder.RenameColumn(
                name: "CustomizationsJson",
                table: "order_items",
                newName: "customizations_json");

            migrationBuilder.RenameIndex(
                name: "IX_order_items_ProductId",
                table: "order_items",
                newName: "ix_order_items_product_id");

            migrationBuilder.RenameIndex(
                name: "IX_order_items_OrderId",
                table: "order_items",
                newName: "ix_order_items_order_id");

            migrationBuilder.RenameColumn(
                name: "Name",
                table: "customization_options",
                newName: "name");

            migrationBuilder.RenameColumn(
                name: "Id",
                table: "customization_options",
                newName: "id");

            migrationBuilder.RenameColumn(
                name: "SortOrder",
                table: "customization_options",
                newName: "sort_order");

            migrationBuilder.RenameColumn(
                name: "ProductId",
                table: "customization_options",
                newName: "product_id");

            migrationBuilder.RenameColumn(
                name: "IsRequired",
                table: "customization_options",
                newName: "is_required");

            migrationBuilder.RenameColumn(
                name: "AllowMultiple",
                table: "customization_options",
                newName: "allow_multiple");

            migrationBuilder.RenameIndex(
                name: "IX_customization_options_ProductId",
                table: "customization_options",
                newName: "ix_customization_options_product_id");

            migrationBuilder.RenameColumn(
                name: "Name",
                table: "customization_choices",
                newName: "name");

            migrationBuilder.RenameColumn(
                name: "Id",
                table: "customization_choices",
                newName: "id");

            migrationBuilder.RenameColumn(
                name: "SortOrder",
                table: "customization_choices",
                newName: "sort_order");

            migrationBuilder.RenameColumn(
                name: "OptionId",
                table: "customization_choices",
                newName: "option_id");

            migrationBuilder.RenameColumn(
                name: "AdditionalPrice",
                table: "customization_choices",
                newName: "additional_price");

            migrationBuilder.RenameIndex(
                name: "IX_customization_choices_OptionId",
                table: "customization_choices",
                newName: "ix_customization_choices_option_id");

            migrationBuilder.RenameColumn(
                name: "Name",
                table: "categories",
                newName: "name");

            migrationBuilder.RenameColumn(
                name: "Id",
                table: "categories",
                newName: "id");

            migrationBuilder.RenameColumn(
                name: "SortOrder",
                table: "categories",
                newName: "sort_order");

            migrationBuilder.RenameColumn(
                name: "DisplayName",
                table: "categories",
                newName: "display_name");

            migrationBuilder.RenameColumn(
                name: "Quantity",
                table: "cart_items",
                newName: "quantity");

            migrationBuilder.RenameColumn(
                name: "Notes",
                table: "cart_items",
                newName: "notes");

            migrationBuilder.RenameColumn(
                name: "Id",
                table: "cart_items",
                newName: "id");

            migrationBuilder.RenameColumn(
                name: "UserId",
                table: "cart_items",
                newName: "user_id");

            migrationBuilder.RenameColumn(
                name: "SelectedCustomizationsJson",
                table: "cart_items",
                newName: "selected_customizations_json");

            migrationBuilder.RenameColumn(
                name: "ProductId",
                table: "cart_items",
                newName: "product_id");

            migrationBuilder.RenameColumn(
                name: "CreatedAt",
                table: "cart_items",
                newName: "created_at");

            migrationBuilder.RenameIndex(
                name: "IX_cart_items_UserId",
                table: "cart_items",
                newName: "ix_cart_items_user_id");

            migrationBuilder.RenameIndex(
                name: "IX_cart_items_ProductId",
                table: "cart_items",
                newName: "ix_cart_items_product_id");

            migrationBuilder.RenameColumn(
                name: "Street",
                table: "addresses",
                newName: "street");

            migrationBuilder.RenameColumn(
                name: "State",
                table: "addresses",
                newName: "state");

            migrationBuilder.RenameColumn(
                name: "Number",
                table: "addresses",
                newName: "number");

            migrationBuilder.RenameColumn(
                name: "Neighborhood",
                table: "addresses",
                newName: "neighborhood");

            migrationBuilder.RenameColumn(
                name: "Longitude",
                table: "addresses",
                newName: "longitude");

            migrationBuilder.RenameColumn(
                name: "Latitude",
                table: "addresses",
                newName: "latitude");

            migrationBuilder.RenameColumn(
                name: "Label",
                table: "addresses",
                newName: "label");

            migrationBuilder.RenameColumn(
                name: "Complement",
                table: "addresses",
                newName: "complement");

            migrationBuilder.RenameColumn(
                name: "City",
                table: "addresses",
                newName: "city");

            migrationBuilder.RenameColumn(
                name: "Id",
                table: "addresses",
                newName: "id");

            migrationBuilder.RenameColumn(
                name: "ZipCode",
                table: "addresses",
                newName: "zip_code");

            migrationBuilder.RenameColumn(
                name: "UserId",
                table: "addresses",
                newName: "user_id");

            migrationBuilder.RenameColumn(
                name: "IsDefault",
                table: "addresses",
                newName: "is_default");

            migrationBuilder.RenameIndex(
                name: "IX_addresses_UserId",
                table: "addresses",
                newName: "ix_addresses_user_id");

            migrationBuilder.AddPrimaryKey(
                name: "pk_users",
                table: "users",
                column: "id");

            migrationBuilder.AddPrimaryKey(
                name: "pk_products",
                table: "products",
                column: "id");

            migrationBuilder.AddPrimaryKey(
                name: "pk_orders",
                table: "orders",
                column: "id");

            migrationBuilder.AddPrimaryKey(
                name: "pk_order_status_timeline",
                table: "order_status_timeline",
                column: "id");

            migrationBuilder.AddPrimaryKey(
                name: "pk_order_items",
                table: "order_items",
                column: "id");

            migrationBuilder.AddPrimaryKey(
                name: "pk_customization_options",
                table: "customization_options",
                column: "id");

            migrationBuilder.AddPrimaryKey(
                name: "pk_customization_choices",
                table: "customization_choices",
                column: "id");

            migrationBuilder.AddPrimaryKey(
                name: "pk_categories",
                table: "categories",
                column: "id");

            migrationBuilder.AddPrimaryKey(
                name: "pk_cart_items",
                table: "cart_items",
                column: "id");

            migrationBuilder.AddPrimaryKey(
                name: "pk_addresses",
                table: "addresses",
                column: "id");

            migrationBuilder.UpdateData(
                table: "users",
                keyColumn: "id",
                keyValue: "user-001",
                column: "password_hash",
                value: "$2a$12$InmFpASoCzJMs92O3LxN3ej56dONhqY9qfmEQ9VJn6vsiQFp.jkFG");

            migrationBuilder.UpdateData(
                table: "users",
                keyColumn: "id",
                keyValue: "user-002",
                column: "password_hash",
                value: "$2a$12$InmFpASoCzJMs92O3LxN3ej56dONhqY9qfmEQ9VJn6vsiQFp.jkFG");

            migrationBuilder.AddForeignKey(
                name: "fk_addresses_users_user_id",
                table: "addresses",
                column: "user_id",
                principalTable: "users",
                principalColumn: "id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "fk_cart_items_products_product_id",
                table: "cart_items",
                column: "product_id",
                principalTable: "products",
                principalColumn: "id",
                onDelete: ReferentialAction.Restrict);

            migrationBuilder.AddForeignKey(
                name: "fk_cart_items_users_user_id",
                table: "cart_items",
                column: "user_id",
                principalTable: "users",
                principalColumn: "id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "fk_customization_choices_customization_options_option_id",
                table: "customization_choices",
                column: "option_id",
                principalTable: "customization_options",
                principalColumn: "id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "fk_customization_options_products_product_id",
                table: "customization_options",
                column: "product_id",
                principalTable: "products",
                principalColumn: "id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "fk_order_items_orders_order_id",
                table: "order_items",
                column: "order_id",
                principalTable: "orders",
                principalColumn: "id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "fk_order_items_products_product_id",
                table: "order_items",
                column: "product_id",
                principalTable: "products",
                principalColumn: "id",
                onDelete: ReferentialAction.Restrict);

            migrationBuilder.AddForeignKey(
                name: "fk_order_status_timeline_orders_order_id",
                table: "order_status_timeline",
                column: "order_id",
                principalTable: "orders",
                principalColumn: "id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "fk_orders_addresses_delivery_address_id",
                table: "orders",
                column: "delivery_address_id",
                principalTable: "addresses",
                principalColumn: "id",
                onDelete: ReferentialAction.Restrict);

            migrationBuilder.AddForeignKey(
                name: "fk_orders_users_user_id",
                table: "orders",
                column: "user_id",
                principalTable: "users",
                principalColumn: "id",
                onDelete: ReferentialAction.Restrict);

            migrationBuilder.AddForeignKey(
                name: "fk_products_categories_category_id",
                table: "products",
                column: "category_id",
                principalTable: "categories",
                principalColumn: "id",
                onDelete: ReferentialAction.Restrict);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "fk_addresses_users_user_id",
                table: "addresses");

            migrationBuilder.DropForeignKey(
                name: "fk_cart_items_products_product_id",
                table: "cart_items");

            migrationBuilder.DropForeignKey(
                name: "fk_cart_items_users_user_id",
                table: "cart_items");

            migrationBuilder.DropForeignKey(
                name: "fk_customization_choices_customization_options_option_id",
                table: "customization_choices");

            migrationBuilder.DropForeignKey(
                name: "fk_customization_options_products_product_id",
                table: "customization_options");

            migrationBuilder.DropForeignKey(
                name: "fk_order_items_orders_order_id",
                table: "order_items");

            migrationBuilder.DropForeignKey(
                name: "fk_order_items_products_product_id",
                table: "order_items");

            migrationBuilder.DropForeignKey(
                name: "fk_order_status_timeline_orders_order_id",
                table: "order_status_timeline");

            migrationBuilder.DropForeignKey(
                name: "fk_orders_addresses_delivery_address_id",
                table: "orders");

            migrationBuilder.DropForeignKey(
                name: "fk_orders_users_user_id",
                table: "orders");

            migrationBuilder.DropForeignKey(
                name: "fk_products_categories_category_id",
                table: "products");

            migrationBuilder.DropPrimaryKey(
                name: "pk_users",
                table: "users");

            migrationBuilder.DropPrimaryKey(
                name: "pk_products",
                table: "products");

            migrationBuilder.DropPrimaryKey(
                name: "pk_orders",
                table: "orders");

            migrationBuilder.DropPrimaryKey(
                name: "pk_order_status_timeline",
                table: "order_status_timeline");

            migrationBuilder.DropPrimaryKey(
                name: "pk_order_items",
                table: "order_items");

            migrationBuilder.DropPrimaryKey(
                name: "pk_customization_options",
                table: "customization_options");

            migrationBuilder.DropPrimaryKey(
                name: "pk_customization_choices",
                table: "customization_choices");

            migrationBuilder.DropPrimaryKey(
                name: "pk_categories",
                table: "categories");

            migrationBuilder.DropPrimaryKey(
                name: "pk_cart_items",
                table: "cart_items");

            migrationBuilder.DropPrimaryKey(
                name: "pk_addresses",
                table: "addresses");

            migrationBuilder.RenameColumn(
                name: "phone",
                table: "users",
                newName: "Phone");

            migrationBuilder.RenameColumn(
                name: "name",
                table: "users",
                newName: "Name");

            migrationBuilder.RenameColumn(
                name: "email",
                table: "users",
                newName: "Email");

            migrationBuilder.RenameColumn(
                name: "id",
                table: "users",
                newName: "Id");

            migrationBuilder.RenameColumn(
                name: "password_hash",
                table: "users",
                newName: "PasswordHash");

            migrationBuilder.RenameColumn(
                name: "created_at",
                table: "users",
                newName: "CreatedAt");

            migrationBuilder.RenameIndex(
                name: "IX_users_email",
                table: "users",
                newName: "IX_users_Email");

            migrationBuilder.RenameColumn(
                name: "price",
                table: "products",
                newName: "Price");

            migrationBuilder.RenameColumn(
                name: "name",
                table: "products",
                newName: "Name");

            migrationBuilder.RenameColumn(
                name: "description",
                table: "products",
                newName: "Description");

            migrationBuilder.RenameColumn(
                name: "id",
                table: "products",
                newName: "Id");

            migrationBuilder.RenameColumn(
                name: "prep_time_minutes",
                table: "products",
                newName: "PrepTimeMinutes");

            migrationBuilder.RenameColumn(
                name: "is_available",
                table: "products",
                newName: "IsAvailable");

            migrationBuilder.RenameColumn(
                name: "image_url",
                table: "products",
                newName: "ImageUrl");

            migrationBuilder.RenameColumn(
                name: "category_id",
                table: "products",
                newName: "CategoryId");

            migrationBuilder.RenameIndex(
                name: "ix_products_category_id",
                table: "products",
                newName: "IX_products_CategoryId");

            migrationBuilder.RenameColumn(
                name: "subtotal",
                table: "orders",
                newName: "Subtotal");

            migrationBuilder.RenameColumn(
                name: "status",
                table: "orders",
                newName: "Status");

            migrationBuilder.RenameColumn(
                name: "notes",
                table: "orders",
                newName: "Notes");

            migrationBuilder.RenameColumn(
                name: "id",
                table: "orders",
                newName: "Id");

            migrationBuilder.RenameColumn(
                name: "user_id",
                table: "orders",
                newName: "UserId");

            migrationBuilder.RenameColumn(
                name: "payment_method",
                table: "orders",
                newName: "PaymentMethod");

            migrationBuilder.RenameColumn(
                name: "estimated_delivery_time",
                table: "orders",
                newName: "EstimatedDeliveryTime");

            migrationBuilder.RenameColumn(
                name: "delivery_fee",
                table: "orders",
                newName: "DeliveryFee");

            migrationBuilder.RenameColumn(
                name: "delivery_address_id",
                table: "orders",
                newName: "DeliveryAddressId");

            migrationBuilder.RenameColumn(
                name: "created_at",
                table: "orders",
                newName: "CreatedAt");

            migrationBuilder.RenameIndex(
                name: "IX_orders_status",
                table: "orders",
                newName: "IX_orders_Status");

            migrationBuilder.RenameIndex(
                name: "ix_orders_user_id",
                table: "orders",
                newName: "IX_orders_UserId");

            migrationBuilder.RenameIndex(
                name: "ix_orders_delivery_address_id",
                table: "orders",
                newName: "IX_orders_DeliveryAddressId");

            migrationBuilder.RenameColumn(
                name: "timestamp",
                table: "order_status_timeline",
                newName: "Timestamp");

            migrationBuilder.RenameColumn(
                name: "status",
                table: "order_status_timeline",
                newName: "Status");

            migrationBuilder.RenameColumn(
                name: "note",
                table: "order_status_timeline",
                newName: "Note");

            migrationBuilder.RenameColumn(
                name: "id",
                table: "order_status_timeline",
                newName: "Id");

            migrationBuilder.RenameColumn(
                name: "order_id",
                table: "order_status_timeline",
                newName: "OrderId");

            migrationBuilder.RenameIndex(
                name: "ix_order_status_timeline_order_id",
                table: "order_status_timeline",
                newName: "IX_order_status_timeline_OrderId");

            migrationBuilder.RenameColumn(
                name: "quantity",
                table: "order_items",
                newName: "Quantity");

            migrationBuilder.RenameColumn(
                name: "notes",
                table: "order_items",
                newName: "Notes");

            migrationBuilder.RenameColumn(
                name: "id",
                table: "order_items",
                newName: "Id");

            migrationBuilder.RenameColumn(
                name: "unit_price",
                table: "order_items",
                newName: "UnitPrice");

            migrationBuilder.RenameColumn(
                name: "product_id",
                table: "order_items",
                newName: "ProductId");

            migrationBuilder.RenameColumn(
                name: "order_id",
                table: "order_items",
                newName: "OrderId");

            migrationBuilder.RenameColumn(
                name: "customizations_json",
                table: "order_items",
                newName: "CustomizationsJson");

            migrationBuilder.RenameIndex(
                name: "ix_order_items_product_id",
                table: "order_items",
                newName: "IX_order_items_ProductId");

            migrationBuilder.RenameIndex(
                name: "ix_order_items_order_id",
                table: "order_items",
                newName: "IX_order_items_OrderId");

            migrationBuilder.RenameColumn(
                name: "name",
                table: "customization_options",
                newName: "Name");

            migrationBuilder.RenameColumn(
                name: "id",
                table: "customization_options",
                newName: "Id");

            migrationBuilder.RenameColumn(
                name: "sort_order",
                table: "customization_options",
                newName: "SortOrder");

            migrationBuilder.RenameColumn(
                name: "product_id",
                table: "customization_options",
                newName: "ProductId");

            migrationBuilder.RenameColumn(
                name: "is_required",
                table: "customization_options",
                newName: "IsRequired");

            migrationBuilder.RenameColumn(
                name: "allow_multiple",
                table: "customization_options",
                newName: "AllowMultiple");

            migrationBuilder.RenameIndex(
                name: "ix_customization_options_product_id",
                table: "customization_options",
                newName: "IX_customization_options_ProductId");

            migrationBuilder.RenameColumn(
                name: "name",
                table: "customization_choices",
                newName: "Name");

            migrationBuilder.RenameColumn(
                name: "id",
                table: "customization_choices",
                newName: "Id");

            migrationBuilder.RenameColumn(
                name: "sort_order",
                table: "customization_choices",
                newName: "SortOrder");

            migrationBuilder.RenameColumn(
                name: "option_id",
                table: "customization_choices",
                newName: "OptionId");

            migrationBuilder.RenameColumn(
                name: "additional_price",
                table: "customization_choices",
                newName: "AdditionalPrice");

            migrationBuilder.RenameIndex(
                name: "ix_customization_choices_option_id",
                table: "customization_choices",
                newName: "IX_customization_choices_OptionId");

            migrationBuilder.RenameColumn(
                name: "name",
                table: "categories",
                newName: "Name");

            migrationBuilder.RenameColumn(
                name: "id",
                table: "categories",
                newName: "Id");

            migrationBuilder.RenameColumn(
                name: "sort_order",
                table: "categories",
                newName: "SortOrder");

            migrationBuilder.RenameColumn(
                name: "display_name",
                table: "categories",
                newName: "DisplayName");

            migrationBuilder.RenameColumn(
                name: "quantity",
                table: "cart_items",
                newName: "Quantity");

            migrationBuilder.RenameColumn(
                name: "notes",
                table: "cart_items",
                newName: "Notes");

            migrationBuilder.RenameColumn(
                name: "id",
                table: "cart_items",
                newName: "Id");

            migrationBuilder.RenameColumn(
                name: "user_id",
                table: "cart_items",
                newName: "UserId");

            migrationBuilder.RenameColumn(
                name: "selected_customizations_json",
                table: "cart_items",
                newName: "SelectedCustomizationsJson");

            migrationBuilder.RenameColumn(
                name: "product_id",
                table: "cart_items",
                newName: "ProductId");

            migrationBuilder.RenameColumn(
                name: "created_at",
                table: "cart_items",
                newName: "CreatedAt");

            migrationBuilder.RenameIndex(
                name: "ix_cart_items_user_id",
                table: "cart_items",
                newName: "IX_cart_items_UserId");

            migrationBuilder.RenameIndex(
                name: "ix_cart_items_product_id",
                table: "cart_items",
                newName: "IX_cart_items_ProductId");

            migrationBuilder.RenameColumn(
                name: "street",
                table: "addresses",
                newName: "Street");

            migrationBuilder.RenameColumn(
                name: "state",
                table: "addresses",
                newName: "State");

            migrationBuilder.RenameColumn(
                name: "number",
                table: "addresses",
                newName: "Number");

            migrationBuilder.RenameColumn(
                name: "neighborhood",
                table: "addresses",
                newName: "Neighborhood");

            migrationBuilder.RenameColumn(
                name: "longitude",
                table: "addresses",
                newName: "Longitude");

            migrationBuilder.RenameColumn(
                name: "latitude",
                table: "addresses",
                newName: "Latitude");

            migrationBuilder.RenameColumn(
                name: "label",
                table: "addresses",
                newName: "Label");

            migrationBuilder.RenameColumn(
                name: "complement",
                table: "addresses",
                newName: "Complement");

            migrationBuilder.RenameColumn(
                name: "city",
                table: "addresses",
                newName: "City");

            migrationBuilder.RenameColumn(
                name: "id",
                table: "addresses",
                newName: "Id");

            migrationBuilder.RenameColumn(
                name: "zip_code",
                table: "addresses",
                newName: "ZipCode");

            migrationBuilder.RenameColumn(
                name: "user_id",
                table: "addresses",
                newName: "UserId");

            migrationBuilder.RenameColumn(
                name: "is_default",
                table: "addresses",
                newName: "IsDefault");

            migrationBuilder.RenameIndex(
                name: "ix_addresses_user_id",
                table: "addresses",
                newName: "IX_addresses_UserId");

            migrationBuilder.AddPrimaryKey(
                name: "PK_users",
                table: "users",
                column: "Id");

            migrationBuilder.AddPrimaryKey(
                name: "PK_products",
                table: "products",
                column: "Id");

            migrationBuilder.AddPrimaryKey(
                name: "PK_orders",
                table: "orders",
                column: "Id");

            migrationBuilder.AddPrimaryKey(
                name: "PK_order_status_timeline",
                table: "order_status_timeline",
                column: "Id");

            migrationBuilder.AddPrimaryKey(
                name: "PK_order_items",
                table: "order_items",
                column: "Id");

            migrationBuilder.AddPrimaryKey(
                name: "PK_customization_options",
                table: "customization_options",
                column: "Id");

            migrationBuilder.AddPrimaryKey(
                name: "PK_customization_choices",
                table: "customization_choices",
                column: "Id");

            migrationBuilder.AddPrimaryKey(
                name: "PK_categories",
                table: "categories",
                column: "Id");

            migrationBuilder.AddPrimaryKey(
                name: "PK_cart_items",
                table: "cart_items",
                column: "Id");

            migrationBuilder.AddPrimaryKey(
                name: "PK_addresses",
                table: "addresses",
                column: "Id");

            migrationBuilder.UpdateData(
                table: "users",
                keyColumn: "Id",
                keyValue: "user-001",
                column: "PasswordHash",
                value: "$2a$12$5Ofy8luXLHdN0jUFvtinh.nHlUtsFvC9wxCIPf1ThNH2L/rpo.44q");

            migrationBuilder.UpdateData(
                table: "users",
                keyColumn: "Id",
                keyValue: "user-002",
                column: "PasswordHash",
                value: "$2a$12$5Ofy8luXLHdN0jUFvtinh.nHlUtsFvC9wxCIPf1ThNH2L/rpo.44q");

            migrationBuilder.AddForeignKey(
                name: "FK_addresses_users_UserId",
                table: "addresses",
                column: "UserId",
                principalTable: "users",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_cart_items_products_ProductId",
                table: "cart_items",
                column: "ProductId",
                principalTable: "products",
                principalColumn: "Id",
                onDelete: ReferentialAction.Restrict);

            migrationBuilder.AddForeignKey(
                name: "FK_cart_items_users_UserId",
                table: "cart_items",
                column: "UserId",
                principalTable: "users",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_customization_choices_customization_options_OptionId",
                table: "customization_choices",
                column: "OptionId",
                principalTable: "customization_options",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_customization_options_products_ProductId",
                table: "customization_options",
                column: "ProductId",
                principalTable: "products",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_order_items_orders_OrderId",
                table: "order_items",
                column: "OrderId",
                principalTable: "orders",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_order_items_products_ProductId",
                table: "order_items",
                column: "ProductId",
                principalTable: "products",
                principalColumn: "Id",
                onDelete: ReferentialAction.Restrict);

            migrationBuilder.AddForeignKey(
                name: "FK_order_status_timeline_orders_OrderId",
                table: "order_status_timeline",
                column: "OrderId",
                principalTable: "orders",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_orders_addresses_DeliveryAddressId",
                table: "orders",
                column: "DeliveryAddressId",
                principalTable: "addresses",
                principalColumn: "Id",
                onDelete: ReferentialAction.Restrict);

            migrationBuilder.AddForeignKey(
                name: "FK_orders_users_UserId",
                table: "orders",
                column: "UserId",
                principalTable: "users",
                principalColumn: "Id",
                onDelete: ReferentialAction.Restrict);

            migrationBuilder.AddForeignKey(
                name: "FK_products_categories_CategoryId",
                table: "products",
                column: "CategoryId",
                principalTable: "categories",
                principalColumn: "Id",
                onDelete: ReferentialAction.Restrict);
        }
    }
}
