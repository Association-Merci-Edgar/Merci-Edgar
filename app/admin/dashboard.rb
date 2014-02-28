ActiveAdmin.register_page "Dashboard" do

  menu :priority => 1, :label => proc{ I18n.t("active_admin.dashboard") }

  content :title => proc{ I18n.t("active_admin.dashboard") } do
    div :class => "blank_slate_container", :id => "dashboard_default_message" do
      span :class => "blank_slate" do
        span I18n.t("active_admin.dashboard_welcome.welcome")
        small I18n.t("active_admin.dashboard_welcome.call_to_action")
      end
    end

    # Here is an example of a simple dashboard with columns and panels.
    #
    columns do
    #   column do
    #     panel "Comptes actifs" do
    #       ul do
    #         Post.recent(5).map do |post|
    #           li link_to(post.title, admin_post_path(post))
    #         end
    #       end
    #     end
    #   end

      column do
        panel "Bienvenue" do
          nb_accounts = Account.featured.size
          what = 2
          median = Account.featured[((nb_accounts+1)/2)-1].contacts_count
          first_10 = Account.featured[((nb_accounts+1)/10)-1].contacts_count
          first_20 = Account.featured[((nb_accounts+1)/10)*2-1].contacts_count
          first_30 = Account.featured[((nb_accounts+1)/10)*3-1].contacts_count
          para "La mediane est #{median} // 1er decile #{first_10} // #{first_20} // #{first_30}"
        end
      end
      column do
        panel "Comptes actifs" do
          ul do
            Account.featured.limit(10).map do |account|
              user = account.abilitations.where(kind: "manager").map(&:user).first
              li link_to("#{account.name} (#{account.contacts_count})", admin_account_path(account)) + "  //  " +  link_to(user.to_s, admin_user_path(user))
            end
          end
        end
      end
    end
  end # content
end
