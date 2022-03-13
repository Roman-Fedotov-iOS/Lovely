//
//  ViewController.swift
//  Lovely
//
//  Created by Roman Fedotov on 11.03.2022.
//

import UIKit

class ViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var NextBtn: UIButton!
    @IBOutlet weak var skipBtn: UIButton!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var scrollView: UIScrollView!
    
    var scrollWidth: CGFloat! = 0.0
    var scrollHeight: CGFloat! = 0.0
    
    var currentPage = 0 {
        didSet {
            pageControl.currentPage = currentPage
        }
    }
    
    var titles = ["Today was not the best day of your life","And you are already smoking a cigarette","But puzzle will start to put together", "And you will write a new page of your life"]
    
    var imgs = ["FirstPage","SecondPage","ThirdPage", "FourthPage"]
    
    override func viewDidLayoutSubviews() {
        scrollWidth = scrollView.frame.size.width
        scrollHeight = scrollView.frame.size.height
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
                self.view.layoutIfNeeded()
                //to call viewDidLayoutSubviews() and get dynamic width and height of scrollview

                self.scrollView.delegate = self
                scrollView.isPagingEnabled = true
                scrollView.showsHorizontalScrollIndicator = false
                scrollView.showsVerticalScrollIndicator = false

                //crete the slides and add them
                var frame = CGRect(x: 0, y: 0, width: 0, height: 0)

                for index in 0..<titles.count {
                    frame.origin.x = scrollWidth * CGFloat(index)
                    frame.size = CGSize(width: scrollWidth, height: scrollHeight)

                    let slide = UIView(frame: frame)

                    //subviews
                    let imageView = UIImageView.init(image: UIImage.init(named: imgs[index]))
                    imageView.frame = CGRect(x:0,y:0,width:300,height:300)
                    imageView.contentMode = .scaleAspectFit
                    imageView.center = CGPoint(x:scrollWidth/2,y: scrollHeight/2 - 50)
                  
                    let txt1 = UILabel.init(frame: CGRect(x:32,y:imageView.frame.maxY+10,width:scrollWidth-64,height:100))
                    txt1.textAlignment = .center
                    txt1.numberOfLines = 5
                    txt1.font = UIFont.systemFont(ofSize: 36, weight: .ultraLight)
                    txt1.text = titles[index]

                    slide.addSubview(imageView)
                    slide.addSubview(txt1)
                    scrollView.addSubview(slide)

                }

                //set width of scrollview to accomodate all the slides
                scrollView.contentSize = CGSize(width: scrollWidth * CGFloat(titles.count), height: scrollHeight)

                //disable vertical scroll/bounce
                self.scrollView.contentSize.height = 1.0

                //initial state
                pageControl.numberOfPages = titles.count
                pageControl.currentPage = 0

            }

    
    @IBAction func skipBtnAction(_ sender: UIButton) {
        if let controller = storyboard?.instantiateViewController(identifier: "MainVC") {
            controller.modalTransitionStyle = .coverVertical
            controller.modalPresentationStyle = .fullScreen
            present(controller, animated: true, completion: nil)
        }
    }
    
    @IBAction func nextBtnAction(_ sender: UIButton) {
        if currentPage == titles.count - 1 {
            if let controller = storyboard?.instantiateViewController(identifier: "MainVC") {
                controller.modalTransitionStyle = .coverVertical
                controller.modalPresentationStyle = .fullScreen
                present(controller, animated: true, completion: nil)
            }
        } else {
            currentPage += 1
            let xOffset = scrollView.bounds.width * CGFloat(pageControl.currentPage)
            scrollView.setContentOffset(CGPoint(x: xOffset,y: 0) , animated: true)
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageNumber = scrollView.contentOffset.x / scrollView.frame.size.width
        currentPage = Int(pageNumber)
    }

    func setIndiactorForCurrentPage()  {
        let page = (scrollView?.contentOffset.x)!/scrollWidth
        pageControl?.currentPage = Int(page)
    }
    

}

