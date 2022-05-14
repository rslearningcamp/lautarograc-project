class TargetExpirationJob
  include Sidekiq::Job

  def perform(target_id)
    target = Target.find(target_id)
    target.update!(active: false)
    return if target.matches_from_origin.count.positive? || target.matches_to_end.count.positive?

    target.destroy!
  end
end
