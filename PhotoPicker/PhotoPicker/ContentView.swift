//
//  ContentView.swift
//  PhotoPicker
//
//  Created by hangeonhui on 2023/01/15.
//

import SwiftUI
import PhotosUI

struct ContentView: View {
    
    @State var isPresentPicker = false
    @State var images = [UIImage]()
    
    var body: some View {
        VStack {
            
            Button("Select Images"){
                isPresentPicker = true
            }
            List{
                ForEach(images, id:\.self){ image in
                    Image(uiImage: image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: UIScreen.main.bounds.size.width)
                        .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
                    //리스트는 왼쪽에 기본적으로 공간을 잡고있음 ( 없애기 위해서 )
                }
            }
        }
        
        .sheet(isPresented: $isPresentPicker, content: {
            ImagePicker(isPresent: $isPresentPicker, images: $images)
        })
    }
}

//이미지 픽업창 구현
struct ImagePicker: UIViewControllerRepresentable {
    
    @Binding var isPresent: Bool
    @Binding var images : [UIImage]
    
    func makeUIViewController(context: Context) -> some UIViewController {
        
        var config = PHPickerConfiguration()
        config.selectionLimit = 0
        config.filter = .images
        
        let picker = PHPickerViewController(configuration: config)
        
        //연결
        picker.delegate = context.coordinator
        
        return picker
    }
    
    class Coordinator: PHPickerViewControllerDelegate {
        var picker: ImagePicker
        
        init(picker: ImagePicker){
            self.picker = picker
        }
        
        //픽업창에서 활동
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            self.picker.isPresent = false
            
            for img in results {
                if img.itemProvider.canLoadObject(ofClass: UIImage.self){
                    img.itemProvider.loadObject(ofClass: UIImage.self) { (loadImage, err) in
                            
                        guard let loadImgs = loadImage else{
                            print("empty")
                            return
                        }
                            
                        self.picker.images.append( loadImgs as! UIImage)
                    }
                }else{
                    print("fail to loaded")
                }
            }
        }
    }
    
    //coordinator 연결
    func makeCoordinator() -> Coordinator {
        return ImagePicker.Coordinator(picker: self)
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
