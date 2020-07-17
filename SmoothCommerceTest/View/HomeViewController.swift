//
//  HomeViewController.swift
//  SmoothCommerceTest
//
//  Created by Rafael Cunha de Oliveira on 2020-07-17.
//  Copyright © 2020 Rafael Cunha de Oliveira. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

/*
   MVVM architecture, where the view controller only displays info
*/

protocol ClickDelegate {
    // Protocol in order to determine which type and url was send from UITableViewCell
    func handle(_ clickType: ClickType, url: String)
}

class HomeViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    var viewModel = HomeViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
        getInfo()
    }

    func getInfo() {
        viewModel.getInfo(success: {
            self.tableView.reloadData()
        }) { (error) in
            self.showError(error) // show error if service fail
        }
    }

    func registerCell() {
        tableView.register(UINib(nibName: "FeedTableViewCell", bundle: nil),
                           forCellReuseIdentifier: "FeedTableViewCell")
    }

    func playVideo(_ urlString: String) {
        /*
           AVFoundation and AVKit in order the load the video from URL
        */
        guard let url = URL(string: urlString) else { return }
        let player = AVPlayer(url: url)
        let controller = AVPlayerViewController()
        controller.player = player
        present(controller, animated: true) {
            player.play()
        }
        
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let viewController = segue.destination as? WebPageViewController,
            let url = sender as? String {
            viewController.urlString = url
        }
    }
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FeedTableViewCell")
            as? FeedTableViewCell else { return UITableViewCell() }
        cell.setUp(name: viewModel.retrieveData(.name),
                   urlSite: viewModel.retrieveData(.url),
                   image: viewModel.getImage(url: viewModel.retrieveData(.image)),
                   videoUrlStrig: viewModel.retrieveData(.video),
                   delegate: self)
        return cell
    }
}

extension HomeViewController: ClickDelegate { // Delegate implementation
    func handle(_ clickType: ClickType, url: String) {
        switch clickType {
        case .url:
            self.performSegue(withIdentifier: "showWebView", sender: url)
        case .video:
            playVideo(url)
        }
    }
}
