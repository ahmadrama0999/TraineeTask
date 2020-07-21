//
//  ViewController.swift
//  TraineeTask
//
//  Created by Ramin Akhmad on 17.06.2020.
//  Copyright © 2020 Ramin Akhmad. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private let service = BGService()
    
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var textLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        service.onProgress = { (progress) in
            self.progressView.progress = Float(progress)
        }
        
        service.onCompleted = { (location) in
            // Save your file somewhere, or use it...
            print("Download finished: \(location.absoluteString)")
            self.textLabel.text = location.absoluteString
        }
    }

    @IBAction func downloadDataAction(_ sender: Any) {
        service.startDownload()
    }
}

