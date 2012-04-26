class UserState < ActiveRecord::Base
  belongs_to :user

  attr_accessible :current_action_list_index, :current_action_list_id
  attr_accessible :temp_current_data
  attr_accessible :temp_highlight_start, :temp_highlight_length
  attr_accessible :current_position, :last_mark_position

  attr_accessible :user

  validates :user, :presence => true

  def current_action_list
    ActionList.find_by_id(current_action_list_id)
  end

  def reset_count(new_action_list_id)
    self.current_action_list_id = new_action_list_id
    self.current_action_list_index = 0
    self.current_position = 0
    self.last_mark_position = 0
    self.temp_highlight_start = 0
    self.temp_highlight_length = 0
  end

  def reset_text
    self.temp_current_data = current_action_list.datum.content
  end

  def reset(new_action_list_id)
    reset_count(new_action_list_id)
    reset_text
  end

  def invalid?
    #TODO: validate current_action_list_index normally
    current_action_list_index.nil? or current_action_list_index >= current_action_list.action_types.count
  end

  def in_progress?
    current_action_list_index > 0
  end
  
end
