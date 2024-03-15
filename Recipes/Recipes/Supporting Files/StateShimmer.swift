// StateShimmer.swift
// Copyright © RoadMap. All rights reserved.

///  Состояния шимера
//TODO: - удалить когда будет реализован Стейт ниже
enum StateShimer {
    /// Загрузка данных
    case loading
    /// Загружено
    case done
}


/// Состояние данных
enum ViewState<Model> {
    /// Загрузка
    case loading
    /// Есть данные
    case data(_ model: Model)
    /// Нет данных
    case noData
    /// Ошибка
    case error(_ error: Error)
}
