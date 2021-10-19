//
//  QuestionnaireViewController.swift
//  foucusTimer
//
//  Created by 永井涼 on 2021/10/18.
//

import UIKit
import WebKit

class QuestionnaireViewController: UIViewController {
    
    @IBOutlet var googleFormView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       loadWebView()
    }
    
    func loadWebView() {
        let googleFormUrl = URL(string: "https://docs.google.com/forms/d/e/1FAIpQLSfMbDn49lzqPkf2dI_6Jr465B_fEiRDgchi9JHuebN_6tSkPQ/viewform?usp=sf_link")
        let request = URLRequest(url: googleFormUrl!)
        googleFormView.load(request)
    }

}
