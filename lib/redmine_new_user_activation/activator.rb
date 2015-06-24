require_dependency 'user'

module RedmineNewUserActivation
  class Activator

    def self.activate_pending_users
      User.status(User::STATUS_PENDING)
        .find_each do |u|
          if activation_date && activation_date.to_date == Date.today
            u.activate!
            Mailer.account_information(u, u.password).deliver if params[:send_information]
          end
      end
    end

  end
end
