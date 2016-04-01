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
                               thought(title: "Thought 1", category: "Category 1"),
                               thought(title: "Thought 2", category: "Category 2"),
                               thought(title: "Thought 3", category: "Category 3"),
                               thought(title: "Thought 4", category: "Category 4"),
                               thought(title: "Thought 5", category: "Category 5"),
                               thought(title: "Thought 6", category: "Category 6"),
                               thought(title: "Thought 7", category: "Category 7"),
                               thought(title: "Thought 8", category: "Category 8"),
                               thought(title: "Thought 9", category: "Category 9"),
                               thought(title: "Thought 10", category: "Category 10")]
}