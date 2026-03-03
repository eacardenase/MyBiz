import Fluent

struct CreateAnnouncement: Migration {
    func prepare(on database: any Database) -> EventLoopFuture<Void> {
        database.schema(Announcement.schema)
            .id()
            .field("message", .string, .required)
            .create()
    }

    func revert(on database: any Database) -> EventLoopFuture<Void> {
        database.schema(Announcement.schema).delete()
    }
}
