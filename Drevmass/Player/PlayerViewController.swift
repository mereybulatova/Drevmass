//
//  PlayerViewController.swift
//  Drevmass
//
//  Created by Мерей Булатова on 27.11.2023.
//

import UIKit
import SnapKit
import YouTubePlayer

class PlayerViewController: UIViewController {
    
    var video_src = ""
    
    let player = {
        let view = YouTubePlayerView()
        
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(player)
        view.backgroundColor = .appWhite
        
        player.snp.makeConstraints { make in
            make.top.left.right.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        player.loadVideoID(video_src)
    }
}
