//
//  ImageGesture.swift
//  ImageQuest
//
//  Created by Sylvain Druaux on 07/04/2024.
//

import SwiftUI

struct ImageGesture: ViewModifier {
    let originalWidth: Int
    let originalHeight: Int
    
    private let minZoom: CGFloat = 1.0
    @State private var screenZoom: CGFloat = 1.0
    @State private var maxZoom: CGFloat = 1.0
    
    @GestureState private var magnificationLevel: CGFloat = 1.0
    @State private var zoomLevel: CGFloat = 1.0
    @State private var dragOffset: CGSize = .zero
    @State private var position: CGSize = .zero
    
    func body(content: Content) -> some View {
        content
            .gesture(
                doubleTapGesture
            )
            .offset(x: dragOffset.width + position.width, y: dragOffset.height + position.height)
            .gesture(
                dragGesture
            )
            .scaleEffect(setZoom(magnification: magnificationLevel))
            .gesture(
                magnifyGesture
            )
            .onAppear {
                screenZoom = getScreenZoom(originalWidth: originalWidth, originalHeight: originalHeight)
                maxZoom = getMaxZoom(originalWidth: originalWidth, originalHeight: originalHeight)
            }
    }
    
    private var doubleTapGesture: some Gesture {
        TapGesture(count: 2)
            .onEnded {
                withAnimation {
                    dragOffset = .zero
                    position = .zero
                    if self.zoomLevel == 1 {
                        self.zoomLevel = setZoom(magnification: screenZoom)
                    } else {
                        self.zoomLevel = minZoom
                    }
                }
            }
    }
    
    private var dragGesture: some Gesture {
        DragGesture(minimumDistance: 0)
            .onChanged { value in
                if zoomLevel > 1 {
                    self.dragOffset = value.translation
                }
            }
            .onEnded { value in
                if zoomLevel > 1 {
                    self.position.width += value.translation.width
                    self.position.height += value.translation.height
                    self.dragOffset = .zero
                }
            }
    }
    
    private var magnifyGesture: some Gesture {
        MagnifyGesture()
            .updating($magnificationLevel) { value, state, _ in
                state = value.magnification
            }
            .onEnded { (value) in
                self.zoomLevel = self.setZoom(magnification: value.magnification)
            }
    }
    
    private func setZoom(magnification: CGFloat) -> CGFloat {
        return max(min(self.zoomLevel * magnification, self.maxZoom), self.minZoom)
    }
    
    private func getPhotoHeight(originalWidth: Int, originalHeight: Int) -> CGFloat {
        let aspectRatio = CGFloat(originalWidth) / CGFloat(originalHeight)
        return ScreenSize.width / aspectRatio
    }
    
    private func getScreenZoom(originalWidth: Int, originalHeight: Int) -> CGFloat {
        return ScreenSize.height / getPhotoHeight(originalWidth: originalWidth, originalHeight: originalHeight)
    }
    
    private func getMaxZoom(originalWidth: Int, originalHeight: Int) -> CGFloat {
        return CGFloat(originalHeight) / getPhotoHeight(originalWidth: originalWidth, originalHeight: originalHeight)
    }
}

extension View {
    func imageGesture(originalWidth: Int, originalHeight: Int) -> some View {
        modifier(ImageGesture(originalWidth: originalWidth, originalHeight: originalHeight))
    }
}
