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
            CachedAsyncImage(url: photo.urls.regular, transaction: Transaction(animation: .easeInOut)) { phase in
                switch phase {
                case .empty, .failure:
                    Rectangle()
                        .foregroundColor(.clear)
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                @unknown default:
                    Rectangle()
                        .foregroundColor(.clear)
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
            NavigationStack {
                PhotoInfoSheet(photo: viewModel.detailedPhoto ?? photo)
                    .navigationBarItems(
                        leading: Button("Close") { viewModel.isShowingPhotoInfoSheet = false }
                    )
            }
        }
        .alert(viewModel.error ?? "", isPresented: $viewModel.hasError) {
            Button("OK", role: .cancel) {}
        }
    }
}

#Preview {
    NavigationStack {
        PhotoDetailView(photo: .firstPhoto)
    }
    .preferredColorScheme(.dark)
}
