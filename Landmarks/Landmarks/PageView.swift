//
//  PageView.swift
//  Landmarks
//
//  Created by vphom on 10/11/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import SwiftUI
// create the UIKit View representor to SwiftUI
struct PageView <Page: View> : View {
    // the UIViewController that represent SWiftUI view to UIKit
    var viewControllers: [UIHostingController<Page>]
    @State var currentPage = 0
    
    init(_ views:[Page]){
        self.viewControllers = views.map{UIHostingController(rootView: $0)}
    }
    
    var body: some View {
        ZStack(alignment: .bottomTrailing){
            PageViewController(controllers: viewControllers,currentPage: $currentPage)
            PageControlView(numberOfPages: viewControllers.count, currentPage: $currentPage)
                .padding(.trailing)
        }
    }
    
}

struct PageView_Previews: PreviewProvider {
    static var previews: some View {
        PageView(features.map{FeatureCard(landmark: $0) })
            .aspectRatio(3/2,contentMode: .fit )
    }
}
