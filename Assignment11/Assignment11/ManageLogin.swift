//
//  ManageLogin.swift
//  Assignment11
//
//  Created by DCS on 18/12/21.
//  Copyright © 2021 DCS. All rights reserved.
//

import UIKit

class ManageLogin: UIViewController {

    private let mystepper:UIStepper = {
        let stepper = UIStepper()
        stepper.minimumValue = 0
        stepper.maximumValue = 10
        stepper.addTarget(self, action: #selector(handlestepper), for: .valueChanged)
        return stepper
    }()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    

}
