//
//  DiscoverPhotosView.swift
//  ImageQuest
//
//  Created by Sylvain Druaux on 05/04/2024.
//

import SwiftUI
import CachedAsyncImage
import LazyCollectionView

struct DiscoverPhotosView: View {
    @EnvironmentObject private var coordinator: Coordinator
    @StateObject private var viewModel = DiscoverPhotosViewModel()
    
    var body: some View {
        GeometryReader { geometryProxy in
            ScrollView {
                HStack {
                    Text("Discover")
                        .font(.title2).bold()
                        .padding([.horizontal, .top])
                    Spacer()
                }
                
                LazyCollectionView(
                    data: viewModel.latestPhotos,
                    layout: viewModel.latestPhotosLayout,
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
                }
            }
        }
        .task { await viewModel.loadLatestPhotos() }
        .refreshable { await viewModel.loadLatestPhotos() }
        .searchable(
            text: $viewModel.searchText,
            placement: .navigationBarDrawer(displayMode: .always)
        )
        .onReceive(viewModel.$searchText.debounce(for: 0.8, scheduler: RunLoop.main)) { value in
            if !value.isEmpty {
                viewModel.clearPhotos()
                Task { await viewModel.loadPhotosNamed(query: value) }
            } else {
                viewModel.clearPhotos()
            }
        }
        .overlay {
            if !viewModel.searchText.isEmpty { PhotosSearchResult(viewModel: viewModel) }
        }
        .alert(viewModel.error ?? "", isPresented: $viewModel.hasError) {
            Button("OK", role: .cancel) {}
        }
    }
}

#Preview {
    NavigationStack {
        DiscoverPhotosView()
    }
    .preferredColorScheme(.dark)
}
