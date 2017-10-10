import UIKit

// https://stackoverflow.com/a/39673994/22470
public extension String {
    func contentsOrBlank()->String {
        if let path = Bundle.main.path(forResource:self , ofType: nil) {
            do {
                let text = try String(contentsOfFile:path, encoding: String.Encoding.utf8)
                return text
            } catch { print("Failed to read text from bundle file \(self)") }
        } else { print("Failed to load file from bundle \(self)") }
        return ""
    }
}
