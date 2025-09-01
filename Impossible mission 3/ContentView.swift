//
//  ContentView.swift
//  Impossible mission 3
//
//  Created by Khush Pareek on 1/9/25.
//

import SwiftUI

struct Agent: Identifiable {
    let id = UUID()
    let codename: String
    let role: String
    let secret: String
}

struct Event: Identifiable {
    let id = UUID()
    let time: String
    let description: String
}


struct ContentView: View {
    @State private var agents: [Agent] = [
        Agent(codename: "Nova", role: "Mastermind", secret: "Planned the timeline of the heist."),
        Agent(codename: "Cipher", role: "Tech Specialist", secret: "Disabled the security lasers."),
        Agent(codename: "Atlas", role: "Muscle", secret: "Carried the Incoin vault out of the facility."),
        Agent(codename: "Wren", role: "Inside Man", secret: "Fed info from within the company."),
        Agent(codename: "Vega", role: "Getaway Driver", secret: "Fled with the Incoin to an unknown hideout.")
    ]
    
    @State private var selectedAgent: Agent? = nil
    
    // Events
    @State private var events: [Event] = [
        Event(time: "09:00 AM", description: "Agents briefed about unusual movement of Incoin."),
        Event(time: "10:30 AM", description: "Suspicious power outage reported at the vault."),
        Event(time: "11:00 AM", description: "Camera footage mysteriously corrupted."),
        Event(time: "12:15 PM", description: "Five masked agents spotted fleeing."),
        Event(time: "01:00 PM", description: "Accomplice sighted at the train station."),
        Event(time: "02:30 PM", description: "Signal traced to an abandoned warehouse.")
    ]
    
    @State private var selectedEvent: Event? = nil
    @State private var showClues = false
    
    var body: some View {
        TabView {
            NavigationView {
                VStack {
                    Text("🔎 Impossible Mission Force")
                        .font(.title2)
                        .padding(.top)
                    
                    List(agents) { agent in
                        Button {
                            selectedAgent = agent
                        } label: {
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(agent.codename)
                                        .font(.headline)
                                    Text(agent.role)
                                        .font(.subheadline)
                                        .foregroundColor(.secondary)
                                }
                                Spacer()
                                Image(systemName: "lock.shield")
                                    .foregroundColor(.blue)
                            }
                        }
                    }
                    .listStyle(InsetGroupedListStyle())
                }
                .navigationTitle("Agent Files")
                .sheet(item: $selectedAgent) { agent in
                    VStack(spacing: 20) {
                        Text("Codename: \(agent.codename)")
                            .font(.largeTitle)
                            .bold()
                        Text("Role: \(agent.role)")
                            .font(.title3)
                            .foregroundColor(.secondary)
                        Divider()
                        Text("🕵️ Secret Intel:")
                            .font(.headline)
                        Text(agent.secret)
                            .multilineTextAlignment(.center)
                            .padding()
                        Spacer()
                    }
                    .padding()
                }
            }
            .tabItem {
                Label("Agents", systemImage: "person.3.fill")
            }
            
            NavigationStack {
                VStack {
                    Text("🕵️ Incoin Heist Mission 🕵️")
                        .font(.title2)
                        .bold()
                        .padding(.bottom, 5)
                    
                    List(events) { event in
                        Button {
                            selectedEvent = event
                            showClues = true
                        } label: {
                            HStack {
                                Text(event.time)
                                    .font(.headline)
                                Spacer()
                                Text(event.description)
                                    .font(.body)
                            }
                        }
                    }
                    
                    NavigationLink("📜 View Final Report", destination: FinalReportView())
                        .buttonStyle(.borderedProminent)
                        .padding()
                }
                .navigationTitle("Timeline")
                .sheet(isPresented: $showClues) {
                    if let event = selectedEvent {
                        ClueView(event: event)
                    }
                }
            }
            .tabItem {
                Label("Timeline", systemImage: "clock.fill")
            }
        }
    }
}
struct ClueView: View {
    let event: Event
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Clue Unlocked!")
                .font(.title)
                .fontWeight(.bold)
            
            Text("Event: \(event.time)\n\n\(event.description)")
                .multilineTextAlignment(.center)
                .padding()
            
            Text("Possible Hint: Look closely at the details… not everything is what it seems.")
                .foregroundColor(.red)
                .italic()
            
            Spacer()
        }
        .padding()
    }
}

struct FinalReportView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 15) {
                Text("📝 Final Report: The Incoin Heist")
                    .font(.title)
                    .fontWeight(.bold)
                
                Text("Who was the accomplice? ❓")
                Text("👉 The corrupt security guard at the train station.")
                
                Text("Where did they flee? ❓")
                Text("👉 They escaped toward an abandoned warehouse near the docks.")
                
                Text("Why was Incoin stolen? ❓")
                Text("👉 To fund a rogue underground tech syndicate.")
                
                Text("How did they steal the Incoin? ❓")
                Text("👉 By disabling cameras, staging a blackout, and using a magnetic disruptor to crack the vault.")
                
                Text("Where are they now? ❓")
                Text("👉 Still hiding in the city, but their digital trail is being tracked.")
                
                Divider()
                Text("Mission Complete ✅")
                    .font(.headline)
                    .foregroundColor(.green)
            }
            .padding()
        }
    }
}

#Preview {
    ContentView()
}
