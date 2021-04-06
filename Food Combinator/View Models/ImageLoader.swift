//
//  ImageLoader.swift
//  Food Combinator
//
//  Created by Kobe Chang on 4/4/21.
//

import Foundation
import Combine
import SwiftUI


class ImageLoader: ObservableObject {
    @Published var image = UIImage()
    @Published var loading: Bool = false
    var urlString: String?
    var imageCache = ImageCache.getImageCache()

    init(urlString: String?) {
        self.urlString = urlString
        loadImage()
    }

    func loadImage() {
        if loadImageFromCache() {
            print("Cache hit")
            return
        }

        print("Cache miss, loading from url")
        self.loading = true
        loadImageFromUrl()
    }

    func loadImageFromCache() -> Bool {
        guard let urlString = urlString else {
            return false
        }

        guard let cacheImage = imageCache.get(forKey: urlString) else {
            return false
        }

        image = cacheImage
        return true
    }

    func loadImageFromUrl() {
        guard let urlString = urlString else {
            return
        }

        let url = URL(string: urlString)!
        let task = URLSession.shared.dataTask(with: url, completionHandler: getImageFromResponse(data:response:error:))
        task.resume()
    }


    func getImageFromResponse(data: Data?, response: URLResponse?, error: Error?) {
        guard error == nil else {
            print("Error: \(error!)")
            return
        }
        guard let data = data else {
            print("No data found")
            return
        }
        
        
        DispatchQueue.main.async {
            
            guard let loadedImage = UIImage(data: data) else {
                return
            }
            self.imageCache.set(forKey: self.urlString!, image: loadedImage)
            self.image = loadedImage
            self.loading = false // must be done on the main thread?

        }
    }
}


class ImageCache {
    var cache = NSCache<NSString, UIImage>()

    func get(forKey: String) -> UIImage? {
        return cache.object(forKey: NSString(string: forKey))
    }

    func set(forKey: String, image: UIImage) {
        cache.setObject(image, forKey: NSString(string: forKey))
    }
}

extension ImageCache {
    private static var imageCache = ImageCache()
    static func getImageCache() -> ImageCache {
        return imageCache
    }
}

struct ImageView: View {
    @ObservedObject var imageLoader:ImageLoader
    @State var loading: Bool = true

    init(withURL url:String) {
        self.imageLoader = ImageLoader(urlString:url)
    }

    var body: some View {

        if (imageLoader.loading) {
            ActivityIndicator(shouldAnimate: $loading).frame(width: 300, height: 200)
        } else {
            Image(uiImage: imageLoader.image )
                    .resizable()
                    .frame(width: 300, height: 200)
                    .scaledToFill() // <=== Saves aspect ratio
        }
    }
}
