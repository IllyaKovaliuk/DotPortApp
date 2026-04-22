import Foundation
import CoreLocation

final class GraphService: ObservableObject {
    
    // adjacency list
    private var edges: [String: Set<String>] = [:]
    
    // всі порти (по id)
    private var ports: [String: PortModel] = [:]
    
    // MARK: - Setup
    
    func buildGraph(from portsArray: [PortModel]) {
        ports = Dictionary(uniqueKeysWithValues: portsArray.map { ($0.id, $0) })
        edges.removeAll()
        
        for p1 in portsArray {
            for p2 in portsArray {
                if p1.id == p2.id { continue }
                
                let distance = calculateDistance(p1, p2)
                
                if distance < 3000 { // твій threshold
                    edges[p1.id, default: []].insert(p2.id)
                }
            }
        }
    }
    
    // MARK: - Distance
    
    private func calculateDistance(_ p1: PortModel, _ p2: PortModel) -> Double {
        let loc1 = CLLocation(latitude: p1.latitude, longitude: p1.longtitude)
        let loc2 = CLLocation(latitude: p2.latitude, longitude: p2.longtitude)
        
        return loc1.distance(from: loc2) / 1000 // km
    }
    
    // MARK: - BFS
    
    func reachablePorts(from start: PortModel) -> [PortModel] {
        var visited = Set<String>()
        var queue = [start.id]
        
        while !queue.isEmpty {
            let current = queue.removeFirst()
            
            if visited.contains(current) { continue }
            visited.insert(current)
            
            for neighbor in edges[current] ?? [] {
                queue.append(neighbor)
            }
        }
        
        return visited.compactMap { ports[$0] }
    }
}
