require_relative 'cell.rb'

class Knight

    MOVES = [[-2, 1], [-1, 2], [1, 2], [2, 1],
    [2, -1], [1, -2], [-1, -2], [-2, -1]].freeze

    def initialize(start, destination)
        @board = Array.new(8) {Array.new(8)}
        knight_moves(start, destination)
    end

    private

    def knight_moves(start, destination)
        build_tree(start)
        target_cell = @board[destination[0]][destination[1]]
        return if target_cell.nil?

        target_cell.path
        puts "You made it in #{target_cell.path.length - 1} moves!"
        puts 'Your path is: '
        p target_cell.path
    end

    def build_tree(start, board = @board)
        starting_cell = Cell.new(start[0], start[1])
        queue = []
        queue.unshift(starting_cell)
        until queue.empty?
            current = queue.pop
            possible_moves = find_possible_moves([current.x, current.y])
            next if possible_moves.nil?

            possible_moves.each do |move|
                next unless board[move[0]][move[1]].nil?

                linked_cell = Cell.new(move[0], move[1])
                current.edges << linked_cell
                linked_cell.path = current.path + linked_cell.path
                board[move[0]][move[1]] = linked_cell
                queue.unshift(linked_cell)
            end
        end
        starting_cell
    end

    def valid_move?(pos)
        return false unless (0..7).include?(pos[0]) && (0..7).include?(pos[1])
        true
    end

    def find_possible_moves(pos)
        possible_moves = MOVES.collect {|move| [pos[0] + move[0], pos[1] + move[1]]}
        possible_moves.select! {|move| valid_move?(move)}
        possible_moves
    end
end

test1 = Knight.new([3,3],[0,0])
test2 = Knight.new([0,1],[7,6])