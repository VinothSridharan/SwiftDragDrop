//
//  ViewController.swift
//  Sample
//
//  Created by VinothSridharan on 29/09/15.
//  Copyright (c) 2015 VinothSridharan. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{

    @IBOutlet weak var orangeView: UIView!
    @IBOutlet weak var redView: UIView!
    @IBOutlet weak var greenView: UIView!
    @IBOutlet weak var dragMeLabel: UILabel!
    @IBOutlet weak var redCountLabel: UILabel!
    @IBOutlet weak var greenCountLabel: UILabel!
    var cloneView:UIView!
    var cloneLabel:UILabel!
    var redCount = 0
    var greenCount = 0
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
      
        // Do any additional setup after loading the view, typically from a nib.
        //Adding pangesture for the draggable 'orangeView' view
        
        let pangesture=UIPanGestureRecognizer()
        pangesture.addTarget(self, action:#selector(ViewController.pangestureHandler(_:)))
        orangeView.addGestureRecognizer(pangesture)
        
        //Adding Corner radius
        orangeView.layer.cornerRadius=orangeView.frame.width/2;
        redView.layer.cornerRadius=orangeView.frame.width/2;
        greenView.layer.cornerRadius=orangeView.frame.width/2;
        //
        
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

     //Pan Gesture Handler
    func pangestureHandler(sender:UIPanGestureRecognizer)
    {
        var draggedView=UIView()
        draggedView=sender.view!

        if sender.state == UIGestureRecognizerState.Began
        {
            
            self.addCloneView(draggedView)
            self.addCloneLabel()
        }
        else if sender.state == UIGestureRecognizerState.Changed
        {
           
            self.view.bringSubviewToFront(sender.view!)
            let translation = sender.translationInView(self.view)
            draggedView.center = CGPointMake(draggedView.center.x + translation.x, draggedView.center.y + translation.y)
            sender.setTranslation(CGPointZero, inView: self.view)
        }
        else if sender.state == UIGestureRecognizerState.Ended
        {
            var count:String;
            if CGRectContainsPoint(redView.frame, sender.view!.center)
            {
                redCount=redCount+1;
                count=String(redCount)
                redCountLabel.text=count;
                self .animateView(redView)
                
            }
            else if  CGRectContainsPoint(greenView.frame, sender.view!.center)
            {
                greenCount=greenCount+1;
                count=String(greenCount)
                greenCountLabel.text=count;
                self .animateView(greenView)
            }
            self .removeGestures(draggedView)
            draggedView .removeFromSuperview()
            
        }
        else
        {
            //do nothing
        }
        
    }
    
    //Function for cloning the dragged view
    
    func addCloneView(view:UIView)
    {
       
        cloneView=UIView(frame: CGRectMake(view.frame.origin.x,view.frame.origin.y,view.frame.size.width,view.frame.size.height))
        //
        let pangesture=UIPanGestureRecognizer()
        pangesture.addTarget(self, action:#selector(ViewController.pangestureHandler(_:)))
        cloneView.addGestureRecognizer(pangesture)
        //
        cloneView.backgroundColor=view.backgroundColor;
        cloneView.layer.cornerRadius=view.layer.cornerRadius;
        //
        self.view .addSubview(cloneView)
        
    }
    
    //Function for cloning the dragged view's label
    func addCloneLabel()
    {
        let subviews = self.view.subviews
        for subview in subviews
        {
            if subview is UILabel
            {
                let originalLabel=subview as! (UILabel)
                cloneLabel=UILabel(frame: CGRectMake(originalLabel.frame.origin.x, originalLabel.frame.origin.y, originalLabel.frame.width, originalLabel.frame.height))
                cloneLabel.text=originalLabel.text
                cloneLabel.textColor=originalLabel.textColor
                cloneLabel.textAlignment=originalLabel.textAlignment
                cloneLabel.font=originalLabel.font
                break
            }
            
        }
        self.view.addSubview(cloneLabel)
    }

    
    //Function for removing gestures attached to a view
    
    func removeGestures(view:UIView)
    {
        if let recognizers = view.gestureRecognizers {
            for recognizer in recognizers {
                view.removeGestureRecognizer(recognizer )
            }
        }
        
    }
    
    //Function for animating the target view
    
    func animateView(view:UIView)
    {
        let originalColor=view.backgroundColor!
        view.backgroundColor=UIColor.whiteColor()
        UIView.animateWithDuration(0.3, delay: 0.0, options: UIViewAnimationOptions.CurveEaseIn, animations:
            {
                view.backgroundColor=originalColor
            
            }, completion:
            {
                finished in
                print("Animation Made!")
        })
    }
}

