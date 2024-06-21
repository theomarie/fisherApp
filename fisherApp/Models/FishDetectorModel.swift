//
//  FishDetectorModel.swift
//  fisherApp
//
//  Created by Theo Marie on 21/06/2024.
//

import Foundation
import CoreML
import Vision
import SwiftUI


class FishDetectorModel {
    private lazy var model: VNCoreMLModel? = {
        do {
            let fishDetector = try FishDetector(configuration: MLModelConfiguration())
            return try VNCoreMLModel(for: fishDetector.model)
        } catch {
            print("Erreur lors de l'initialisation du modèle: \(error)")
            return nil
        }
    }()
    
    // Méthode classification sur une image
    func classify(image: UIImage, completion: @escaping (String?) -> Void) {
        // Vérifier que le modèle est correctement initialisé
        guard let model = model else {
            completion(nil)
            return
        }

        // UIImage -> CVPixelBuffer
        guard let pixelBuffer = image.toCVPixelBuffer() else {
            completion(nil)
            return
        }

        // requête Core ML
        let request = VNCoreMLRequest(model: model) { request, error in
            if let results = request.results as? [VNClassificationObservation],
               let topResult = results.first {
                completion(topResult.identifier)
            } else {
                completion(nil)
            }
        }

        // Effectuer la classification
        let handler = VNImageRequestHandler(cvPixelBuffer: pixelBuffer, options: [:])
        DispatchQueue.global(qos: .userInitiated).async {
            do {
                try handler.perform([request])
            } catch {
                completion(nil)
            }
        }
    }
}
