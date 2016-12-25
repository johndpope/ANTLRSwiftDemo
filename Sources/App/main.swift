import HTTP
import URI
import Vapor


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

    return try drop.view.make("parser-input", [
        "originalText": text,
        "responseText": text,
        ])
}

drop.run()
