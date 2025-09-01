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
            // MARK: Agents
            NavigationView {
                ZStack {
                    LinearGradient(colors: [.black, .gray.opacity(0.9)], startPoint: .top, endPoint: .bottom)
                        .ignoresSafeArea()
                    
                    VStack {
                        Text("🔎 Impossible Mission Force")
                            .font(.title)
                            .fontWeight(.heavy)
                            .foregroundColor(.white)
                            .shadow(radius: 5)
                            .padding(.top)
                        
                        ScrollView {
                            ForEach(agents) { agent in
                                Button {
                                    selectedAgent = agent
                                } label: {
                                    AgentCard(agent: agent)
                                }
                                .padding(.horizontal)
                                .padding(.bottom, 8)
                            }
                        }
                    }
                }
                .navigationTitle("Agent Files")
                .sheet(item: $selectedAgent) { agent in
                    AgentDetailView(agent: agent)
                }
            }
            .tabItem {
                Label("Agents", systemImage: "person.3.fill")
            }
            
            // MARK: Timeline
            NavigationStack {
                ZStack {
                    LinearGradient(colors: [.black, .blue.opacity(0.8)], startPoint: .top, endPoint: .bottom)
                        .ignoresSafeArea()
                    
                    VStack {
                        Text("🕵️ Incoin Heist Mission 🕵️")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .shadow(radius: 4)
                            .padding(.bottom, 5)
                        
                        List(events) { event in
                            Button {
                                selectedEvent = event
                                showClues = true
                            } label: {
                                HStack {
                                    Text(event.time)
                                        .font(.headline)
                                        .foregroundColor(.blue)
                                    Spacer()
                                    Text(event.description)
                                        .font(.body)
                                }
                            }
                        }
                        .scrollContentBackground(.hidden)
                        .background(.clear)
                        
                        NavigationLink("📜 View Final Report", destination: FinalReportView())
                            .buttonStyle(.borderedProminent)
                            .tint(.red)
                            .padding()
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
    }
}

// MARK: Agent Card
struct AgentCard: View {
    let agent: Agent
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(LinearGradient(colors: [.blue.opacity(0.9), .black], startPoint: .topLeading, endPoint: .bottomTrailing))
                .shadow(radius: 5)
            
            HStack {
                VStack(alignment: .leading, spacing: 5) {
                    Text(agent.codename)
                        .font(.title2)
                        .bold()
                        .foregroundColor(.white)
                    Text(agent.role)
                        .font(.subheadline)
                        .foregroundColor(.white.opacity(0.8))
                }
                Spacer()
                Image(systemName: "lock.shield")
                    .foregroundColor(.yellow)
                    .font(.system(size: 28))
            }
            .padding()
        }
        .frame(height: 100)
    }
}

// MARK: Agent Detail
struct AgentDetailView: View {
    let agent: Agent
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [.black, .gray.opacity(0.9)], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                Text("Codename: \(agent.codename)")
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(.white)
                
                Text("Role: \(agent.role)")
                    .font(.title3)
                    .foregroundColor(.yellow)
                
                Divider().background(Color.white)
                
                Text("🕵️ Secret Intel:")
                    .font(.headline)
                    .foregroundColor(.red)
                
                Text(agent.secret)
                    .multilineTextAlignment(.center)
                    .padding()
                    .foregroundColor(.white)
                
                Spacer()
            }
            .padding()
        }
    }
}

// MARK: Clue View
struct ClueView: View {
    let event: Event
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [.black, .red.opacity(0.8)], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                Text("Clue Unlocked!")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.yellow)
                
                Text("Event: \(event.time)\n\n\(event.description)")
                    .multilineTextAlignment(.center)
                    .padding()
                    .foregroundColor(.white)
                
                Text("Possible Hint: Look closely… not everything is what it seems 👀")
                    .foregroundColor(.red)
                    .italic()
                
                Spacer()
            }
            .padding()
        }
    }
}

// MARK: Final Report
struct FinalReportView: View {
    var body: some View {
        ScrollView {
            ZStack {
                LinearGradient(colors: [.black, .gray.opacity(0.9)], startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()
                
                VStack(alignment: .leading, spacing: 15) {
                    Text("📝 Final Report: The Incoin Heist")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.yellow)
                    
                    Text("Who was the accomplice? ❓")
                        .foregroundColor(.white)
                    Text("👉 The corrupt security guard at the train station.")
                        .foregroundColor(.blue)
                    
                    Text("Where did they flee? ❓")
                        .foregroundColor(.white)
                    Text("👉 They escaped toward an abandoned warehouse near the docks.")
                        .foregroundColor(.blue)
                    
                    Text("Why was Incoin stolen? ❓")
                        .foregroundColor(.white)
                    Text("👉 To fund a rogue underground tech syndicate.")
                        .foregroundColor(.blue)
                    
                    Text("How did they steal the Incoin? ❓")
                        .foregroundColor(.white)
                    Text("👉 By disabling cameras, staging a blackout, and using a magnetic disruptor to crack the vault.")
                        .foregroundColor(.blue)
                    
                    Text("Where are they now? ❓")
                        .foregroundColor(.white)
                    Text("👉 Still hiding in the city, but their digital trail is being tracked.")
                        .foregroundColor(.blue)
                    
                    Divider().background(Color.red)
                    
                    Text("Mission Complete ✅")
                        .font(.headline)
                        .foregroundColor(.green)
                }
                .padding()
            }
        }
    }
}

#Preview {
    ContentView()
}
