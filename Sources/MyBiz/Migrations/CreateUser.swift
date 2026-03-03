import Fluent

struct CreateUser: Migration {
    func prepare(on database: any Database) -> EventLoopFuture<Void> {
        database.schema(User.schema)
            .field("id", .uuid, .identifier(auto: true))
            .field("username", .string, .required)
            .unique(on: "username")
            .field("name", .string, .required)
            .field("passwordHash", .string, .required)
            .create()
    }

    func revert(on database: any Database) -> EventLoopFuture<Void> {
        database.schema(User.schema).delete()
    }
}
