module Veritas
  class Relation
    module Operation
      class Order
        class DirectionSet
          extend Forwardable
          include Enumerable

          def_delegator :self, :union, :|

          def initialize(directions)
            @directions = Array(directions).map do |direction|
              Ascending.coerce(direction)
            end
          end

          def project(attributes)
            new select { |direction|
              attributes.include?(direction.attribute)
            }
          end

          def rename(aliases)
            new map { |direction|
              name = aliases[direction.attribute.name]
              name ? direction.rename(name) : direction
            }
          end

          def reverse
            new map { |direction| direction.invert }
          end

          def each(&block)
            to_ary.each(&block)
            self
          end

          def to_ary
            @directions
          end

          def union(other)
            new(to_ary | other.to_ary)
          end

          def attributes
            map { |direction| direction.attribute }
          end

          def sort_tuples(tuples)
            tuples.sort { |left, right| cmp_tuples(left, right) }
          end

          def ==(other)
            other = self.class.coerce(other)
            to_ary == other.to_ary
          end

          def eql?(other)
            instance_of?(other.class) &&
            to_ary.eql?(other.to_ary)
          end

          def hash
            @hash ||= to_ary.hash
          end

          def empty?
            @directions.empty?
          end

        private

          def new(directions)
            self.class.new(directions)
          end

          def cmp_tuples(left, right)
            each do |direction|
              cmp = direction.call(left, right)
              return cmp if cmp.nonzero?
            end
          end

          def self.coerce(object)
            object.kind_of?(DirectionSet) ? object : new(object)
          end

        end # class DirectionSet
      end # class Order
    end # module Operation
  end # class Relation
end # module Veritas
