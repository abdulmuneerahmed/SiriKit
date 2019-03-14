//
//  IntentHandler.swift
//  IntentHandler
//
//  Created by admin on 14/03/19.
//  Copyright © 2019 AcknoTech. All rights reserved.
//

import Intents


class IntentHandler: INExtension, INStartWorkoutIntentHandling{
    func handle(intent: INStartWorkoutIntent, completion: @escaping (INStartWorkoutIntentResponse) -> Void) {
        print("Start WorkOut Intent: ",intent)
        
        let userActivity:NSUserActivity? = nil
        
        guard let spokenPhase = intent.workoutName?.spokenPhrase else {
            completion(INStartWorkoutIntentResponse(code: .failureNoMatchingWorkout, userActivity: userActivity))
            return
        }
        
        if spokenPhase == "walk" || spokenPhase == "run" {
            completion(INStartWorkoutIntentResponse(code: .handleInApp, userActivity: userActivity))
        }else{
            completion(INStartWorkoutIntentResponse(code: .failureNoMatchingWorkout, userActivity: nil))
        }
    }
}
