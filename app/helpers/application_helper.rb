module ApplicationHelper
  def delete_link(path)
    link_to 'Delete',
            path,
            method: :delete,
            data: { confirm: "Are you sure?" }
  end
end
