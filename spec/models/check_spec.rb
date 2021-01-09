# frozen_string_literal: true

require "rails_helper"

RSpec.describe Check, type: :model do
  it { is_expected.to belong_to(:integration) }
  it { is_expected.to belong_to(:user) }
  it { is_expected.to have_many(:counts).class_name("CheckCount") }
  it { is_expected.to validate_presence_of(:user_id) }

  describe ".last_counted_before" do
    it "returns checks with counts prior to timestamp" do
      check = create_check(counts: [{ created_at: 1.day.ago }])

      expect(described_class.last_counted_before(1.minute.ago)).to eq([check])
    end

    it "does not return checks with counts after the timestamp" do
      create_check(
        counts: [{ created_at: 5.minutes.ago }, { created_at: 3.days.ago }],
      )

      expect(described_class.last_counted_before(1.hour.ago)).to eq([])
    end

    it "returns checks with no counts" do
      check = create_check

      expect(described_class.last_counted_before(Time.zone.now)).to eq([check])
    end
  end

  describe "#refresh" do
    it "raises a NotImplementedError" do
      expect { described_class.new.refresh }
        .to raise_error(NotImplementedError)
    end
  end
end