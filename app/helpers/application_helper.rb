module ApplicationHelper
  def body_classes
    classes = []
    classes << controller.controller_name
    classes << controller.action_name
    classes.join ' '
  end
end