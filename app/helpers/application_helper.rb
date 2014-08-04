module ApplicationHelper
  def resource_path_meta_tags
    %w(parse_names_path repositories_path sources_path).map do |path|
      tag(:meta, name: path, content: send(path))
    end.join("\n").html_safe
  end
end
