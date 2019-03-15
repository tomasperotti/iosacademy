//
//  DatePickerViewController.swift
//  Superheroes
//
//  Created by Tomas Mateo Perotti on 15/03/2019.
//  Copyright © 2019 Tomas Mateo Perotti. All rights reserved.
//

import UIKit

protocol DatePickerViewDelegate:class {
    func getDateFromDatePicker (date: Date)
}

class DatePickerViewController: UIViewController {

    @IBOutlet weak var datePicker: UIDatePicker!
    
    weak var delegate : DatePickerViewDelegate?
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
 
    @IBAction func didTapOutsideDatePicker(_ sender: Any) {
        // necesito capturar la fecha
        let formatterDate = DateFormatter()
        formatterDate.dateFormat = "yyyy-mm-dd hh:mm"
        print(formatterDate.string(from: datePicker.date))
        delegate?.getDateFromDatePicker(date: datePicker.date)
        self.dismiss(animated: true, completion: nil)
    }
}
