//
//  HomeViewController.swift
//  NASA
//
//  Created by Matheus Pacheco Fusco on 14/02/21.
//  Copyright © 2021 Matheus Pacheco Fusco. All rights reserved.
//

import UIKit
import AVFoundation
import Kingfisher
import youtube_ios_player_helper

class HomeViewController: UIViewController {
    
    let presenter = HomePresenter()
    private var selectedCamera: RoverPhotoCamera = .fhaz
    private var selectedCameraType: RoverPhotoCameraType = .curiosity
    
    private let cameraTypePicker = ToolbarPickerView()
    private let cameraPicker = ToolbarPickerView()
    @IBOutlet private weak var cameraTypeTextField: UITextField!
    @IBOutlet private weak var cameraTextField: UITextField!
    @IBOutlet private weak var apodView: UIView!
    @IBOutlet private weak var apodImageView: UIImageView!
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var searchButton: UIButton!
    @IBOutlet private weak var moreInfoButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "NASA"
        self.setupSearchButton()
        self.setupTableView()
        self.configureCameraTypePicker()
        self.configureCameraPicker()
        self.getPictureOfTheDay()
        self.getRoversPhotos()
    }
    
    private func setupSearchButton() {
        self.searchButton.setImage(#imageLiteral(resourceName: "ic-search"), for: .normal)
        self.searchButton.imageView?.contentMode = .scaleAspectFit
        self.searchButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: self.searchButton.bounds.width - 32, bottom: 0, right: 16)
        self.searchButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: -16, bottom: 0, right: ((self.searchButton.imageView?.frame.width ?? 0) / 2))
        self.searchButton.layer.cornerRadius = 8
        self.searchButton.layer.borderWidth = 1
        self.searchButton.layer.borderColor = #colorLiteral(red: 0.003921568627, green: 0.4862745098, blue: 0.9215686275, alpha: 1)
    }
    
    private func setupTableView() {
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.register(class: RoverPhotoTableViewCell.self)
    }
    
    private func configureCameraTypePicker() {
        self.cameraTypePicker.tag = 1
        self.cameraTypePicker.delegate = self
        self.cameraTypePicker.toolbarDelegate = self
        self.cameraTypePicker.dataSource = self
        self.cameraTypeTextField.inputView = self.cameraTypePicker
        self.cameraTypeTextField.inputAccessoryView = self.cameraTypePicker.toolbar
        self.cameraTypePicker.selectRow(0, inComponent: 0, animated: true)
        self.cameraTypeTextField.text = self.presenter.roverCameras.types[0].rawValue
    }
    
    private func configureCameraPicker() {
        self.cameraPicker.tag = 2
        self.cameraPicker.delegate = self
        self.cameraPicker.toolbarDelegate = self
        self.cameraPicker.dataSource = self
        self.cameraTextField.inputView = self.cameraPicker
        self.cameraTextField.inputAccessoryView = self.cameraPicker.toolbar
        self.cameraPicker.selectRow(0, inComponent: 0, animated: true)
        self.cameraTextField.text = self.presenter.roverCameras.camerasForType(self.presenter.selectedCameraType)[0].abbreviation.rawValue
    }
    
    private func getPictureOfTheDay() {
        self.apodView.showLoading()
        self.presenter.getPictureOfTheDay(success: { _ in
            guard let apod = self.presenter.apod else { return }
            if let hdUrl = apod.hdUrl, let url = URL(string: hdUrl) {
                self.apodImageView.isHidden = false
                self.apodImageView.kf.indicatorType = .activity
                let processor = DownsamplingImageProcessor(size: self.apodImageView.bounds.size)
                    |> RoundCornerImageProcessor(cornerRadius: 20)
                self.apodImageView.kf.setImage(
                    with: url,
                    options: [
                        .processor(processor),
                        //                    .scaleFactor(UIScreen.main.scale),
                        .transition(.fade(1)),
                        .cacheOriginalImage
                ])
            } else {
                let ytId = apod.url.components(separatedBy: "https://www.youtube.com/embed/")[1]
                let playerView = YTPlayerView(frame: self.apodView.bounds)
                playerView.load(withVideoId: ytId)
                self.apodView.addSubview(playerView)
            }
            self.moreInfoButton.isEnabled = true
        }) { (error) in
            self.moreInfoButton.isHidden = true
            self.apodView.setErrorMessage("An error occurred. Try again later :(")
        }
    }
    
    private func getRoversPhotos() {
        self.presenter.getRoversPhotos(type: self.selectedCameraType, camera: self.selectedCamera, success: { _ in
            if self.presenter.roverPhotos.count == 0 {
                self.tableView.setEmptyMessage("There is no Mars Photos with the current filters.\nTry another combination :P")
            } else {
                self.tableView.restore()
            }
            self.tableView.reloadData()
        }) { (error) in
            self.tableView.setEmptyMessage("An error occurred. Try again later :(")
        }
    }
    
    @IBAction func requestRoverPhotosButtonClicked(_ sender: Any) {
        self.getRoversPhotos()
    }
    
    @IBAction func moreApodInfoButtonClicked(_ sender: Any) {
        self.navigationController?.pushViewController(UIViewController(), animated: true)
    }
    
}

extension HomeViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView.tag {
        case 1:
            return self.presenter.roverCameras.types.count
        case 2:
            return self.presenter.roverCameras.camerasForType(self.selectedCameraType).count
        default:
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView.tag {
        case 1:
            return self.presenter.roverCameras.types[row].rawValue
        case 2:
            return self.presenter.roverCameras.camerasForType(self.selectedCameraType)[row].abbreviation.rawValue
        default:
            return ""
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView.tag {
        case 1:
            self.cameraTypeTextField.text = self.presenter.roverCameras.types[row].rawValue
            self.cameraTextField.text = self.presenter.roverCameras.camerasForType(self.selectedCameraType)[0].abbreviation.rawValue
            self.selectedCameraType = self.presenter.roverCameras.types[row]
        case 2:
            self.cameraTextField.text = self.presenter.roverCameras.camerasForType(self.selectedCameraType)[row].abbreviation.rawValue
            self.selectedCamera = self.presenter.roverCameras.camerasForType(self.selectedCameraType)[row].abbreviation
        default:
            break
        }
    }
}

extension HomeViewController: ToolbarPickerViewDelegate {
    func doneButtonClicked(pickerView: ToolbarPickerView) {
        let row = pickerView.selectedRow(inComponent: 0)
        pickerView.selectRow(row, inComponent: 0, animated: false)
        
        if pickerView == self.cameraTypePicker {
            self.cameraTypeTextField.text = self.presenter.roverCameras.types[row].rawValue
        } else if pickerView == self.cameraPicker {
            self.cameraTextField.text = self.presenter.roverCameras.camerasForType(self.selectedCameraType)[row].abbreviation.rawValue
        }
        self.view.endEditing(true)
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.presenter.roverPhotos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(cell: RoverPhotoTableViewCell.self, indexPath: indexPath)
        if indexPath.row == self.presenter.roverPhotos.count - 1 && self.presenter.hasMorePhotos {
            self.getRoversPhotos()
        }
        cell.setRoverPhoto(self.presenter.roverPhotos[indexPath.row])
        return cell
    }
}
