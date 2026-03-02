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
    app.migrations.add(CreateUsers())
    app.migrations.add(SeedUsers())
    app.migrations.add(CreateTokens())

    app.migrations.add(CreateAnnouncements())
    app.migrations.add(SeedAnnouncements())
    app.migrations.add(CreateEmployees())
    app.migrations.add(SeedEmployees())
    app.migrations.add(CreateEvents())
    app.migrations.add(SeedEvents())
    app.migrations.add(CreateProducts())
    app.migrations.add(SeedProducts())
    app.migrations.add(CreatePurchases())
    app.migrations.add(SeedPurchases())

    // register routes
    try routes(app)
}
