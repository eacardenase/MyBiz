import Fluent
import FluentSQLiteDriver
import NIOSSL
import Vapor

// configures your application
public func configure(_ app: Application) async throws {
    // uncomment to serve files from /Public folder
    // app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))

    app.databases.use(DatabaseConfigurationFactory.sqlite(.file("db.sqlite")), as: .sqlite)

    app.migrations.add(CreateTodo())
    app.migrations.add(CreateUser())
    app.migrations.add(SeedUsers())
    app.migrations.add(CreateToken())

    app.migrations.add(CreateAnnouncement())
    app.migrations.add(SeedAnnouncements())
    app.migrations.add(CreateEmployee())
    app.migrations.add(SeedEmployees())
    app.migrations.add(CreateEvent())
    app.migrations.add(SeedEvents())
    app.migrations.add(CreateProduct())
    app.migrations.add(SeedProducts())
    app.migrations.add(CreatePurchase())
    app.migrations.add(SeedPurchases())

    // register routes
    try routes(app)
}
