require 'rails_helper'
require 'sidekiq/testing'
RSpec.describe TargetExpirationJob, type: :job do
  let(:target) { create(:target) }
  let(:target2) { create(:target) }
  context 'when a target is expired' do
    before do
      Sidekiq::Testing.inline!
    end
    it 'should destroy the target' do
      TargetExpirationJob.perform_async(target.id)
      expect(Target.find_by(id: target.id)).to be_nil
    end
    it 'should not destroy the target if it has matches' do
      Match.create!(origin_target: target, end_target: target2)
      TargetExpirationJob.perform_async(target.id)
      expect(Target.find_by(id: target.id)).not_to be_nil
    end
    it 'should set the target to inactive' do
      Match.create!(origin_target: target, end_target: target2)
      TargetExpirationJob.perform_async(target.id)
      expect(Target.find_by(id: target.id).active).to be_falsey
    end
  end
end
