require 'rails_helper'

RSpec.describe CampaignRaffleJob, type: :job do
  before :each do
    ActiveJob::Base.queue_adapter = :test
    @campaign = create(:campaign, status: :pending)
    create(:member, campaign: @campaign)
    create(:member, campaign: @campaign)
    create(:member, campaign: @campaign)
    @campaign.reload
  end

  describe '#perform_later' do
    it 'should have enqueued job' do
      expect { described_class.perform_later(@campaign) }.to have_enqueued_job
    end

    it 'should have enqueued job only once' do
      CampaignRaffleJob.perform_later(@campaign)
      expect(CampaignRaffleJob).to have_been_enqueued.exactly(:once)
    end

    it 'should have enqueued with campaign' do
      expect { CampaignRaffleJob.set(queue: 'email').perform_later(@campaign) }
          .to have_enqueued_job.with(@campaign).on_queue('email')
    end
  end
end