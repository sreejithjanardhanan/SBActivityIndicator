/*
 * SBActivityIndicatorView.swift
 * SBActivityIndicator
 *
 * Created by Sreejith Bhatt on 22/02/19.
 * Copyright © 2019 SB Studios. All rights reserved.
 * http://www.sreejithbhatt.com/
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 *
 */

import UIKit

class SBActivityIndicatorView: UIView {
    
    // MARK : VARIABLES
    
    var activityIndicatorTimer : Timer?
    
    // MARK : IBOUTLETS
    
    @IBOutlet weak var activityIndicaterView: UIImageView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    // MARK : CONSTRUCTOR
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK : METHODS
    
    /*
     @methodName     : setup
     @description    : view setup
     @param          : None
     @return         : None
     */
    
    func setup() -> Void {
        DispatchQueue.main.async {
            let imageListArray = [UIImage(named:"Loader - First Image"), UIImage(named:"Loader - Second Image"), UIImage(named:"Loader - Third Image"), UIImage(named:"Loader - Fourth Image"), UIImage(named:"Loader - Fifth Image")]
            
            self.activityIndicaterView.animationImages = imageListArray as? [UIImage]
            self.activityIndicaterView.animationDuration = 10.0
            self.activityIndicaterView.startAnimating()
            
            var index = 0
            
            self.activityIndicatorTimer =  Timer.scheduledTimer(withTimeInterval: 2.0, repeats: true) { timer in
                
                if index == 4 {
                    index = 0
                } else {
                    index = index + 1
                }
                self.pageControl.currentPage = index
                
                self.pageControl.subviews.forEach {
                    $0.transform = CGAffineTransform(scaleX: 1, y: 1)
                }
                self.pageControl.subviews[self.pageControl.currentPage].transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
            }
        }
    }
    
    /*
     @methodName     : show
     @description    : show activity indicator
     @param          : view - UIView instance
     @return         : None
     */
    
    static func show(view:UIView) -> Void {
        var isActivityIndicatorPresent = false
        let views = view.subviews.reversed()
        for indicatorView in views {
            if indicatorView.isKind(of: self) {
                isActivityIndicatorPresent = true
                break
            }
        }
        if (!isActivityIndicatorPresent) {
            let activityIndicatorView = instanceFromNib()
            view.addSubview(activityIndicatorView)
            activityIndicatorView.frame = view.bounds
        }
    }
    
    /*
     @methodName     : hide
     @description    : hide activity indicator
     @param          : view - UIView instance
     @return         : None
     */
    
    static func hide(view:UIView) -> Void {
        
        let views = view.subviews.reversed()
        for indicatorView in views {
            if indicatorView.isKind(of: self) {
                indicatorView.removeFromSuperview()
            }
        }
    }
    
    /*
     @methodName     : instanceFromNib
     @description    : load instance from Nib
     @param          : None
     @return         : None
     */
    
    static func instanceFromNib() -> SBActivityIndicatorView {
        return UINib(nibName: "SBActivityIndicatorView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! SBActivityIndicatorView
    }
}
