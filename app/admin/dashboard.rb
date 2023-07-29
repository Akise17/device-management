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
            column :location do |device|
              a device.location, href: device.location_url, target: '_blank'
            end
            column 'Action' do |device|
              links = []
              links << link_to('View Device', admin_device_path(device))
              links << link_to('Restart Device', api_v1_device_setting_path(device.device_id, 'restart'))
              links << link_to('Reset Sensor', api_v1_device_setting_path(device.device_id, 'reset_sensor'))
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
