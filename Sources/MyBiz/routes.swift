import Fluent
import Vapor

func routes(_ app: Application) throws {
    app.get { req async in
        "It works!"
    }

    app.get("hello") { req async -> String in
        "Hello, world!"
    }

    try app.register(collection: TodoController())
    try app.register(collection: AnnouncementsController())
    try app.register(collection: UserController())
    try app.register(collection: EmployeesController())
    try app.register(collection: EventsController())
    try app.register(collection: ProductsController())
    try app.register(collection: PurchasesController())
}
