class CampaignMailer < ApplicationMailer

  def raffle(campaign, member, friend)
    @campaign = campaign
    @member = member
    @friend = friend
    mail to: @member.email, subject: "Nosso Amigo Secreto: #{@campaign.title}"
  end

  def raffle_failed(campaign, err)
    @campaign = campaign
    @errors = err

    mail to: @campaign.user.email,
         subject: "Erro ao enviar e-mail amigo secreto: #{@campaign.title}"
  end
end