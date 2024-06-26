//
//  CameraTestView.swift
//  fisherApp
//
//  Created by Theo Marie on 20/06/2024.
//

import SwiftUI
import PhotosUI

struct CameraView: View {
    @State private var showCamera = false
    @State var selectedImage: UIImage?

    var body: some View {
        NavigationStack {
            Button("Open camera") {
                self.showCamera.toggle()
            }
            .fullScreenCover(isPresented: self.$showCamera) {
                accessCameraView(selectedImage: self.$selectedImage)
            }
            .navigationDestination(item: $selectedImage) { image in
                AnalyseView(fishImg: $selectedImage)
            }
            /*
             NavigationLink("Analyse", destination: AnalyseView())
                        .navigationDestination(for: UIImage) { $selectedItem in
                                AnalyseView()
                            }
             */
        }
    }
    
}



#Preview {
    CameraView()
}
