//
//  CameraView.swift
//  Scan2Cook
//
//  Created by Kevin Dallian on 23/06/23.
//

import SwiftUI

struct CameraPreviewView: View {
    @EnvironmentObject var scanViewModel : ScanViewModel
    @StateObject var cameraModel = CameraModel()
    @State var navigateNextView = false
    @State var cameraPreviewNavigation : CameraPreviewNavigation?
    var body: some View {
        NavigationStack{
            ZStack{
                Color.black
                    .opacity(0.8)
                    .ignoresSafeArea()
                VStack{
                    CameraPreview(camera: cameraModel)
                        .ignoresSafeArea()
                        .cornerRadius(24)
                    VStack{
                         if cameraModel.cameraState == .cameraInitialized {
                             VStack{
                                 Button {
                                     cameraPreviewNavigation = .education
                                     navigateNextView.toggle()
                                 } label: {
                                     Text("Gimana cara pakenya sii?")
                                         .foregroundColor(Color.white)
                                 }

                                 Button(action: cameraModel.takePicture) {
                                     ZStack{
                                         Circle()
                                             .fill(Color.white)
                                             .frame(width: 80, height: 80)
                                         Circle()
                                             .stroke(Color.white, lineWidth: 4)
                                             .frame(width: 96, height: 96)
                                     }
                                 }
                             }.frame(height: 180)
                        } else if cameraModel.cameraState == .photoTaken {
                            VStack{
                                Button(action: cameraModel.retakePicture) {
                                    Text("Memproses")
                                        .foregroundColor(.white)
                                        .multilineTextAlignment(.trailing)
                                        .font(.body)
                                }
                            }.frame(height: 180)
                            
                        } else {
                            HStack{
                                Spacer()
                                Button {
                                    cameraModel.objectsDetected = nil
                                    cameraModel.retakePicture()
                                } label: {
                                    Image(systemName: "arrow.uturn.left.circle.fill")
                                        .foregroundColor(.white)
                                        .font(.system(size: 56))
                                }
                                Spacer()
                                VStack{
                                    Text("\(cameraModel.identifiedIngredients.count)")
                                        .font(.title)
                                        .fontWeight(.bold)
                                        .foregroundColor(.white)
                                    Text("Bahan Ditemukan")
                                        .font(.body)
                                        .foregroundColor(.white)
                                }
                                Spacer()
                                Button {
                                    scanViewModel.setSelectedIngredients(ingredients: cameraModel.identifiedIngredients)
                                    scanViewModel.setImage(image: cameraModel.processedImage)
                                    cameraPreviewNavigation = .scanResult
                                    navigateNextView.toggle()
                                } label: {
                                    Image(systemName: "checkmark.circle.fill")
                                        .foregroundColor(Color.white)
                                        .font(.system(size: 56))
                                }
                                Spacer()
                                
                            }.frame(height: 180)
                        }
                    }
                }
            }
            .onAppear {
                cameraModel.checkPermission()
            }
            .navigationDestination(isPresented: $navigateNextView) {
                if cameraPreviewNavigation == .education {
                    EducationView()
                }else {
                    ScanResultView()
                        .environmentObject(scanViewModel)
                }
                
            }
        }
    }
}

struct CameraPreviewView_Previews: PreviewProvider {
    static var previews: some View {
        CameraPreviewView(cameraModel: CameraModel())
            .environmentObject(ScanViewModel())
    }
}

enum CameraPreviewNavigation{
    case scanResult
    case education
}
