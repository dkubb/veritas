require 'spec_helper'

describe 'Veritas::Algebra::Projection#directions' do
  subject { object.directions }

  let(:klass)    { Algebra::Projection                                                          }
  let(:relation) { Relation.new([ [ :id, Integer ], [ :name, String ] ], [ [ 1, 'Dan Kubb' ] ]) }
  let(:object)   { klass.new(operand, [ :id ])                                                  }

  context 'containing a relation' do
    let(:operand) { relation }

    it_should_behave_like 'an idempotent method'

    it { should be_kind_of(Relation::Operation::Order::DirectionSet) }

    it { should be_empty }
  end

  context 'containing an ordered relation' do
    let(:operand) { relation.order }

    it_should_behave_like 'an idempotent method'

    it { should be_kind_of(Relation::Operation::Order::DirectionSet) }

    it { should == [ operand[:id].asc ] }
  end
end
