//
//  Defines.swift
//  Runner
//
//  Created by Nikita Dauhashei on 20.03.25.
//

private var dartDefines: [String: String] = {
    let dartDefinesString = Bundle.main.object(forInfoDictionaryKey: "DART_DEFINES") as! String

    var result: [String: String] = [:]
    for keyValue in dartDefinesString.components(separatedBy: ",") {
        let decoded = String(data: Data(base64Encoded: keyValue)!, encoding: .utf8)!
        let values = decoded.components(separatedBy: "=")
        result[values[0]] = values[1]
    }

    return result
}()

class AppDefines {
    static let googleMapsAPIKey: String = dartDefines["GOOGLE_MAPS_KEY"]!
}
