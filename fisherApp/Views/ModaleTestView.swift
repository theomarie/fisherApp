//
//  ModaleTestView.swift
//  fisherApp
//
//  Created by Theo Marie on 26/06/2024.
//

import SwiftUI

struct ModaleTestView: View {
        @State private var showCamera = false
    @State var selectedImage: UIImage?


        var body: some View {
            Button(action: {
                self.showCamera.toggle()
            }) {
                Text("Show Modal View")
            }.fullScreenCover(isPresented: $showCamera) {
                accessCameraView(selectedImage: self.$selectedImage)


            }
        }
    }

#Preview {
    ModaleTestView()
}
