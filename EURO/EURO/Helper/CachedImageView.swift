//
//  CachedImageView.swift
//  sifantasysdk
//
//  Created by Vidyasagar Kodunuri on 07/04/24.
//

import SwiftUI

class ImageCacheManager {
    static let shared = ImageCacheManager()
    
    private let cache = NSCache<NSString, UIImage>()
    
    private init() {}
    
    func getImage(forKey key: String) -> UIImage? {
        return cache.object(forKey: key as NSString)
    }
    
    func setImage(_ image: UIImage, forKey key: String) {
        cache.setObject(image, forKey: key as NSString)
    }
}

// AsyncImage with image caching
struct CachedImageView<I: View>: View {
    let placeHoldeImage: I?
    let url: String
    var imageWidth: CGFloat?
    var imageHeight: CGFloat?
    
    @State private var image: UIImage?
    @State private var isImageLoaded = false
    
    init(url: String,
         imageWidth: CGFloat? = .none,
         imageHeight: CGFloat? = .none,
         placeHoldeImage: I? = ProgressView()) {
        self.placeHoldeImage = placeHoldeImage
        self.url = url
        self.imageWidth = imageWidth
        self.imageHeight = imageHeight
    }
    
    var body: some View {
        VStack(spacing: .zero) {
            if let image = image {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .opacity(isImageLoaded ? 1.0 : 0.0)
                    .animation(.easeInOut(duration: 0.5), value: 1)
                    .onAppear(perform: { isImageLoaded = true })
                   // .background()
            } else {
                if let placeHoldeImage = placeHoldeImage as? Image {
                    placeHoldeImage
                        .resizable()
                } else {
                    if let placeHolderImage = placeHoldeImage {
                        placeHolderImage
                    }
                }
            }
        }
        .frame(width: imageWidth,
               height: imageHeight)
        .onAppear(perform: loadImage)
    }
    
    private func loadImage() {
        if let cachedImage = ImageCacheManager.shared.getImage(forKey: url) {
            image = cachedImage
            return
        }
        
        if let imageUrl = URL(string: url) {
            URLSession.shared.dataTask(with: imageUrl) { data, _, error in
                if let data = data, let downloadedImage = UIImage(data: data) {
                    ImageCacheManager.shared.setImage(downloadedImage, forKey: url)
                    image = downloadedImage
                    withAnimation {
                        isImageLoaded = true
                    }
                }
            }.resume()
        }
    }
}
