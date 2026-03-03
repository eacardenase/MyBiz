import Fluent

struct CreateProduct: Migration {
    func prepare(on database: any Database) -> EventLoopFuture<Void> {
        database.schema(Product.schema)
            .id()
            .field("name", .string, .required)
            .field("unitPrice", .double, .required)
            .create()
    }

    func revert(on database: any Database) -> EventLoopFuture<Void> {
        database.schema(Announcement.schema).delete()
    }
}
