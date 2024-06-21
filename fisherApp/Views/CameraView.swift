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
//          NavigationLink("Analyse", destination: AnalyseView())
//                .navigationDestination(for: UIImage) { $selectedItem in
//                    AnalyseView()
//                }
        }
        }
    
}


struct accessCameraView: UIViewControllerRepresentable {
    
    @Binding var selectedImage: UIImage?
    @Environment(\.presentationMode) var isPresented
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .camera
        imagePicker.allowsEditing = true
        imagePicker.delegate = context.coordinator
        return imagePicker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(picker: self)
    }
}

// Coordinator will help to preview the selected image in the View.
class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    var picker: accessCameraView
    
    init(picker: accessCameraView) {
        self.picker = picker
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[.originalImage] as? UIImage else { return }
        self.picker.selectedImage = selectedImage
        self.picker.isPresented.wrappedValue.dismiss()
    }
}

#Preview {
    CameraView()
}
