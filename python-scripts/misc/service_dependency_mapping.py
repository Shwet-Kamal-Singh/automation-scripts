import networkx as nx
import matplotlib.pyplot as plt
import yaml
import logging
from typing import Dict, List

# Configure logging
logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(levelname)s - %(message)s')

class ServiceDependencyMapper:
    def __init__(self, config_file: str):
        self.config_file = config_file
        self.dependencies = {}
        self.graph = nx.DiGraph()

    def load_config(self) -> None:
        try:
            with open(self.config_file, 'r') as file:
                self.dependencies = yaml.safe_load(file)
            logging.info(f"Configuration loaded from {self.config_file}")
        except Exception as e:
            logging.error(f"Failed to load configuration: {str(e)}")
            raise

    def build_graph(self) -> None:
        for service, deps in self.dependencies.items():
            self.graph.add_node(service)
            for dep in deps:
                self.graph.add_edge(service, dep)
        logging.info("Dependency graph built successfully")

    def get_dependencies(self, service: str) -> List[str]:
        if service not in self.graph:
            logging.warning(f"Service {service} not found in the dependency graph")
            return []
        return list(self.graph.successors(service))

    def get_dependents(self, service: str) -> List[str]:
        if service not in self.graph:
            logging.warning(f"Service {service} not found in the dependency graph")
            return []
        return list(self.graph.predecessors(service))

    def visualize_graph(self, output_file: str) -> None:
        try:
            pos = nx.spring_layout(self.graph)
            plt.figure(figsize=(12, 8))
            nx.draw(self.graph, pos, with_labels=True, node_color='lightblue', 
                    node_size=3000, font_size=10, font_weight='bold', 
                    arrows=True, edge_color='gray')
            
            nx.draw_networkx_labels(self.graph, pos)
            plt.title("Service Dependency Graph")
            plt.axis('off')
            plt.tight_layout()
            plt.savefig(output_file)
            logging.info(f"Dependency graph visualization saved to {output_file}")
        except Exception as e:
            logging.error(f"Failed to visualize graph: {str(e)}")

    def find_circular_dependencies(self) -> List[List[str]]:
        try:
            cycles = list(nx.simple_cycles(self.graph))
            if cycles:
                logging.warning(f"Circular dependencies found: {cycles}")
            else:
                logging.info("No circular dependencies found")
            return cycles
        except Exception as e:
            logging.error(f"Error while finding circular dependencies: {str(e)}")
            return []

    def get_all_services(self) -> List[str]:
        return list(self.graph.nodes())

    def get_dependency_levels(self) -> Dict[int, List[str]]:
        levels = {}
        for node in self.graph.nodes():
            level = nx.shortest_path_length(self.graph, node)
            max_level = max(level.values())
            if max_level not in levels:
                levels[max_level] = []
            levels[max_level].append(node)
        return levels

# Example usage
if __name__ == "__main__":
    mapper = ServiceDependencyMapper("services_config.yaml")
    mapper.load_config()
    mapper.build_graph()

    print("All services:", mapper.get_all_services())
    
    service = "ServiceA"
    print(f"Dependencies of {service}:", mapper.get_dependencies(service))
    print(f"Dependents of {service}:", mapper.get_dependents(service))
    
    mapper.visualize_graph("service_dependency_graph.png")
    
    circular_deps = mapper.find_circular_dependencies()
    if circular_deps:
        print("Circular dependencies:", circular_deps)
    
    levels = mapper.get_dependency_levels()
    print("Dependency levels:")
    for level, services in levels.items():
        print(f"Level {level}: {services}")