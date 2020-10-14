//
//  PageControlView.swift
//  Landmarks
//
//  Created by vphom on 10/11/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import SwiftUI
import UIKit

struct PageControlView: UIViewRepresentable {
   
    var numberOfPages: Int
    @Binding var currentPage: Int
    
    func makeUIView(context: Context) -> UIPageControl {
        let control = UIPageControl()
        control.numberOfPages = numberOfPages
        return control
    }

    func updateUIView(_ uiView:UIPageControl, context: Context) {
        uiView.currentPage = currentPage
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject{
        var control: PageControlView
        
        init(_ control: PageControlView) {
            self.control = control
        }
        
        // to update currentpage binding
        @objc func updateCurrentPage(sender: UIPageControl){
            control.currentPage = sender.currentPage
        }
    }
}


