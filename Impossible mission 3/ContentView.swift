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
                ZStack {
                    LinearGradient(colors: [.black, .gray.opacity(0.8)], startPoint: .top, endPoint: .bottom)
                        .ignoresSafeArea()
                    
                    VStack {
                        Text("🔎 Impossible Mission Force")
                            .font(.largeTitle.bold())
                            .foregroundColor(.white)
                            .shadow(radius: 4)
                            .padding(.top)
                        
                        ScrollView {
                            ForEach(agents) { agent in
                                Button {
                                    selectedAgent = agent
                                } label: {
                                    HStack {
                                        VStack(alignment: .leading, spacing: 4) {
                                            Text(agent.codename)
                                                .font(.headline)
                                                .foregroundColor(.white)
                                            Text(agent.role)
                                                .font(.subheadline)
                                                .foregroundColor(.white)
                                        }
                                        Spacer()
                                        Image(systemName: "lock.shield.fill")
                                            .foregroundColor(.blue)
                                            .imageScale(.large)
                                    }
                                    .padding()
                                    .background(.ultraThinMaterial)
                                    .cornerRadius(15)
                                    .shadow(radius: 3)
                                }
                                .padding(.horizontal)
                                .padding(.top, 5)
                            }
                        }
                    }
                }
                .navigationTitle("Agent Files")
                .sheet(item: $selectedAgent) { agent in
                    VStack(spacing: 20) {
                        Text("Codename: \(agent.codename)")
                            .font(.largeTitle.bold())
                        Text("Role: \(agent.role)")
                            .font(.title3)
                            .foregroundColor(.secondary)
                        Divider()
                        Text("🕵️ Secret Intel:")
                            .font(.headline)
                        Text(agent.secret)
                            .multilineTextAlignment(.center)
                            .padding()
                            .foregroundColor(.red)
                        Spacer()
                    }
                    .padding()
                }
            }
            .tabItem {
                Label("Agents", systemImage: "person.3.fill")
            }
            
            NavigationStack {
                ZStack {
                    LinearGradient(colors: [.black, .purple.opacity(0.8)], startPoint: .top, endPoint: .bottom)
                        .ignoresSafeArea()
                    
                    VStack {
                        Text("🕵️ Incoin Heist Mission")
                            .font(.largeTitle.bold())
                            .foregroundColor(.white)
                            .shadow(radius: 3)
                            .padding(.bottom, 5)
                        
                        ScrollView {
                            ForEach(events) { event in
                                Button {
                                    selectedEvent = event
                                    showClues = true
                                } label: {
                                    VStack(alignment: .leading, spacing: 6) {
                                        Text(event.time)
                                            .font(.headline)
                                            .foregroundColor(.yellow)
                                        Text(event.description)
                                            .font(.body)
                                            .foregroundColor(.white)
                                    }
                                    .padding()
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .background(.ultraThinMaterial)
                                    .cornerRadius(15)
                                    .shadow(radius: 4)
                                }
                                .padding(.horizontal)
                                .padding(.top, 5)
                            }
                        }
                        
                        NavigationLink("📜 View Final Report", destination: FinalReportView())
                            .buttonStyle(.borderedProminent)
                            .tint(.red)
                            .padding()
                            .shadow(radius: 3)
                    }
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
        .accentColor(.red)
    }
}

struct ClueView: View {
    let event: Event
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Clue Unlocked!")
                .font(.largeTitle.bold())
                .foregroundColor(.red)
                .shadow(radius: 3)
            
            Text("Event: \(event.time)\n\n\(event.description)")
                .multilineTextAlignment(.center)
                .padding()
                .foregroundColor(.primary)
            
            Text("Possible Hint: Look closely… not everything is what it seems.")
                .foregroundColor(.red)
                .italic()
                .padding()
            
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
                    .font(.title.bold())
                    .padding(.bottom, 10)
                
                Group {
                    Text("Who was the accomplice? ❓")
                        .font(.headline)
                    Text("👉 The corrupt security guard at the train station.\n")
                    
                    Text("Where did they flee? ❓")
                        .font(.headline)
                    Text("👉 They escaped toward an abandoned warehouse near the docks.\n")
                    
                    Text("Why was Incoin stolen? ❓")
                        .font(.headline)
                    Text("👉 To fund a rogue underground tech syndicate.\n")
                    
                    Text("How did they steal the Incoin? ❓")
                        .font(.headline)
                    Text("👉 By disabling cameras, staging a blackout, and using a magnetic disruptor to crack the vault.\n")
                    
                    Text("Where are they now? ❓")
                        .font(.headline)
                    Text("👉 Still hiding in the city, but their digital trail is being tracked.\n")
                }
                
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
