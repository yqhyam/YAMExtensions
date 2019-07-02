//
//  ViewController.swift
//  YamExtensionsDemo
//
//  Created by compassic/YaM on 2017/11/17.
//  Copyright © 2017年 compassic/YaM. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // get system version
        print(UIDevice.systemVersion)
        
        DispatchQueue.main.after(time: 3.0) {
            print("3s")
        }
        let str = "hello world"
        var arr: [Character] = []
        for item in str {
            arr.append(item)
        }
        
        let image = UIImage(named: "bday_logo")?.toCicle()
        let imageView = UIImageView(image: image)
        imageView.size = CGSize(width: 200, height: 200)
        imageView.left = 200
        imageView.top = 50
        self.view.addSubview(imageView)
        imageView.addObserverBlock(forKeyPath: "bounds") { (a, b, c) in
            print("changed")
        }
        imageView.size = CGSize(width: 80, height: 80)
        
        let path = UIBezierPath.bezierPath(with: "哈 哈 哈", font: UIFont.systemFont(ofSize: 40))
        let layer = CAShapeLayer()
        layer.isGeometryFlipped = true
        layer.bounds = CGRect(x: 0, y: 0, width: path.cgPath.boundingBox.width, height: 60)
        layer.position = CGPoint(x: 150, y: 200)
        layer.path = path.cgPath
        layer.fillColor = UIColor.clear.cgColor
        layer.lineWidth = 1
        layer.strokeEnd = 0
        layer.strokeColor = UIColor.red.cgColor
        self.view.layer.addSublayer(layer)

        let btn = UIButton()
        btn.top = 100
        btn.left = 50
        btn.size = CGSize(width: 30, height: 30)
        btn.backgroundColor = UIColor.blue
        self.view.addSubview(btn)
        btn.addBlock(for: .touchUpInside) { (sender) in
            let ani = CABasicAnimation(keyPath: "strokeEnd")
            ani.fromValue = 0
            ani.toValue = 1
            ani.duration = 5
            ani.isRemovedOnCompletion = false
            ani.fillMode = CAMediaTimingFillMode.forwards
            layer.add(ani, forKey: nil)
        }
        
        let tableView = UITableView()
        tableView.size = CGSize(width: self.view.width, height: self.view.height/2.0)
        tableView.top = self.view.height/2.0
        tableView.delegate = self
        tableView.dataSource = self
        self.view.addSubview(tableView)


        btn.addBlock(for: .touchUpInside) { (sender) in
            print(UIApplication.shared.cpuUsage)
            tableView.update(with: { (tableview) in
                tableview.rowHeight = (tableView.rowHeight != 100) ? 100 : 44
            })
        }
        
        let time = Timer(timeInterval: 1, repeats: true) { (timer) in
        }
        RunLoop.current.add(time, forMode: RunLoop.Mode.common)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 40
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        }
        cell?.textLabel?.text = "\(indexPath.row) + kljllkjn"
        cell?.textLabel?.font = UIFont.monospacedDigitSystemFont(ofSize: 15, weight: UIFont.Weight.thin).toSystem()
        return cell!
    }

}
