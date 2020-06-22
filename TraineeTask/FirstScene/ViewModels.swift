//
//  ViewModels.swift
//  TraineeTask
//
//  Created by Ramin Akhmad on 21.06.2020.
//  Copyright © 2020 Ramin Akhmad. All rights reserved.
//

import Foundation

struct List{
    struct Fetch {
        struct Request
        {
        }
        struct Response
        {
            var lists: [ListModel]
        }
        struct ViewModel
        {
            struct DisplayedList {
                var id: String
                var name: String
                
            }
            var displayedList: [DisplayedList]
        }
    }
}
