//
//  BetterToDoWidget.swift
//  BetterToDoWidget
//
//  Created by Mike S. on 09/05/2024.
//

import WidgetKit
import SwiftUI
import BetterToDoKit

struct Provider: TimelineProvider {

    private let service = BTDToDoService()

    func placeholder(in context: Context) -> ToDoEntry {
        ToDoEntry(date: Date(), todoItems: [])
    }

    func getSnapshot(in context: Context, completion: @escaping (ToDoEntry) -> ()) {
        service.fetchAll { items, error in
            let entry = ToDoEntry(date: Date(), todoItems: items ?? [])
            completion(entry)
        }

    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        service.fetchAll { items, error in
            let entry = ToDoEntry(date: Date(), todoItems: items ?? [])
            let nextUpdate = Calendar.current.date(
                byAdding: DateComponents(minute: 15),
                to: Date()
            )!
            let timeline = Timeline(
                entries: [entry],
                policy: .after(nextUpdate)
            )

            completion(timeline)
        }
    }
}

struct ToDoEntry: TimelineEntry {
    let date: Date
    let todoItems: [BTDToDoItem]
}

struct BetterToDoWidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        VStack(alignment: .leading) {
            Text("Items to do:")
                .font(.headline)

            ForEach(entry.todoItems, id: \.id) { item in
                HStack {
                    if item.isDone {
                        Image(systemName: "checkmark")
                    }
                    Text(item.content)
                }

            }
            Spacer()
        }
    }
}

struct BetterToDoWidget: Widget {
    let kind: String = "BetterToDoWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            if #available(iOS 17.0, *) {
                BetterToDoWidgetEntryView(entry: entry)
                    .containerBackground(.fill.tertiary, for: .widget)
            } else {
                BetterToDoWidgetEntryView(entry: entry)
                    .padding()
                    .background()
            }
        }
        .configurationDisplayName("Better todo widget")
        .description("This is a widget to check todo items")
    }
}

#Preview(as: .systemSmall) {
    BetterToDoWidget()
} timeline: {
    ToDoEntry(date: Date(), todoItems: [BTDToDoItem("Test 1", isDone: true), BTDToDoItem("Test 2")])
}
