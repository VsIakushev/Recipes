//
//  Command.swift
//  Recipes
//
//  Created by Vermut xxx on 08.03.2024.
//

import Foundation

protocol Command {
    func execute()
    func description() -> String
}

class OpenCategoryScreenCommand: Command {
    func description() -> String {
        "открыл категории"
    }
    
    var cooker = Receiver()
    func execute() {
        cooker.openCategoryScreenCommand()
    }
}

class OpenAllRecipesScreenCommand: Command {
    func description() -> String {
        "открыл все рецепты"
    }
    
    var cooker = Receiver()
    func execute() {
        cooker.openAllRecipesScreenCommand()
    }
}

class OpenDetailedRecipeScreenCommand: Command {
    func description() -> String {
        "открыл детальный рецепт"
    }

    var cooker = Receiver()
    func execute() {
        cooker.openDetailedRecipeScreenCommand()
    }
}

class OpenFavoritesRecipesScreenCommand: Command {
    func description() -> String {
        "открыл избранные"
    }
    
    var cooker = Receiver()
    func execute() {
        cooker.openFavoritesRecipesScreenCommand()
    }
}

class OpenProfileScreenCommand: Command {
    func description() -> String {
        "открыл профиль"
    }

    var cooker = Receiver()
    func execute() {
        cooker.openProfileScreenCommand()
    }
}

class OpenAuthScreenCommand: Command {
    func description() -> String {
        "открыл авторизацию"
    }

    var cooker = Receiver()
    func execute() {
        cooker.openAuthScreenCommand()
    }
}
