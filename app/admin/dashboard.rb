# frozen_string_literal: true
ActiveAdmin.register_page 'Dashboard' do
  menu priority: 1, label: proc { I18n.t('active_admin.dashboard') }

  content title: proc { I18n.t('active_admin.dashboard') } do
    columns do
      column do
        panel 'Device List' do
          table_for Device.all.limit(10).order(id: 'DESC') do
            column :device_id
            column :alarm_state
            column :device_type
            column 'Link to Show' do |device|
              link_to 'View Device', admin_device_path(device)
            end
          end
        end
      end

      column do
        panel 'Info' do
          para 'Welcome to SIAP Device Management Dashboard.'
          para "Current User: #{current_admin_user.email}"
        end
      end
    end
  end
end
