// A script to shop random pictures from a folder in an iterm2 teminal session

import Foundation

let folder = ""

let fm = FileManager.default
let homeDirURL = fm.homeDirectoryForCurrentUser

let sourceFolder = homeDirURL.appending(path: folder)

let items = try fm.contentsOfDirectory(at: sourceFolder, includingPropertiesForKeys: [])

if let image = items.shuffled().filter({ $0.absoluteString.hasSuffix(".jpg") }).first,
    let name = image.pathComponents.last?.split(separator: ".").first
{
    try showImage(at: image)
    print(name)
}

func showImage(at path: URL) throws {
    let fileData = try Data(contentsOf: path)
    let base64file = String(data: fileData.base64EncodedData(), encoding: .utf8)!
    print("\u{001B}]1337;File=inline=1;width=30%;height=auto:\(base64file)\u{0007}")
}
