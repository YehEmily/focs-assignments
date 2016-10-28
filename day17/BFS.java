/**************************************************
  * 
  * Emily Yeh
  * 
  * Breadth-First Search (day 17 assignment)
  * 
  * Quick disclaimer: I'm at a point where I haven't
  * used Python in months, so I decided to use Java,
  * except I'm still in the process of learning Java
  * and I'm fully aware that this code may or may not
  * work... However, I've looked at it for several hours
  * now and while I *think* it should work, I really 
  * don't know. Sorry for the mess - as always, please
  * let me know where I went wrong!
  * 
  **************************************************/

import java.util.*;
import org.w3c.dom.*;

public class BFS {
  
  // Instance Variables
  Queue<Node> remainingNodes; // Store remaining (unvisited) nodes
  Node[] visited; // Store visited nodes
  HashMap<Node, Integer> distances; // Store each node's distance
  private int count = 0; // Create a counter
  int size = 5; // Create a default size
  
  // Constructor
  public BFS() {
    remainingNodes = new LinkedList<Node>();
    visited = new Node[size];
  }
  
  // TASK 1: Parent attribute
  public Node parent (Node n) { // Added parent attribute
    return n.getParentNode();
  }
  
  // Visit Method
  public void visit (Node node) {
    
    // Increase size if necessary
    if (count == size-1) {
          increaseSize();
        }
    
    System.out.println(node.getLocalName()); // Print name of visited node
    
    // TASK 2: Distance attribute
    distances.put(node, count);
    
    visited[count] = node; // Add node to visited
    count++; // Increase the counter
    
    boolean isVisited = false; // Initialize visited flag
    
    NodeList childnodes = node.getChildNodes(); // Retrieve children
    
    // Find unvisited nodes and add them to visited
    for (int i = 0; i < childnodes.getLength(); i++) {
      for (int j = 0; j < visited.length; j++) {
        if (childnodes.item(i).isEqualNode(visited[j])) {
          isVisited = true; // Change visited flag
        }
      }
      if (!isVisited) { // If not visited, add node
        remainingNodes.add(childnodes.item(i));
      }
    }
  }
  
  // increaseSize Method (in case array is filled up)
  private void increaseSize () {
    size *= 2;
    Node[] temp = new Node[size];
    for (int i = 0; i < visited.length; i++) {
      temp[i] = visited[i];
    }
    visited = temp;
  }
  
  // Search Method
  public void search (ArrayList<Node> graph, Node start) {
    remainingNodes.add(start);
    while (!remainingNodes.isEmpty()) {
      Node n = remainingNodes.peek();
      visit(n);
    }
  }
}