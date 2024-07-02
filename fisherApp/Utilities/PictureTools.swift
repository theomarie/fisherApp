//
//  SavePicture.swift
//  fisherApp
//
//  Created by Theo Marie on 01/07/2024.
//

import Foundation
import SwiftUI

func saveImage(_ image: UIImage) -> String? {
    guard let data = image.jpegData(compressionQuality: 0.8) else { return nil }
    let filename = UUID().uuidString + ".jpg"
    let fileManager = FileManager.default
    do {
        let documentDirectory = try fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        let fileURL = documentDirectory.appendingPathComponent(filename)
        try data.write(to: fileURL)
        return filename  // Retourne juste le nom du fichier
    } catch {
        print("Error saving file:", error)
        return nil
    }
}

func loadImage(from urlString: String) -> UIImage? {
    guard let url = URL(string: urlString) else {
        print("Invalid URL string")
        return nil
    }
    
    // Vérifier si l'URL est déjà un chemin de fichier local
    if url.isFileURL {
        do {
            let data = try Data(contentsOf: url)
            return UIImage(data: data)
        } catch {
            print("Error loading image from file: \(error)")
            return nil
        }
    } else {
        // Si ce n'est pas un chemin de fichier, essayez de construire le chemin local
        let fileManager = FileManager.default
        do {
            let documentDirectory = try fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            let fileURL = documentDirectory.appendingPathComponent(url.lastPathComponent)
            let data = try Data(contentsOf: fileURL)
            return UIImage(data: data)
        } catch {
            print("Error loading image from local path: \(error)")
            return nil
        }
    }
}

func pictureModelToImage(entryImage: String) -> UIImage {
    if let outputImage = loadImage(from: entryImage) {
        return outputImage
    } else {
        return UIImage(named: entryImage) ?? UIImage(systemName: "picture")!
    }
   
}
