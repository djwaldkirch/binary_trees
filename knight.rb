class Square
  attr_accessor :pair, :parent, :child1, :child2, :child3, :child4, :child5, :child6, :child7, :child8

  def initialize(pair, parent=nil)
    @pair = pair
    @parent = parent
    @child1, @child2, @child3, @child4, @child5, @child6, @child7, @child8 = nil
  end
end

class Tree
  attr_accessor :root

  def initialize
    @root = nil
    @squares = nil
    @queue = []
  end

  def legal?(arr)
    arr[0].between?(1,8) && arr[1].between?(1,8)
  end

  def visited?(arr)
    @squares.include?(arr)
  end

  def add_one_child(cp)

    if cp.child1 == nil
      newpair = [cp.pair[0] + 2, cp.pair[1] + 1]
      if legal?(newpair) && !visited?(newpair)
        cp.child1 = Square.new(newpair)
        @squares << cp.child1.pair
        @queue << cp.child1
        cp.child1.parent = cp
      end
    end

    if cp.child2 == nil
      newpair = [cp.pair[0] + 2, cp.pair[1] - 1]
      if legal?(newpair) && !visited?(newpair)
        cp.child2 = Square.new(newpair)
        @squares << cp.child2.pair
        @queue << cp.child2
        cp.child2.parent = cp
      end
    end

    if cp.child3 == nil
      newpair = [cp.pair[0] - 2, cp.pair[1] + 1]
      if legal?(newpair) && !visited?(newpair)
        cp.child3 = Square.new(newpair)
        @squares << cp.child3.pair
        @queue << cp.child3
        cp.child3.parent = cp
      end
    end

    if cp.child4 == nil
      newpair = [cp.pair[0] - 2, cp.pair[1] - 1]
      if legal?(newpair) && !visited?(newpair)
        cp.child4 = Square.new(newpair)
        @squares << cp.child4.pair
        @queue << cp.child4
        cp.child4.parent = cp
      end
    end

    if cp.child5 == nil
      newpair = [cp.pair[0] + 1, cp.pair[1] + 2]
      if legal?(newpair) && !visited?(newpair)
        cp.child5 = Square.new(newpair)
        @squares << cp.child5.pair
        @queue << cp.child5
        cp.child5.parent = cp
      end
    end

    if cp.child6 == nil
      newpair = [cp.pair[0] + 1, cp.pair[1] - 2]
      if legal?(newpair) && !visited?(newpair)
        cp.child6 = Square.new(newpair)
        @squares << cp.child6.pair
        @queue << cp.child6
        cp.child6.parent = cp
      end
    end

    if cp.child7 == nil
      newpair = [cp.pair[0] - 1, cp.pair[1] + 2]
      if legal?(newpair) && !visited?(newpair)
        cp.child7 = Square.new(newpair)
        @squares << cp.child7.pair
        @queue << cp.child7
        cp.child7.parent = cp
      end
    end

    if cp.child8 == nil
      newpair = [cp.pair[0] - 1, cp.pair[1] - 2]
      if legal?(newpair) && !visited?(newpair)
        cp.child8 = Square.new(newpair)
        @squares << cp.child8.pair
        @queue << cp.child8
        cp.child8.parent = cp
      end
    end
  end

  def add_squares(cp)
    add_one_child(cp)
  end

  def build_tree(start)
    @root = Square.new(start)
    #set current position as the root
    cp = @root
    #add root to the visited squares
    @squares = [@root.pair]
    @queue = [@root]
    #add actual children moves/nodes
    until @squares.length == 64
      cp = @queue[0]
      add_squares(cp)
      @queue.shift
    end
  end

  def find_path(start, target)
    build_tree(start)
    matched = false
    queue = [@root]
    path = []
    until matched == true || queue.length == 0
      cp = queue[0]

      if cp.pair == target
        matched = true
        path << cp.pair
        until cp.pair == @root.pair
          cp = cp.parent
          path.unshift(cp.pair)
        end
        puts "You can make it in #{(path.length - 1)} moves!"
        puts "The path is " + path.inspect

      else
        queue << cp.child1 if cp.child1
        queue << cp.child2 if cp.child2
        queue << cp.child3 if cp.child3
        queue << cp.child4 if cp.child4
        queue << cp.child5 if cp.child5
        queue << cp.child6 if cp.child6
        queue << cp.child7 if cp.child7
        queue << cp.child8 if cp.child8
      end
      queue.shift
    end
  end

end

tree = Tree.new
tree.find_path([7,8], [3,1])
