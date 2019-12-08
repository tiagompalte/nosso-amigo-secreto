class CampaignRaffleJob < ApplicationJob
  queue_as :emails

  def perform(campaign)
    begin
      results = RaffleService.new(campaign).call

      campaign.members.each {|m| m.set_pixel}

      results.each do |r|
        CampaignMailer.raffle(campaign, r.first, r.last).deliver_now
      end

      campaign.update(status: :finished) if results != false

      raise 'Erro' if results == false
    rescue Exception => e
      CampaignMailer.raffle_failed(campaign, e).deliver_now
    end
  end
end