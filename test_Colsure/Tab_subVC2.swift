//
//  Tab_subVC2.swift
//  test_Colsure
//
//  Created by Jingnan Zhang on 16/5/16.
//  Copyright © 2016年 Jingnan Zhang. All rights reserved.
//

import UIKit

class Tab_subVC2: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.navigationController?.pushViewController(VCpushedBySecondVC(), animated: true)
    }

}
