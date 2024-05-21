//
//  PhotosSearchResult.swift
//  ImageQuest
//
//  Created by Sylvain Druaux on 06/04/2024.
//

import SwiftUI
import CachedAsyncImage
import LazyCollectionView

struct PhotosSearchResult: View {
    @EnvironmentObject private var coordinator: Coordinator
    @StateObject var viewModel: DiscoverPhotosViewModel
    
    var body: some View {
        GeometryReader { geometryProxy in
            ScrollView {
                let photos = viewModel.photos
                LazyCollectionView(
                    data: photos,
                    layout: viewModel.photosLayout,
                    parentFrame: geometryProxy.frame(in: .local)
                ) { photo in
                    CachedAsyncImage(url: photo.urls.small, transaction: Transaction(animation: .easeInOut)) { phase in
                        switch phase {
                        case .empty, .failure:
                            Rectangle()
                                .foregroundColor(.clear)
                        case .success(let image):
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .photoOverlay(name: photo.photographer.name)
                                .onTapGesture {
                                    coordinator.discoverNavigation.append(.photoDetail(photo: photo))
                                }
                        @unknown default:
                            Rectangle()
                                .foregroundColor(.clear)
                        }
                    }
                    .task {
                        if photo.id == photos.last?.id {
                            await viewModel.loadPhotosNamed(query: viewModel.searchText)
                        }
                    }
                }
            }
        }
        .scrollDismissesKeyboard(.immediately)
        .background(Color.black)
    }
}

#Preview {
    PhotosSearchResult(viewModel: DiscoverPhotosViewModel())
}
