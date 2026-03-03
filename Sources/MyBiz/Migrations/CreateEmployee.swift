import Fluent

struct CreateEmployee: Migration {
    func prepare(on database: any Database) -> EventLoopFuture<Void> {
        database.schema(Employee.schema)
            .id()
            .field("givenName", .string, .required)
            .field("familyName", .string, .required)
            .field("location", .string, .required)
            .field("manager", .uuid)
            .field("directReports", .array, .required)
            .field("birthday", .string, .required)
            .create()
    }

    func revert(on database: any Database) -> EventLoopFuture<Void> {
        database.schema(Employee.schema).delete()
    }
}
