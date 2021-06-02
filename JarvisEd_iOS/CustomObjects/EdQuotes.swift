//
//  EdQuotes.swift
//  JarvisEd_iOS
//
//  Created by Austin Alex on 4/22/21.
//  Copyright © 2021 Austin Alex. All rights reserved.
//

import Foundation

class EdQuotes {
    
    /*
     *
     * Member Variables
     *
     */
    
    public static var global: EdQuotes = EdQuotes()
    
    
    
    /*
     *
     * Class Methods
     *
     */
    
    private var quotes: [String] = [
        "\"Education is the most powerful weapon which you can use to change the world\" – Nelson Mandela",
        "\"The cure for boredom is curiosity. There is no cure for curiosity\" – Dorothy Parker",
        "\"If You are planning for a year, sow rice; if you are planning for a decade, plant trees; if you are planning for a lifetime, educate people\" – Chinese Proverb",
        "\"An investment in knowledge pays the best interest\" – Benjamin Franklin",
        "\"The highest result of education is tolerance\" – Hellen Keller",
        "\"The beautiful thing about learning is that no one can take it away from you\" – B. B. King",
        "\"The whole purpose of education is to turn mirrors into windows\" – Sydney J. Harris",
        "\"The function of education is to teach one to think intensively and to think critically. Intelligence plus character – that is the goal of true education\" – Martin Luther King",
        "\"When you educate one person you can change a life, when you educate many you can change the world\" - Shai Reshef"
    ]
    
    
    
    /*
     *
     * Class Methods
     *
     */
    
    public func getRandomQuote() -> String {
        
        let random: Int = Int.random(in: 0..<quotes.count)
        return quotes[random]
        
    }
    
}
