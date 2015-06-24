module RedmineNewUserActivation
  class Activator

    def self.activate_pending_users
      User.pending.ready_to_activate
        .find_each do |u|
            u.activation_date = nil
            u.activate!
            Mailer.account_information(u, u.password).deliver
      end
    end

  end
end
