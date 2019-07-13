//
//  PresentVC.swift
//  YamExtensionsDemo
//
//  Created by YaM on 2019/7/13.
//  Copyright © 2019 compassic/YaM. All rights reserved.
//

import UIKit

class PresentVC: UIViewController {
    
    var obCallback: CFRunLoopObserverCallBack?
    
    deinit {
//        print(btn)
        print("deinit")
    }
    override func viewDidDisappear(_ animated: Bool) {
//        print(btn)
        DispatchQueue.main.after(time: 3.0) {
            print(self)
        }
    }
    override func viewWillDisappear(_ animated: Bool) {
//        print(btn)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        let btn = UIButton()

        btn.left = 10
        btn.top = 50
        btn.size = CGSize(width: 50, height: 50)
        btn.backgroundColor = .red
        view.addSubview(btn)
//        btn.addTarget(self, action: #selector(click), for: .touchUpInside)
//        btn.addTargetClosure { (btn) in
//            self.dismiss(animated: true, completion: nil)
//        }
        btn.addBlock(for: .touchUpInside) { [weak self] (btn) in
            self?.dismiss(animated: true, completion: nil)
        }
        // Do any additional setup after loading the view.
//        observeLag()
        

    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
