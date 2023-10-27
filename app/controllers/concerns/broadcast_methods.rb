module BroadcastMethods
  def broadcast_toast(toast_type, notice)
    current_user
      .broadcast_append_to("toasts:account-#{current_account.id}",
                           target: 'broadcast',
                           partial: "shared/toasts/#{toast_type}",
                           locals: {
                             message: notice,
                             dismiss: 3000
                           })
  end
end