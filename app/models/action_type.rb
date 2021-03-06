class ActionType < ActiveRecord::Base
  default_scope order('position ASC')
  acts_as_citier

  belongs_to :action_list

  attr_accessible :action_list, :action_list_id, :position, :type

  validates :action_list, :presence => true
  validates :position, :presence => true
  #validates :arguments, :presence => true

  #TODO: figure out a better way to do this
  def self.get_action_types
    # this can't be a constant because we can't refer to types of subclasses before they exist
    [SearchActionType, CutActionType, PasteActionType,
     KeyPressActionType, SpecialKeyActionType, ModifiedKeyActionType,
     BeginActionType, EndActionType, WhileNoErrorActionType]
  end

  def self.my_type
    self.to_s
  end

  Argument = Struct.new :key, :name, :value

  def is_keypress?
    false
  end

  def self.factory_create(type_name, params=nil)
    get_action_types.each do |action_type_class|
      if action_type_class.to_s == type_name
        if params.nil?
          return action_type_class.new
        else
          specific_name = action_type_class.to_s.underscore
          new_params = 
            if params[:action_type].nil?
              params[specific_name]
            elsif params[specific_name].nil?
              params[:action_type]
            else
              params[:action_type].merge(params[specific_name])
            end
          return action_type_class.new(new_params)
        end
      end
    end
    nil
  end
end
