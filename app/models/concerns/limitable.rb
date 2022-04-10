module Limitable
  extend ActiveSupport::Concern

  def limit_targets
    errors.add(:base, "Please, don't add more than 3 targets") if user.targets.size > 2
  end
end
