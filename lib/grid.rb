
class Grid

	attr_reader :display, :defender, :coordinate_system

	def initialize(defender)
		@defender = defender
		@display = Array.new(10).map!{Array.new(10)}
	end

	def unmark_ships
		display.each {|row| row.map! {|element| element = nil if element == "S"}}
	end

	def mark_misses
		coordinate_system.existing_coordinates.each do |location|
			display[location.row - 1][location.column - 1] = "M" if location.miss?
		end
	end

	def mark(event)
		defender.ships.each do |ship|
			data = (event == :ships) ? ship.locations : ship.hit_locations
			mark = (event == :ships) ? "S" : "H"
			data.each(&grid_maker(mark))
		end
	end

	def grid_maker(mark)
		Proc.new {|location| self.display[location.row - 1][location.column - 1] = mark }
	end

	def pretty
		puts self.display.map(&:inspect)
	end

	def update_for(viewer)
		unmark_ships
		mark(:ships) if viewer == defender
		mark_misses
		mark(:hits)
		pretty
	end
end







