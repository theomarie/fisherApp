//
//  AnalyseView.swift
//  fisherApp
//
//  Created by Theo Marie on 20/06/2024.
//

import SwiftUI
import CoreML
import os.log


struct AnalyseView: View {
    @Binding var fishImg: UIImage?
    @State private var classificationResult: String? = nil
    
    private let fishDetector = FishDetectorModel()

    var body: some View {
        VStack {
            Text(classificationResult ?? "Classification en cours...")
                .padding()

            if let fishImg {
                Image(uiImage: fishImg)
                    .resizable()
                    .scaledToFit()
                    .onAppear {
                        classifyImage(image: fishImg)
                    }
            }
        }
    }
    
    private func classifyImage(image: UIImage) {
        fishDetector.classify(image: image) { result in
            DispatchQueue.main.async {
                if let result = result {
                    classificationResult = "Résultat: \(result)"
                } else {
                    classificationResult = "Impossible de classifier l'image"
                }
            }
        }
    }
}

#Preview {
    AnalyseView(fishImg: .constant(UIImage(named: "image1")))
}
