//
//  ViewController.swift
//  Prueba
//
//  Created by Nivaldo Martinez on 9/9/20.
//  Copyright © 2020 Nivaldo Martinez. All rights reserved.
//

import UIKit
import Alamofire

class APODViewController: UIViewController {
    
    @IBOutlet weak var searchBtn: UIBarButtonItem!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    let viewModel = APODViewModel()
    var toolBar = UIToolbar()
    var datePicker  = UIDatePicker()
    var selectedApod: APOD?

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        bindViewModel()
        retrieveData()
    }
    
    /// viewmodel data source's listener
    func bindViewModel() {
        viewModel.refreshDataSource = { [weak  self]  in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
                self?.activityIndicator.stopAnimating()
            }
        }
    }
    
    /// retrieve last apods from viewmodel
    func retrieveData() {
        activityIndicator.startAnimating()
        viewModel.fetchLastApods()
    }
    
    /// navbar left button action
    @IBAction func reloadLastApods(_ sender: Any) {
        retrieveData()
    }
    
    /// this creates and show an uidatepicker
    @IBAction func openDateSearch(_ sender: Any) {
        datePicker = UIDatePicker.init()
        datePicker.backgroundColor = UIColor.white

        datePicker.autoresizingMask = .flexibleWidth
        datePicker.datePickerMode = .date
        datePicker.maximumDate = Date()
        datePicker.frame = CGRect(x: 0.0, y: UIScreen.main.bounds.size.height, width: UIScreen.main.bounds.size.width, height: 0)
        datePicker.addTarget(self, action: #selector(self.dateChanged(_:)), for: .valueChanged)
        self.view.addSubview(datePicker)

        toolBar = UIToolbar(frame: CGRect(x: 0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 50))
        toolBar.barStyle = .black
        toolBar.tintColor = .white
        toolBar.layer.opacity = 0
        toolBar.items = [UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil), UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.onDoneButtonClick))]
        toolBar.sizeToFit()
        self.view.addSubview(toolBar)
        
        UIView.animate(withDuration: 0.2) {
            self.toolBar.layer.opacity = 1
            self.datePicker.frame = CGRect(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 300)
        }
        searchBtn.isEnabled = false
    }
    
    /// this runs when the user changes uidatepicker's date
    @objc func dateChanged(_ sender: UIDatePicker?) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = MAIN_DATE_FORMAT

        if let date = sender?.date {
            activityIndicator.startAnimating()
            viewModel.fetchApodBy(date: date)
        }
    }
    
    /// hide uidatepicker
    @objc func onDoneButtonClick() {
        UIView.animate(withDuration: 0.2, animations: {
            self.toolBar.layer.opacity = 0
            self.datePicker.frame = CGRect(x: 0.0, y: UIScreen.main.bounds.size.height, width: UIScreen.main.bounds.size.width, height: 0)
        }) { (_) in
            self.toolBar.removeFromSuperview()
            self.datePicker.removeFromSuperview()
        }
        
        searchBtn.isEnabled = true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? APODDetailViewController {
            destination.apod = selectedApod
        }
    }
    
}

extension APODViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.datasource.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 360.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: APOD_CELL_ID, for: indexPath) as! APODViewCell
        let apod = viewModel.datasource[indexPath.row]
        cell.apod = apod
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedApod = viewModel.datasource[indexPath.row]
        performSegue(withIdentifier: APOD_DETAIL_SEGUE_ID, sender: self)
    }
    
}

