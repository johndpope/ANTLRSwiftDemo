import Antlr4
import HTTP
import URI
import Vapor


func parse(input: String) throws -> String {
    let lexer = GolangLexer(ANTLRInputStream(input))
    let tokens = CommonTokenStream(lexer)
    let parser = try GolangParser(tokens)
    let tree = try parser.sourceFile()
    return tree.toStringTree(parser)
}


let drop = Droplet()

drop.get { req in
    return try drop.view.make("parser-input", [
        "originalText": "",
        "responseText": "",
        ])
}

drop.post { req in
    guard let text = req.data["text"]?.string else {
        throw Abort.badRequest
    }

    let responseText = try parse(input: text)

    return try drop.view.make("parser-input", [
        "originalText": text,
        "responseText": responseText,
        ])
}

drop.run()
