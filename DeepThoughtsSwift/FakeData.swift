//
//  FakeData.swift
//  DeepThoughtsSwift
//

import Foundation

public struct thought {
    let title: String
    let category: String
}

public struct FakeData {
    let thoughts: [thought] = [thought(title: "Is there another word for 'synonym'?", category: "Random Thoughts"),
                               thought(title: "I need this one to be kinda long so I can see if the font size calculation is right. It looks correct so I will just type some stuff here to make it way longer then it needs to be.", category: "Long Thought"),
                               thought(title: "Here is another", category: "Another Category")]
}