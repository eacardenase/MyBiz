import Fluent

struct CreateEvent: Migration {
    func prepare(on database: any Database) -> EventLoopFuture<Void> {
        database.schema(Event.schema)
            .id()
            .field("name", .string, .required)
            .field("date", .datetime, .required)
            .field("type", .string, .required)
            .field("duration", .double, .required)
            .create()
    }

    func revert(on database: any Database) -> EventLoopFuture<Void> {
        database.schema(Announcement.schema).delete()
    }
}
