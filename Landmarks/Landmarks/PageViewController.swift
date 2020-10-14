//
//  PageViewController.swift
//  Landmarks
//
//  Created by vphom on 10/11/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import SwiftUI
import UIKit


struct PageViewController: UIViewControllerRepresentable {
    // create a UIKit controller representor to swiftUI
    var controllers:[UIViewController]
    @Binding var currentPage: Int
    
    // call by swiftUI before makeUIView
    func makeCoordinator() -> Coordinator {
        Coordinator(self )
    }

    // call by framework once when ready to show the view and manage its life cycle
    func makeUIViewController(context: Context) -> UIPageViewController {
        let pageViewController = UIPageViewController(
                                        transitionStyle: .scroll,
                                        navigationOrientation: .horizontal)
        // set the coordinator to datasource
        pageViewController.dataSource = context.coordinator
        
        return pageViewController
    }
    
    func updateUIViewController(_ pageViewController: UIPageViewController,context:Context) {
        pageViewController.setViewControllers([controllers[currentPage]], direction: .forward, animated: true)
    }

    class Coordinator: NSObject,UIPageViewControllerDataSource,UIPageViewControllerDelegate {
        var parent: PageViewController
        
        init(_ pageViewController: PageViewController) {
            self.parent = pageViewController
        }
        
        // create relationship between view controller to allow swipe back and forth between them
        func pageViewController(_ pageViewController: UIPageViewController,
                                viewControllerBefore viewController: UIViewController) -> UIViewController? {
            guard let index = parent.controllers.firstIndex(of: viewController) else {
                return nil
            }
            if index == 0 {
                return parent.controllers.last
            }
            return parent.controllers[index - 1]
        }
        
        func pageViewController(_ pageViewController: UIPageViewController,
                                viewControllerAfter viewController: UIViewController) -> UIViewController? {
            guard let index = parent.controllers.firstIndex(of: viewController) else {
                return nil
            }
            if index + 1 == parent.controllers.count {
                return parent.controllers.first
            }
            return parent.controllers[index + 1]
        }
        
        func pageViewController(_ pageViewController:UIPageViewController,
                                didFinishAnimating fihished:Bool,
                                previousViewControllers:[UIViewController],
                                transitionCompleted completed:Bool) {
            if completed,
               let visibleViewController = pageViewController.viewControllers?.first,
               let index = parent.controllers.firstIndex(of: visibleViewController) {
                parent.currentPage = index
            }
        }
    }
}



//struct PageViewController_Previews: PreviewProvider {
//    static var previews: some View {
//        PageViewController()
//    }
//}
