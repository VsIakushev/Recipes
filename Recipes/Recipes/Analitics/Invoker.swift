// Invoker.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

class Invoker {
    static let shared = Invoker()

    private var commands: [Command] = []

    func addCommand(_ command: Command) {
        commands.append(command)
    }

    func executeCommands() {
        for command in commands {
            command.execute()
            writeCommandsToFile()
        }
    }

    func writeCommandsToFile() {
        let fileManager = FileManager.default
        let directoryURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let folderURL = directoryURL.appendingPathComponent("Logs")

        // Создание папки Logs, если она еще не существует
        if !fileManager.fileExists(atPath: folderURL.path) {
            do {
                try fileManager.createDirectory(
                    atPath: folderURL.path,
                    withIntermediateDirectories: true,
                    attributes: nil
                )
            } catch {
                print("Error creating directory: \(error)")
            }
        }

        let fileURL = folderURL.appendingPathComponent("commands.txt")
        let commandsString = commands.map { $0.description() }.joined(separator: "\n")

        do {
            try commandsString.write(to: fileURL, atomically: true, encoding: .utf8)
        } catch {
            print("Error writing to file: \(error)")
        }
    }
}
