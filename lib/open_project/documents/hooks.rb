module OpenProject::Documents
  class Hooks < Redmine::Hook::ViewListener
    render_on :activity_index_head,
              :partial => 'hooks/documents/activity_index_head'
  end
end
