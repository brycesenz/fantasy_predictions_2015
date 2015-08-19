require 'spec_helper'

describe Player do
  # Associations
  #----------------------------------------------------------------------------
  describe "associations", associations: true do
  end

  # Attributes
  #----------------------------------------------------------------------------
  describe "attributes", attributes: true do
    describe "id" do
      it "is nil for new" do
        player = described_class.new
        expect(player.id).to be_nil
      end

      it "is set on create" do
        player = described_class.create(name: "test")
        expect(player.id).to be_present
      end
    end

    describe "name" do
    end
  end
end