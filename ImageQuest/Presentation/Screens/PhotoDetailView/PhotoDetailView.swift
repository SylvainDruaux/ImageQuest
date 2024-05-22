//
//  PhotoDetailView.swift
//  ImageQuest
//
//  Created by Sylvain Druaux on 05/04/2024.
//

import SwiftUI
import CachedAsyncImage

struct PhotoDetailView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject var viewModel = PhotoDetailViewModel()
    
    let photo: Photo
    
    var body: some View {
        ZStack {
            CachedAsyncImage(url: photo.urls.full, transaction: Transaction(animation: .easeInOut)) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                case .failure:
                    Image(systemName: "wifi.slash")
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                @unknown default:
                    EmptyView()
                }
            }
            .imageGesture(originalWidth: photo.width, originalHeight: photo.height)
            
            VStack {
                Spacer()
                HStack {
                    InfoButton {
                        withAnimation { viewModel.isShowingPhotoInfoSheet = true }
                    }
                    
                    Spacer()
                }
                .padding(.horizontal)
                .padding(.bottom, 36)
            }
        }
        .ignoresSafeArea()
        .navigationTitle(photo.photographer.name)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden()
        .navigationBarItems(
            leading: BackButton { dismiss() }.offset(x: -8),
            trailing: PhotoShareLink(photo: photo).offset(x: 8)
        )
        .toolbar(.hidden, for: .tabBar)
        .toolbarBackground(.hidden, for: .navigationBar)
        .task { await viewModel.loadDetailedPhoto(photo.id) }
        .sheet(isPresented: $viewModel.isShowingPhotoInfoSheet) {
            PhotoInfoSheet(photo: viewModel.detailedPhoto ?? photo, cameraPosition: viewModel.cameraPosition)
        }
        .errorAlert(alert: $viewModel.error) {
            Task { await viewModel.loadDetailedPhoto(photo.id) }
        }
    }
}

#Preview {
    NavigationStack {
        PhotoDetailView(photo: .firstPhoto)
    }
    .preferredColorScheme(.dark)
}
