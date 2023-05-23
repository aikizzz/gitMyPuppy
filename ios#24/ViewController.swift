
//  ViewController.swift
//  ios#24
//  Created by Hsin Zhang on 2023/5/23.

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var buttonStackView: UIStackView!
    
    @IBOutlet weak var underlineView: UIImageView!
  
    @IBOutlet weak var underlineWidthC: NSLayoutConstraint!
    
    @IBOutlet weak var underlineCenterC: NSLayoutConstraint!
    
    @IBOutlet weak var underlineTopC: NSLayoutConstraint!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    //pages
    var width:CGFloat?ppppppp
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let buttons = buttonStackView.subviews
        for (index,button) in buttons.enumerated() {
        let uibutton = button as! UIButton
        uibutton.tag = index
        uibutton.addTarget(self, action: #selector(changePage), for: .touchUpInside)
        }
    }
    override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    width = view.bounds.width
    }
    
    
    
    @objc func changePage(sender: UIButton){
    setButtonConstraint(button: sender)
    let targetX = CGFloat(sender.tag) * width!
    scrollView.setContentOffset(CGPoint(x: targetX, y: 0), animated: true)
    }
    
    func setButtonConstraint(button: UIButton){
    //先關閉
        underlineWidthC.isActive = true
        underlineCenterC.isActive = true
        underlineTopC.isActive = true
    //改值
        underlineWidthC = underlineView.widthAnchor.constraint(equalTo: button.widthAnchor)
        underlineCenterC = underlineView.centerXAnchor.constraint(equalTo: button.centerXAnchor)
        underlineTopC = underlineView.topAnchor.constraint(equalTo: button.bottomAnchor)
    //再Active
        underlineWidthC.isActive = true
        underlineCenterC.isActive = true
        underlineTopC.isActive = true
    UIViewPropertyAnimator(duration: 0.5, curve: .easeInOut) {
    self.view.layoutIfNeeded()
    }.startAnimation()
    }
    
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
    guard let width = width else { return }
    //targetContentOffset.pointee.x 除以 width一定會剛好，因為有paging enabled的關係
    let currentPage = Int(targetContentOffset.pointee.x / width)
    let buttons = buttonStackView.subviews
    let uibutton = buttons[currentPage] as! UIButton
    setButtonConstraint(button: uibutton)
    }
  
    
    
    
}
extension ViewController:UIScrollViewDelegate{
    
}
