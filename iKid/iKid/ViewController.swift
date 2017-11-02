//
//  ViewController.swift
//  iKid
//
//  Created by Kiwon Jeong on 2017. 11. 1..
//  Copyright © 2017년 Kiwon Jeong. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITabBarDelegate {
    @IBOutlet weak var tabBar: UITabBar!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var prevButton: UIButton!
    fileprivate var goodVC : GoodViewController!
    fileprivate var punVC : PunViewController!
    fileprivate var dadVC : DadViewController!
    fileprivate var goodNVC : GoodNextViewController!
    fileprivate var punNVC : PunNextViewController!
    fileprivate var dadNVC : DadNextViewController!
    private var lastVisited: String = ""
    private var isNextVisited = false

    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        switchTabs(item.title!)
    }
    
    private func switchTabs(_ selTab: String) {
        dadBuilder()
        punBuilder()
        goodBuilder()
     
        var fromVC : UIViewController?
        if (isNextVisited) {
            switch lastVisited {
            case "Good":
                fromVC = goodNVC
            case "Pun":
                fromVC = punNVC
            default :
                fromVC = dadNVC
            }
        } else {
            switch lastVisited {
            case "Good":
                fromVC = goodVC
            case "Pun":
                fromVC = punVC
            case "Dad" :
                fromVC = dadVC
            default :
                fromVC = nil
            }
        }

        switch selTab {
        case "Good":
            UIView.setAnimationTransition(.flipFromRight, for: view, cache: true)
            goodVC.view.frame = view.frame
            switchController(fromVC, to: goodVC)
        case "Pun":
            UIView.setAnimationTransition(.flipFromRight, for: view, cache: true)
            punVC.view.frame = view.frame
            switchController(fromVC, to: punVC)
        default:
            UIView.setAnimationTransition(.flipFromRight, for: view, cache: true)
            dadVC.view.frame = view.frame
            switchController(fromVC, to: dadVC)
        }
        
        lastVisited = selTab
        isNextVisited = false
        prevButton.alpha = 0
        nextButton.alpha = 1
     }
    
    fileprivate func switchController(_ from: UIViewController?, to: UIViewController?) {
        if from != nil {
            from!.willMove(toParentViewController: nil)
            from!.view.removeFromSuperview()
            from!.removeFromParentViewController()
        }
        
        if to != nil {
            self.addChildViewController(to!)
            self.view.insertSubview(to!.view, at: 0)
            to!.didMove(toParentViewController: self)
        }
    }
    
     @IBAction func switchViews(_ sender: UIButton) {
        dadNextBuilder()
        punNextBuilder()
        goodNextBuilder()
        
        var prevVC : UIViewController
        var nextVC : UIViewController
        switch lastVisited {
        case "Good":
            prevVC = goodVC
            nextVC = goodNVC
        case "Pun":
            prevVC = punVC
            nextVC = punNVC
        default:
            prevVC = dadVC
            nextVC = dadNVC
        }
        
        UIView.beginAnimations("View Flip", context: nil)
        UIView.setAnimationDuration(0.4)
        UIView.setAnimationCurve(.easeInOut)
     
        if prevVC.view.superview != nil {
            UIView.setAnimationTransition(.flipFromRight, for: view, cache: true)
            nextVC.view.frame = view.frame
            switchController(prevVC, to: nextVC)
            isNextVisited = true
            nextButton.alpha = 0
            prevButton.alpha = 1
         } else {
            UIView.setAnimationTransition(.flipFromLeft, for: view, cache: true)
            prevVC.view.frame = view.frame
            switchController(nextVC, to: prevVC)
            isNextVisited = false
            nextButton.alpha = 1
            prevButton.alpha = 0
    
         }
         UIView.commitAnimations()
     }

    fileprivate func goodBuilder() {
        if goodVC == nil {
            goodVC =
                storyboard?
                    .instantiateViewController(withIdentifier: "First")
                as! GoodViewController
        }
    }
    fileprivate func punBuilder() {
        if punVC == nil {
            punVC =
                storyboard?
                    .instantiateViewController(withIdentifier: "Second")
                as! PunViewController
        }
    }
    fileprivate func dadBuilder() {
        if dadVC == nil {
            dadVC =
                storyboard?
                    .instantiateViewController(withIdentifier: "Third")
                as! DadViewController
        }
    }
    fileprivate func goodNextBuilder() {
        if goodNVC == nil {
            goodNVC =
                storyboard?
                    .instantiateViewController(withIdentifier: "FirstN")
                as! GoodNextViewController
        }
    }
    fileprivate func punNextBuilder() {
        if punNVC == nil {
            punNVC =
                storyboard?
                    .instantiateViewController(withIdentifier: "SecondN")
                as! PunNextViewController
        }
    }
    fileprivate func dadNextBuilder() {
        if dadNVC == nil {
            dadNVC =
                storyboard?
                    .instantiateViewController(withIdentifier: "ThirdN")
                as! DadNextViewController
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        tabBar.delegate = self
        goodBuilder()
        tabBar.selectedItem = tabBar.items![0] as UITabBarItem
        switchController(nil, to: goodVC)
        lastVisited = "Good"
        nextButton.alpha = 1
        prevButton.alpha = 0
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

