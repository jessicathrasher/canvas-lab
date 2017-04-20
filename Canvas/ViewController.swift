//
//  ViewController.swift
//  Canvas
//
//  Created by Jessica Thrasher on 4/19/17.
//  Copyright © 2017 Cisco. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var trayView: UIView!
    @IBOutlet var panGestureRecognizer: UIPanGestureRecognizer!
    
    var trayOriginalCenter: CGPoint!
    var trayCenterWhenOpen: CGPoint!
    var trayCenterWhenClosed: CGPoint!
    
    var newlyCreatedFace: UIImageView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        trayCenterWhenOpen = trayView.center
        trayCenterWhenClosed = CGPoint(x: trayView.center.x, y: trayView.center.y + 150)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onPanSmiley(_ sender: UIPinchGestureRecognizer) {
        
        
        if sender.state == .began {
            // Gesture recognizers know the view they are attached to
            let imageView = sender.view as! UIImageView

            let tapGesture = UIPanGestureRecognizer(target: self, action: #selector(onTap(_:)))
//            tapGesture.minimumNumberOfTouches = 2
            
            // Create a new image view that has the same image as the one currently panning
            newlyCreatedFace = UIImageView(image: imageView.image)
            newlyCreatedFace.isUserInteractionEnabled = true
            newlyCreatedFace.addGestureRecognizer(tapGesture)
            
            
            // Add the new face to the tray's parent view.
            view.addSubview(newlyCreatedFace)
            
            // Initialize the position of the new face.
            newlyCreatedFace.center = imageView.center
            
            // Since the original face is in the tray, but the new face is in the
            // main view, you have to offset the coordinates
            newlyCreatedFace.center.y += trayView.center.y
            
        } else if sender.state == .changed {
            
            //let translation = sender.translation(in: view)
            let location = sender.location(in: view)
            
            newlyCreatedFace.center = location

            
        } else if sender.state == .ended {
            
        }

    }
    
    func onTap(_ sender: UIPinchGestureRecognizer)  {
        print("changing")
        
        
    }

    @IBAction func onPan(_ sender: UIPanGestureRecognizer) {
        
        // Absolute (x,y) coordinates in parent view (parentView should be
        // the parent view of the tray)
        let location = panGestureRecognizer.location(in: view)
        
        if panGestureRecognizer.state == .began {
            print("Gesture began at: \(location)")
            
            trayOriginalCenter = trayView.center
            
        } else if panGestureRecognizer.state == .changed {
            print("Gesture changed at: \(location)")
            
            let translation = panGestureRecognizer.translation(in: view)
            
            trayView.center = CGPoint(x: trayOriginalCenter.x, y: trayOriginalCenter.y + translation.y)
            
        } else if panGestureRecognizer.state == .ended {
            print("Gesture ended at: \(location)")
            
            if panGestureRecognizer.velocity(in: view).y > 0 {
                // moving down
                trayView.center = trayCenterWhenClosed
            } else {
                
                // moving up
                trayView.center = trayCenterWhenOpen
            }
            
        }
    }

}

