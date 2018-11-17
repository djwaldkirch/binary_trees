class Node
  attr_accessor :parent, :left_child, :right_child, :value
  def initialize(value)
    @value = value
    @left_child = nil
    @right_child = nil
  end
end

class Tree
  attr_accessor :root
  def initialize
    @root = nil
  end

  def add_node(value, current_node)

    if value < current_node.value
      if current_node.left_child.nil?
        current_node.left_child = Node.new(value)
        #puts "Made new left node"
      else
        current_node = current_node.left_child
        #puts "Moved down to the left"
        add_node(value, current_node)
      end
    else
      if current_node.right_child.nil?
        current_node.right_child = Node.new(value)
        #puts "Made new right node"
      else
        current_node = current_node.right_child
        #puts "Moved down to the right"
        add_node(value,current_node)
      end
    end
  end


  def build_tree(arr)
    @root = Node.new(arr[0])
    puts "The root is " + arr[0].to_s
    arr.shift
    until arr.length == 0
      #puts "The number is " + arr[0].to_s
      current_node = @root
      add_node(arr[0], current_node)
      arr.shift
    end
  end

  #this basically uses an array as a QUEUE to make a list of every node to search
  def breadth_first_search(v)
    if @root == nil
      puts "Tree is empty"
    end
    queue = [@root]
    current_node = @root
    while not queue.empty?
      current_node = queue[0]
      if current_node.value == v
        return "Found at node " + current_node.to_s
      end
      queue << current_node.left_child if not current_node.left_child.nil?
      queue << current_node.right_child if not current_node.right_child.nil?
      queue.shift
    end
    return "Value not found."
  end

  #this basically does the exact same thing except uses the array as a STACK
  def depth_first_search(v)
    if @root == nil
      puts "Tree is empty"
    end
    queue = [@root]
    current_node = @root
    while not queue.empty?
      current_node = queue[0]
      queue.unshift(current_node.left_child) unless current_node.left_child.nil?
      queue.unshift(current_node.right_child) unless current_node.right_child.nil?
      if current_node.value == v
        return "Found at node " + current_node.to_s
      end
      queue.shift
    end
    return "Value not found."
  end

  def depth_first_recursive(v, node=@root)
    if node.value == v
      return "Found at node " + node.to_s
    else
      left_check = depth_first_recursive(v, node.left_child) if node.left_child
      right_check = depth_first_recursive(v, node.right_child) if node.right_child
    end
    return left_check if left_check
    return right_check if right_check
    return "Value not found."
  end


end

tree = Tree.new
tree.build_tree([5,7,4,3,9,2,6])
puts tree.depth_first_search(4)
root = tree.root
puts tree.depth_first_recursive(12, root)
