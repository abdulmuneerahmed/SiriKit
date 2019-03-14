//
//  ViewController.swift
//  Siri-Into
//
//  Created by admin on 14/03/19.
//  Copyright © 2019 AcknoTech. All rights reserved.
//

import UIKit
import Intents

class WorkoutVC: UIViewController {

    override func loadView() {
        super.loadView()
        setUp()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        siriSetup()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }

    lazy var imageView:UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "leg")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    lazy var backgroundView:UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var legDayLable:UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.font = UIFont(name: "Avenirnext-Heavy", size: 50)
        label.text = "LEGDAY"
        label.textAlignment = .center
        return label
    }()
    
    lazy var blurView:UIVisualEffectView = {
        let blurView = UIVisualEffectView()
        blurView.effect = UIBlurEffect(style: .regular)
        blurView.translatesAutoresizingMaskIntoConstraints = false
        return blurView
    }()
    
    lazy var workOutLabel:UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.font = UIFont(name: "Avenir Next", size: 30)
        label.text = "WORKOUT APP"
        label.textAlignment = .center
        return label
    }()
    
    lazy var typeLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir Next", size: 20)
        label.textAlignment = .center
        label.isHidden = true
        label.text = "TYPE:"
        label.textColor = UIColor(red: 0/255, green: 128/255, blue: 255/255, alpha: 1)
        return label
    }()
    
    lazy var timeLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir Next", size: 20)
        label.textAlignment = .center
        label.isHidden = true
        label.text = "0:00"
        label.textColor = .green
        return label
    }()
    
    
    func siriSetup(){
        INPreferences.requestSiriAuthorization { (status) in
            if status == INSiriAuthorizationStatus.authorized{
                print("Siri Authorized")
            }else{
                print("Siri UnAuthorized")
            }
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleSirirequest), name: NSNotification.Name("workoutStartednotification"), object: nil)
    }
    
    func setUp(){
        view.addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            ])
        
        view.addSubview(backgroundView)
        NSLayoutConstraint.activate([
            backgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundView.heightAnchor.constraint(equalToConstant: 250),
            backgroundView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            ])
        backgroundView.addSubview(blurView)
        
        NSLayoutConstraint.activate([
            blurView.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor),
            blurView.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor),
            blurView.topAnchor.constraint(equalTo: backgroundView.topAnchor),
            blurView.bottomAnchor.constraint(equalTo: backgroundView.bottomAnchor)
            ])
        
        let stackView = setStackView(labels: [legDayLable,workOutLabel,typeLabel,timeLabel])
        backgroundView.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor),
            stackView.centerYAnchor.constraint(equalTo: backgroundView.centerYAnchor)
            ])
    }
    
    func setStackView(labels:[UILabel]) -> UIStackView{
        let stackView = UIStackView(arrangedSubviews: labels)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 10
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        return stackView
    }
    
    //MARK:- Selectors
    
    @objc func handleSirirequest(){
        guard let intent = DataService.instance.startWorkOutIntent,let goalValue = intent.goalValue,let workoutType = intent.workoutName?.spokenPhrase else {
            typeLabel.isHidden = true
            timeLabel.isHidden = true
            return
        }
        
        typeLabel.isHidden = false
        timeLabel.isHidden = false
        
        typeLabel.text = "TYPE:\(workoutType.capitalized)"
        timeLabel.text = "\(goalValue.convertToClockTime()) LEFT"
    }
    
    deinit {
        print("Deinitilized")
        
    }
}

