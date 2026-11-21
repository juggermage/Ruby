module ApplicationHelper
  # Пункт навігації Bootstrap із підсвічуванням активної сторінки
  def nav_link(text, path, **options)
    css = [ "nav-link", ("active" if current_page?(path)) ].compact.join(" ")
    tag.li(class: "nav-item") do
      link_to text, path, class: css, **options
    end
  end
end
