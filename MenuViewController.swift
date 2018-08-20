//
//  MenuViewController.swift
//  ScrollViewExample
//
//  Created by Dayana Marden on 17.08.2018.
//  Copyright © 2018 Dayana Marden. All rights reserved.
//

import UIKit

import UIKit

class MenuViewController: UIViewController {
  
  var isOpen = false
  var navBar = UINavigationBar()
  let screen = UIScreen.main.bounds
  var gradientLayer: CAGradientLayer!
  //  MARK: UI
  lazy var menuButton: UIButton = {
    let button = UIButton()
    button.setImage(#imageLiteral(resourceName: "list"), for: .normal)
    button.center = backMenu.center
    button.addTarget(self, action: #selector(openMenu), for: .touchUpInside)
    return button
  }()
  lazy var backMenu: UIView = {
    let v = UIView()
    v.frame = CGRect(x: 0, y: 0, width: self.screen.width, height: self.screen.height)
    v.backgroundColor = .white
    return v
  }()
  fileprivate lazy var scrollView: UIScrollView = {
    let scrollView = UIScrollView()
    scrollView.backgroundColor = .white
    scrollView.isScrollEnabled = true
    scrollView.layer.borderWidth = 1
    scrollView.layer.cornerRadius = 10
    scrollView.layer.borderColor = UIColor.white.cgColor
    scrollView.contentSize = CGSize(width: self.screen.width , height: screen.height)
    return scrollView
  }()
  fileprivate lazy var photoImageView: UIImageView  = {
    let imgV = UIImageView()
    imgV.image = UIImage(named: "a")
    imgV.layer.borderWidth = 1
    imgV.layer.cornerRadius = 50
    imgV.layer.borderColor = UIColor.clear.cgColor
    imgV.clipsToBounds = true
    return imgV
  }()
  fileprivate lazy var nameLabel: UILabel = {
    let label = UILabel()
    label.text = "Dayana Tezekbayeva"
    label.font = UIFont(name: "Helvetica-Bold", size: 18)
    label.sizeToFit()
    return label
  }()
  fileprivate lazy var followersView: CircleView = {
    let v = CircleView()
    v.titleLabel.text = "Followers"
    return v
  }()
  fileprivate lazy var friendsView: CircleView = {
    let v = CircleView()
    v.titleLabel.text = "Friends"
    return v
  }()
  fileprivate lazy var groupsView: CircleView = {
    let v = CircleView()
    v.titleLabel.text = "Groups"
    return v
  }()
  
  lazy var menu: UIView = {
    let menu = UIView()
    menu.backgroundColor = .red
    return menu
  }()
  
  lazy var navTitle: UILabel = {
    let l = UILabel()
    l.adjustsFontSizeToFitWidth = true
    l.frame = CGRect(x: 0, y: 24, width: 150, height: 30)
    l.textAlignment = .center
    l.center.x = self.backMenu.center.x
    l.text = "Profile"
    l.font = UIFont(name: "Helvetica-Bold", size: 18)
    l.textColor = .black
    return l
  }()
  
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    createGradientLayer()
    setupViews()
    setupNavigationBar()
    menuConstraints()
    navBar.addSubview(navTitle)
    navBar.addSubview(menuButton)
    swipeMenuHide()
    swipeMenuShow()

  }
  func setupViews(){
    view.addSubview(menu)
    view.addSubview(backMenu)
    backMenu.addSubview(navBar)
    backMenu.addSubview(scrollView)
    backMenu.addSubview(photoImageView)
    scrollView.addSubview(nameLabel)
    scrollView.addSubview(followersView)
    scrollView.addSubview(friendsView)
    scrollView.addSubview(groupsView)
    
  }
  //MARK: Gradient to view
  func createGradientLayer() {
    gradientLayer = CAGradientLayer()
    
    gradientLayer.frame = self.view.bounds
    
    gradientLayer.colors = [UIColor.firstGradientColor.cgColor, UIColor.secondGradientColor.cgColor, UIColor.thirdGradientColor.cgColor]
    
    self.backMenu.layer.addSublayer(gradientLayer)
  }
  
  //MARK: Autolayout to Scroll View
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    var lastHeight = 60
    [nameLabel].forEach{
      lastHeight += Int($0.sizeThatFits($0.bounds.size).height)
    }
    scrollView.contentSize = CGSize(width: scrollView.frame.width , height: CGFloat(lastHeight))
  }
  
