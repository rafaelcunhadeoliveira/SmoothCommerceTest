//
//  HomeViewModel.swift
//  SmoothCommerceTest
//
//  Created by Rafael Cunha de Oliveira on 2020-07-17.
//  Copyright © 2020 Rafael Cunha de Oliveira. All rights reserved.
//

import UIKit

/*
    MVVM architecture, where the view model provides the info
 */

enum ClickType {
    case video, url
}

class HomeViewModel {
    
    var content: Cell?
    var json = """
    { "data": [
        {
        "item_type": "text",
        "data": "Lorem ipsum"
        },
        {
        "item_type": "url",
        "data": "https://material.io/components/"
        },
        {
        "item_type": "image",
        "data": "https://placekitten.com/200/300"
        },
        {
        "item_type": "video",
        "data": "https://devstreaming-cdn.apple.com/videos/wwdc/2017/230lc4n1loob9/230/hls_vod_mvp.m3u8"
        }
        ]
    }
"""
    /*
       Closures are great while calling services, it will return the data at the right time
    */
    func getInfo(success: @escaping() -> Void,
                 failure: @escaping(CustomError) -> Void) {
        guard let data = json.data(using: .utf8) else { return }
        do {
            content = try JSONDecoder().decode(Cell.self, from: data)
            success()
        } catch {
            failure(CustomError(description: "Could not load content", code: 404))
        }
    }
    
    func retrieveData(_ contentType: ContentType) -> String {
        guard let items = content?.data else { return "" }
        for item in items {
            if item.type == contentType.rawValue {
                return item.data ?? ""
            }
        }
        return ""
    }
    
    func getImage(url: String) -> UIImage { // download Image by URL
        return UIImage(url: URL(string: url)) ?? UIImage()
    }
}

struct CustomError {
    
    var title: String?
    var code: Int
    var description: String
    
    init(title: String = "Ops",
         description: String,
         code: Int) {
        self.title = title
        self.description = description
        self.code = code
    }
}
