import Fluent

struct CreatePurchase: Migration {
    func prepare(on database: any Database) -> EventLoopFuture<Void> {
        database.schema(PurchaseOrder.schema)
            .id()
            .field("poNumber", .string, .required)
            .field("comment", .string)
            .field("purchaser", .uuid, .required)
            .field("purchaseDate", .datetime, .required)
            .field("dueDate", .datetime)
            .field("purchases", .array, .required)
            .create()
    }

    func revert(on database: any Database) -> EventLoopFuture<Void> {
        database.schema(Announcement.schema).delete()
    }
}