  @objc func goShop() {

  }
  
  override var prefersStatusBarHidden: Bool {
    return true
  }
  //  MARK: Constraints
  private func setupNavigationBar(){
    navBar.addSubview(menuButton)
    menuButton.translatesAutoresizingMaskIntoConstraints = false
    menuButton.imageEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5)
    
    let top = NSLayoutConstraint(item: menuButton, attribute: .top, relatedBy: .equal, toItem: navBar, attribute: .top, multiplier: 1.0, constant: 24)
    let left = NSLayoutConstraint(item: menuButton, attribute: .left, relatedBy: .equal, toItem: navBar, attribute: .left, multiplier: 1.0, constant: 8.0)
    let width = NSLayoutConstraint(item: menuButton, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 40)
    let height = NSLayoutConstraint(item: menuButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 40)
    navBar.addConstraints([top, width, left, height ])
    
    navBar.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 120)
    navBar.barTintColor = UIColor.firstGradientColor
    navBar.tintColor = .white
    navBar.shadowImage = UIImage()
    navBar.setBackgroundImage(UIImage(), for: .default)
    navBar.isTranslucent = false
    navBar.barStyle = .default
    navBar.tintColor = .white
    
  }
  
  private func menuConstraints(){
    menu.translatesAutoresizingMaskIntoConstraints = false
    scrollView.translatesAutoresizingMaskIntoConstraints = false
    photoImageView.translatesAutoresizingMaskIntoConstraints = false
    nameLabel.translatesAutoresizingMaskIntoConstraints = false
    followersView.translatesAutoresizingMaskIntoConstraints = false
    friendsView.translatesAutoresizingMaskIntoConstraints = false
    groupsView.translatesAutoresizingMaskIntoConstraints = false
    
    //menu
    let menuTopMarginCon = NSLayoutConstraint(item: menu, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1.0, constant: 0.0)
    let menuLeftMarginCon = NSLayoutConstraint(item: menu, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1.0, constant: 0.0)
    let menuWidthCon = NSLayoutConstraint(item: menu, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: self.view.frame.width/1.7)
    let menuHeightCon = NSLayoutConstraint(item: menu, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: self.view.frame.height)
    view.addConstraints([menuTopMarginCon,menuWidthCon,menuHeightCon, menuLeftMarginCon])
    
    let backViewTopCon = NSLayoutConstraint(item: scrollView, attribute: .top, relatedBy: .equal, toItem: backMenu, attribute: .top, multiplier: 1.0, constant: 150)
    let backViewLeftCon = NSLayoutConstraint(item: scrollView, attribute: .left, relatedBy: .equal, toItem: backMenu, attribute: .left, multiplier: 1.0, constant: 24)
    let backViewLRightCon = NSLayoutConstraint(item: scrollView, attribute: .right, relatedBy: .equal, toItem: backMenu, attribute: .right, multiplier: 1.0, constant: -24)
    let backViewBottomCon = NSLayoutConstraint(item: scrollView, attribute: .bottom, relatedBy: .equal, toItem: backMenu, attribute: .bottom, multiplier: 1.0, constant: -100 )
    backMenu.addConstraints([backViewTopCon, backViewLeftCon, backViewLRightCon, backViewBottomCon])
    
    let imageViewCenterXCon = NSLayoutConstraint(item: photoImageView, attribute: .centerX, relatedBy: .equal, toItem: backMenu, attribute: .centerX, multiplier: 1.0, constant: 0)
    let imageViewTopCon = NSLayoutConstraint(item: photoImageView, attribute: .top, relatedBy: .equal, toItem: scrollView, attribute: .top, multiplier: 1.0, constant: -50)
    let imageViewWidthCon = NSLayoutConstraint(item: photoImageView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 100)
    let imageViewHeightCon = NSLayoutConstraint(item: photoImageView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 100)
    backMenu.addConstraints([imageViewCenterXCon,imageViewTopCon,imageViewWidthCon,imageViewHeightCon])
    
    let nameTopCon = NSLayoutConstraint(item: nameLabel, attribute: .top, relatedBy: .equal, toItem: photoImageView, attribute: .bottom, multiplier: 1.0, constant: 16)
    let nameCenterXCon = NSLayoutConstraint(item: nameLabel, attribute: .centerX, relatedBy: .equal , toItem: scrollView, attribute: .centerX, multiplier: 1.0, constant: 0.0)
    backMenu.addConstraints([nameTopCon,nameCenterXCon])
    
    let circleTopCon = NSLayoutConstraint(item: followersView, attribute: .top, relatedBy: .equal, toItem: nameLabel, attribute: .bottom, multiplier: 1.0, constant: 16)
    let circleCenterXCon = NSLayoutConstraint(item: followersView, attribute: .centerX, relatedBy: .equal , toItem: scrollView, attribute: .centerX, multiplier: 1.0, constant: 0.0)
    let circleWidth = NSLayoutConstraint(item: followersView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 100)
    let circleHeight = NSLayoutConstraint(item: followersView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 100)
    backMenu.addConstraints([circleTopCon,circleCenterXCon,circleWidth,circleHeight])
    
    let circle2TopCon = NSLayoutConstraint(item: friendsView, attribute: .top, relatedBy: .equal, toItem: nameLabel, attribute: .bottom, multiplier: 1.0, constant: 16)
    let circle2CenterXCon = NSLayoutConstraint(item: friendsView, attribute: .right, relatedBy: .equal , toItem: followersView, attribute: .left, multiplier: 1.0, constant: -8.0)
    let circle2Width = NSLayoutConstraint(item: friendsView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 100)
    let circle2Height = NSLayoutConstraint(item: friendsView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 100)
    backMenu.addConstraints([circle2TopCon,circle2CenterXCon,circle2Width,circle2Height])
    
    let circle3TopCon = NSLayoutConstraint(item: groupsView, attribute: .top, relatedBy: .equal, toItem: nameLabel, attribute: .bottom, multiplier: 1.0, constant: 16)
    let circle3CenterXCon = NSLayoutConstraint(item: groupsView, attribute: .left, relatedBy: .equal , toItem: followersView, attribute: .right, multiplier: 1.0, constant: 8.0)
    let circle3Width = NSLayoutConstraint(item: groupsView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 100)
    let circle3Height = NSLayoutConstraint(item: groupsView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 100)
    backMenu.addConstraints([circle3TopCon,circle3CenterXCon,circle3Width,circle3Height])
    
    
  }
  
  //MARK: Gestures
  func swipeMenuHide() {
    let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
    swipeLeft.direction = .left
    self.backMenu.addGestureRecognizer(swipeLeft)
    self.view.addGestureRecognizer(swipeLeft)
  }
  func swipeMenuShow() {
    let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
    swipeLeft.direction = .right
    self.backMenu.addGestureRecognizer(swipeLeft)
    self.view.addGestureRecognizer(swipeLeft)
  }
  @objc func handleGesture(gesture: UISwipeGestureRecognizer) -> Void {
    if gesture.direction == UISwipeGestureRecognizerDirection.right {
      print("right")
      hideMenu()
    }
    else if gesture.direction == UISwipeGestureRecognizerDirection.left {
      self.open()
      print("left")
    }
  }
  
  func hideMenu(){
    self.updateViewConstraints()
    UIView.animate(withDuration: 0.4, animations: {
      self.backMenu.frame.origin.x = self.view.frame.width/1.7
      self.view.layoutIfNeeded()
    })
  }
  
  func open(){
    self.updateViewConstraints()
    UIView.animate(withDuration: 0.5, animations: {
      self.backMenu.frame.origin.x = 0
      self.view.layoutIfNeeded()
    })
  }
  
  @objc func openMenu(){
    self.updateViewConstraints()
    if !isOpen{
      self.hideMenu
    }else{
      self.open()
    }
    isOpen = !isOpen
  }
}

//MARK: custom present to another controllers
extension UIViewController {
  
  func presentDetail(_ viewControllerToPresent: UIViewController) {
    let transition = CATransition()
    transition.duration = 0.5
    transition.type = kCAGravityLeft
    self.view.window!.layer.add(transition, forKey: kCATransition)
    present(viewControllerToPresent, animated: false)
  }
  
  func dismissDetail() {
    let transition = CATransition()
    transition.duration = 0.25
    transition.subtype = kCATransitionFromLeft
    self.view.window!.layer.add(transition, forKey: kCATransition)
    dismiss(animated: false)
  }
}

