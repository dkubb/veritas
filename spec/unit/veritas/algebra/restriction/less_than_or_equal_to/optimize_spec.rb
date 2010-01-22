require File.expand_path('../../../../../../spec_helper', __FILE__)

describe 'Veritas::Algebra::Restriction::LessThanOrEqualTo#optimize' do
  before do
    @attribute = Attribute::Integer.new(:id)
  end

  subject { @less_than_or_equal_to.optimize }

  describe 'left and right are equivalent attributes' do
    before do
      @less_than_or_equal_to = Algebra::Restriction::LessThanOrEqualTo.new(@attribute, @attribute)
    end

    it { should be_instance_of(Algebra::Restriction::True) }
  end

  describe 'left is an attribute' do
    before do
      @less_than_or_equal_to = Algebra::Restriction::LessThanOrEqualTo.new(@attribute, 1)
    end

    it { should equal(@less_than_or_equal_to) }
  end

  describe 'right is an attribute' do
    before do
      @less_than_or_equal_to = Algebra::Restriction::LessThanOrEqualTo.new(1, @attribute)
    end

    it { should equal(@less_than_or_equal_to) }
  end

  describe 'left and right are not attributes' do
    before do
      @less_than_or_equal_to = Algebra::Restriction::LessThanOrEqualTo.new(1, 1)
    end

    it { should be_instance_of(Algebra::Restriction::True) }
  end
end
