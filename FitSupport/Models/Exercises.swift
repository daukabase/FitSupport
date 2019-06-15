//
//  Exercises.swift
//  FitSupport
//
//  Created by Daulet on 30.07.2018.
//  Copyright © 2018 Daulet. All rights reserved.
//

import Foundation
import UIKit

class Exercises {
    
    static func getAll() -> [Exercise] {
        let allExercises = self.allExercises.map { (exercise) -> Exercise in
            exercise.isSelected = false
            return exercise
        }
        return allExercises
    }
    static func filtered(by muscleType: MuscleType) -> [Exercise] {
        return allExercises.filter({ ($0.muscleType?.contains(muscleType)) ?? false })
    }
    static func getExercise(by id: String) -> Exercise? {
        for exercise in allExercises {
            if exercise.exerciseID == id {
                return exercise
            }
        }
        return nil
    }
    
    static private var allExercises: [Exercise] = [
        
        
        Exercise(id: "ABS001", name: "Боковые наклоны с гантелей", image: UIImage.gif(name: "ABS001"), muscleType: [.abs], trainingSession: TrainingSession(reps: 4, times: 15)),
        Exercise(id: "ABS002", name: "Диагональные скручивание", image: UIImage.gif(name: "ABS002"), muscleType: [.abs], trainingSession: TrainingSession(reps: 4, times: 15)),
        Exercise(id: "ABS003", name: "Обратные скручивания сидя", image: UIImage.gif(name: "ABS003"), muscleType: [.abs], trainingSession: TrainingSession(reps: 5, times: 10)),
        Exercise(id: "ABS004", name: "Поднятие ног", image: UIImage.gif(name: "ABS004"), muscleType: [.leg], trainingSession: TrainingSession(reps: 4, times: 30)),
        Exercise(id: "ABS005", name: "Подъем бедер", image: UIImage.gif(name: "ABS005"), muscleType: [.abs], trainingSession: TrainingSession(reps: 4, times: 30)),
        Exercise(id: "ABS006", name: "Подъем таза лежа на боку", image: UIImage.gif(name: "ABS006"), muscleType: [.abs], trainingSession: TrainingSession(reps: 4, times: 30)),
        Exercise(id: "ABS007", name: "Скручивания", image: UIImage.gif(name: "ABS007"), muscleType: [.abs], trainingSession: TrainingSession(reps: 4, times: 30)),
        Exercise(id: "ABS008", name: "Скручивания на наклонной скамье", image: UIImage.gif(name: "ABS008"), muscleType: [.abs], trainingSession: TrainingSession(reps: 3, times: 15)),
        
        
        
        Exercise(id: "ARM001", name: "Жим штанги лежа", image: UIImage.gif(name: "ARM001"), muscleType: [.arm, .chest], trainingSession: TrainingSession(reps: 5, times: 6)),
        Exercise(id: "ARM002", name: "Французкий жим вверх лежа", image: UIImage.gif(name: "ARM002"), muscleType: [.arm], trainingSession: TrainingSession(reps: 5, times: 6)),
        Exercise(id: "ARM003", name: "Хаммер поочередный", image: UIImage.gif(name: "ARM003"), muscleType: [.arm], trainingSession: TrainingSession(reps: 14, times: 4)),
        Exercise(id: "ARM004", name: "Скамья Скотта", image: UIImage.gif(name: "ARM004"), muscleType: [.arm], trainingSession: TrainingSession(reps: 8, times: 4)),
        Exercise(id: "ARM005", name: "Боковая тяга троса на бицепс", image: UIImage.gif(name: "ARM005"), muscleType: [.arm], trainingSession: TrainingSession(reps: 10, times: 4)),
        Exercise(id: "ARM006", name: "Вертикальные отжимание", image: UIImage.gif(name: "ARM006"), muscleType: [.arm], trainingSession: TrainingSession(reps: 15, times: 3)),
        Exercise(id: "ARM007", name: "Жим J.M. Blakley", image: UIImage.gif(name: "ARM007"), muscleType: [.arm], trainingSession: TrainingSession(reps: 7, times: 4)),
        Exercise(id: "ARM008", name: "Разгибание руки на скамье", image: UIImage.gif(name: "ARM008"), muscleType: [.arm], trainingSession: TrainingSession(reps: 20, times: 4)),
        Exercise(id: "ARM009", name: "Сгибания рук с разворотом", image: UIImage.gif(name: "ARM009"), muscleType: [.arm], trainingSession: TrainingSession(reps: 12, times: 4)),
        Exercise(id: "ARM010", name: "Сгибания рук со становой тягой", image: UIImage.gif(name: "ARM010"), muscleType: [.arm], trainingSession: TrainingSession(reps: 8, times: 4)),
//        Exercise(id: "ARM011", name: "Сгибания рук со штангой", image: UIImage.gif(name: "sgibaniye_ruk_so_wtangoi"), muscleType: [.arm], trainingSession: TrainingSession(reps: 8, times: 5)),
        Exercise(id: "ARM012", name: "Сгибания руки с упором в бедро", image: UIImage.gif(name: "ARM012"), muscleType: [.arm], trainingSession: TrainingSession(reps: 12, times: 3)),
        Exercise(id: "ARM013", name: "Французкий жим в тренажере", image: UIImage.gif(name: "ARM013"), muscleType: [.arm], trainingSession: TrainingSession(reps: 12, times: 6)),
        Exercise(id: "ARM014", name: "Жим в тренажере с V-образным грифом", image: UIImage.gif(name: "ARM014"), muscleType: [.arm], trainingSession: TrainingSession(reps: 12, times: 3)),
        Exercise(id: "ARM015", name: "Французский жим за головой на наклонной скамье", image: UIImage.gif(name: "ARM015"), muscleType: [.arm], trainingSession: TrainingSession(reps: 8, times: 3)),
        Exercise(id: "ARM016", name: "Французкий жим за головой с гантелью сидя", image: UIImage.gif(name: "ARM016"), muscleType: [.arm], trainingSession: TrainingSession(reps: 12, times: 4)),
        Exercise(id: "ARM017", name: "Французкий жим стоя", image: UIImage(named: "ARM017"), muscleType: [.arm], trainingSession: TrainingSession(reps: 10, times: 4)),
        Exercise(id: "ARM018", name: "Хаммер в тренажере с блоком", image: UIImage.gif(name: "ARM018"), muscleType: [.arm], trainingSession: TrainingSession(reps: 15, times: 3)),
        
        
        
        Exercise(id: "SH001", name: "Армейский жим сидя", image: UIImage.gif(name: "SH001"), muscleType: [.shoulders], trainingSession: TrainingSession(reps: 7, times: 4)),
        Exercise(id: "SH002", name: "Жим Арнольда", image: UIImage.gif(name: "SH002"), muscleType: [.shoulders], trainingSession: TrainingSession(reps: 10, times: 4)),
        Exercise(id: "SH003", name: "Жим в тренажере на плечи", image: UIImage.gif(name: "SH004"), muscleType: [.shoulders], trainingSession: TrainingSession(reps: 8, times: 4)),
        Exercise(id: "SH004", name: "Жим гантелей сидя", image: UIImage.gif(name: "SH005"), muscleType: [.shoulders], trainingSession: TrainingSession(reps: 12, times: 3)),
        Exercise(id: "SH005", name: "Отведение руки в сторону в наклоне", image: UIImage.gif(name: "SH005"), muscleType: [.shoulders], trainingSession: TrainingSession(reps: 10, times: 4)),
        Exercise(id: "SH006", name: "Поднятие руки с использование троса", image: UIImage.gif(name: "SH006"), muscleType: [.shoulders], trainingSession: TrainingSession(reps: 12, times: 4)),
        Exercise(id: "SH007", name: "Поднятие штанги", image: UIImage.gif(name: "SH007"), muscleType: [.shoulders], trainingSession: TrainingSession(reps: 8, times: 4)),
        Exercise(id: "SH008", name: "Разведение гантелей в сторону", image: UIImage.gif(name: "SH008"), muscleType: [.shoulders], trainingSession: TrainingSession(reps: 10, times: 4)),
        Exercise(id: "SH009", name: "Разведение рук за спину сидя", image: UIImage.gif(name: "SH009"), muscleType: [.shoulders], trainingSession: TrainingSession(reps: 12, times: 4)),
        Exercise(id: "SH010", name: "Разведение рук с упором головы", image: UIImage.gif(name: "SH010"), muscleType: [.shoulders], trainingSession: TrainingSession(reps: 10, times: 4)),
        Exercise(id: "SH011", name: "Шраги", image: UIImage.gif(name: "SH011"), muscleType: [.shoulders], trainingSession: TrainingSession(reps: 10, times: 4)),
        
        
        
        Exercise(id: "CH001", name: "Жим гантелей на наклоненной вниз скамье", image: UIImage.gif(name: "CH001"), muscleType: [.chest, .arm], trainingSession: TrainingSession(reps: 8, times: 4)),
        Exercise(id: "CH002", name: "Жим гантелей на наклонной скамье", image: UIImage.gif(name: "CH002"), muscleType: [.chest], trainingSession: TrainingSession(reps: 8, times: 4)),
        Exercise(id: "CH003", name: "Жим гантелей на скамье", image: UIImage.gif(name: "CH003"), muscleType: [.chest], trainingSession: TrainingSession(reps: 12, times: 4)),
        
        Exercise(id: "CH004", name: "Жим лежа в тренажере Смита.", image: UIImage.gif(name: "CH004"), muscleType: [.chest, .arm], trainingSession: TrainingSession(reps: 8, times: 5)),
        Exercise(id: "CH005", name: "Жим лежа на наклонной скамье", image: UIImage.gif(name: "CH005"), muscleType: [.chest, .arm], trainingSession: TrainingSession(reps: 8, times: 5)),
        Exercise(id: "CH006", name: "Жим штанги лежа", image: UIImage.gif(name: "CH006"), muscleType: [.chest], trainingSession: TrainingSession(reps: 8, times: 5)),
        Exercise(id: "CH007", name: "Пулловер с гантелью лежа", image: UIImage.gif(name: "CH007"), muscleType: [.chest], trainingSession: TrainingSession(reps: 7, times: 4)),
        
        Exercise(id: "CH008", name: "Сведение рук в тренажере", image: UIImage.gif(name: "CH008"), muscleType: [.chest], trainingSession: TrainingSession(reps: 8, times: 4)),
        Exercise(id: "CH009", name: "Сведение рук в тренажере с блоками", image: UIImage.gif(name: "CH009"), muscleType: [.chest], trainingSession: TrainingSession(reps: 12, times: 3)),
        Exercise(id: "CH010", name: "Сведение рук на наклонной скамье.", image: UIImage.gif(name: "CH010"), muscleType: [.chest], trainingSession: TrainingSession(reps: 8, times: 4)),
        
        
        
        Exercise(id: "B001", name: "Вертикальная тяга", image: UIImage.gif(name: "B001"), muscleType: [.back], trainingSession: TrainingSession(reps: 10, times: 4)),
        Exercise(id: "B002", name: "Вертикальная тяга с V-образной ручкой", image: UIImage.gif(name: "B002"), muscleType: [.back], trainingSession: TrainingSession(reps: 10, times: 4)),
        Exercise(id: "B003", name: "Гиперэкстензия", image: UIImage.gif(name: "B003"), muscleType: [.back], trainingSession: TrainingSession(reps: 15, times: 5)),
        Exercise(id: "B004", name: "Разведение рук с тросом", image: UIImage.gif(name: "B004"), muscleType: [.back], trainingSession: TrainingSession(reps: 10, times: 4)),
        Exercise(id: "B005", name: "Cтановая тяга", image: UIImage.gif(name: "B005"), muscleType: [.back], trainingSession: TrainingSession(reps: 8, times: 4)),
        Exercise(id: "B006", name: "Тяга в Т-образном тренажере", image: UIImage.gif(name: "B006"), muscleType: [.back], trainingSession: TrainingSession(reps: 8, times: 4)),
        Exercise(id: "B007", name: "Тяга гантели на скамье.", image: UIImage.gif(name: "B007"), muscleType: [.back], trainingSession: TrainingSession(reps: 14, times: 3)),
        Exercise(id: "B008", name: "Тяга штанги обратным хватом в наклоне", image: UIImage.gif(name: "B008"), muscleType: [.back], trainingSession: TrainingSession(reps: 10, times: 4)),
        Exercise(id: "B009", name: "Тяга нижнего блока", image: UIImage.gif(name: "B009"), muscleType: [.back], trainingSession: TrainingSession(reps: 10, times: 4)),
        
        
        
        Exercise(id: "L001", name: "Выпады со штангой.", image: UIImage.gif(name: "L002"), muscleType: [.leg], trainingSession: TrainingSession(reps: 8, times: 4)),
        Exercise(id: "L002", name: "Жим в тренажере со штангой.", image: UIImage.gif(name: "L002"), muscleType: [.leg], trainingSession: TrainingSession(reps: 8, times: 4)),
        Exercise(id: "L003", name: "Отведение ноги назад в тренажере.", image: UIImage.gif(name: "L003"), muscleType: [.leg], trainingSession: TrainingSession(reps: 8, times: 4)),
        Exercise(id: "L004", name: "Поднятие на носки в тренажере сидя.", image: UIImage.gif(name: "L004"), muscleType: [.leg], trainingSession: TrainingSession(reps: 8, times: 4)),
        Exercise(id: "L005", name: "Поднятие таза лежа (мостик).", image: UIImage.gif(name: "L005"), muscleType: [.leg], trainingSession: TrainingSession(reps: 15, times: 4)),
        Exercise(id: "L006", name: "Приседания со штангой.", image: UIImage.gif(name: "L006"), muscleType: [.leg], trainingSession: TrainingSession(reps: 8, times: 4)),
        Exercise(id: "L007", name: "Сведение ног сидя", image: UIImage.gif(name: "L007"), muscleType: [.leg], trainingSession: TrainingSession(reps: 10, times: 4)),
        Exercise(id: "L008", name: "Разгибания ног сидя", image: UIImage.gif(name: "L008"), muscleType: [.leg], trainingSession: TrainingSession(reps: 8, times: 5)),
        Exercise(id: "L009", name: "Сгибания ноги стоя.", image: UIImage.gif(name: "L009"), muscleType: [.leg], trainingSession: TrainingSession(reps: 10, times: 4)),
        ]
}
