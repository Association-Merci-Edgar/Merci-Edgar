# == Schema Information
#
# Table name: tasks
#
#  id           :integer          not null, primary key
#  name         :string(255)
#  priority     :integer
#  category     :string(255)
#  bucket       :string(255)
#  due_at       :datetime
#  completed_at :datetime
#  asset_id     :integer
#  asset_type   :string(255)
#  assigned_to  :integer
#  completed_by :integer
#  account_id   :integer
#  user_id      :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Task < ActiveRecord::Base
  attr_accessible :bucket, :assigned_to, :user_id, :name, :asset_id, :asset_type, :calendar, :specific_time
  belongs_to :user
  belongs_to :asset, polymorphic: true
  belongs_to :assignee, class_name: "User", foreign_key: :assigned_to
  belongs_to :completor, class_name: "User", foreign_key: :completed_by
  default_scope { where(:account_id => Account.current_id).order('tasks.due_at ASC') }
  
  attr_accessor :calendar
  

  validates :user, :name, presence: true

  scope :tracked_by, lambda { |user| where('user_id = ? OR assigned_to = ?', user.id, user.id) }

  scope :pending,       where('completed_at IS NULL').order('tasks.due_at, tasks.id')
  scope :assigned,      where('completed_at IS NULL AND assigned_to IS NOT NULL').order('tasks.due_at, tasks.id')
  scope :completed,     where('completed_at IS NOT NULL').order('tasks.completed_at DESC')

  scope :overdue,       lambda { where('due_at IS NOT NULL AND due_at < ?', Time.zone.now.midnight.utc).order('tasks.due_at ASC') }
  scope :due_today,     lambda { where('due_at >= ? AND due_at < ?', Time.zone.now.midnight.utc, Time.zone.now.midnight.tomorrow.utc).order('tasks.due_at ASC') }
  scope :due_tomorrow,  lambda { where('due_at >= ? AND due_at < ?', Time.zone.now.midnight.tomorrow.utc, Time.zone.now.midnight.tomorrow.utc + 1.day).order('tasks.due_at ASC') }
  scope :due_this_week, lambda { where('due_at >= ? AND due_at < ?', Time.zone.now.midnight.tomorrow.utc + 1.day, Time.zone.now.next_week.utc).order('tasks.due_at ASC') }
  scope :due_next_week, lambda { where('due_at >= ? AND due_at < ?', Time.zone.now.next_week.utc, Time.zone.now.next_week.end_of_week.utc + 1.day).order('tasks.due_at ASC') }
  scope :due_this_month, lambda { where('due_at >= ? AND due_at < ?', Time.zone.now.next_week.end_of_week.utc + 1.day, Time.zone.now.end_of_month.utc + 1.day).order('tasks.due_at ASC') }
  scope :due_later,     lambda { where("(due_at IS NULL AND bucket = 'due_later') OR due_at >= ?", Time.zone.now.next_week.end_of_week.utc + 1.day).order('tasks.due_at ASC') }

  def asset_type=(sType)
    super(sType.to_s.classify.constantize.base_class.to_s)
  end

  def complete(user)
    self.completor = user
    self.completed_at = Time.zone.now
    save
  end

  def assign_to(user)
    self.assignee = user
    save
  end

  def assignee_name
    self.assignee.name if self.assignee
  end

  def bucket
    return nil if self.due_at.blank? || self.specific_time
    case
    when self.due_at < Time.zone.now
      "overdue"
    when self.due_at >= Time.zone.now.midnight && self.due_at < Time.zone.now.midnight.tomorrow
      "due_today"
    when self.due_at >= Time.zone.now.midnight.tomorrow && self.due_at < Time.zone.now.midnight.tomorrow + 1.day
      "due_tomorrow"
    when self.due_at >= (Time.zone.now.midnight.tomorrow + 1.day) && self.due_at < Time.zone.now.next_week
      "due_this_week"
    when self.due_at >= Time.zone.now.next_week && self.due_at < (Time.zone.now.next_week.end_of_week + 1.day)
      "due_next_week"
    else
      "due_later"
    end
  end

  def bucket=(s)
    self.specific_time = false
    self.due_at = case s
    when "overdue"
      Time.zone.now.end_of_day.yesterday
    when "due_today"
      Time.zone.now.end_of_day
    when "due_tomorrow"
      Time.zone.now.end_of_day.tomorrow
    when "due_this_week"
      Time.zone.now.end_of_day.end_of_week
    when "due_next_week"
      Time.zone.now.end_of_day.next_week.end_of_week
    when "due_this_month"
      Time.zone.now.end_of_day.end_of_month
    when "due_later"
      Time.zone.now.midnight + 100.years
    else # due_later or due_asap
      nil
    end
  end

  def calendar=(s)
    if s.present?
      self.due_at = Time.strptime(s,'%d/%m/%Y %H:%M')
      self.specific_time = true
    end
  end

  def calendar
    self.due_at.in_time_zone.strftime("%d/%m/%Y %H:%M") if self.due_at && specific_time
  end

  def friendly_date
    case
    when self.due_at < Time.zone.now
      "overdue"
    when self.due_at >= Time.zone.now.midnight && self.due_at < Time.zone.now.midnight.tomorrow
      self.due_at.in_time_zone.strftime("Aujourd'hui %H:%M")
    when self.due_at >= Time.zone.now.midnight.tomorrow && self.due_at < Time.zone.now.midnight.tomorrow + 1.day
      "due_tomorrow"
    when self.due_at >= (Time.zone.now.midnight.tomorrow + 1.day) && self.due_at < Time.zone.now.next_week
      self.due_at.strftime("%A")
    when self.due_at >= Time.zone.now.next_week && self.due_at < (Time.zone.now.next_week.end_of_week + 1.day)
      "due_next_week"
    else
      "due_later"
    end
  end

  def to_ics
    event = Icalendar::Event.new
    event.start = self.due_at.strftime("%Y%m%dT%H%M%S")
    event.summary = self.name
    event.last_modified = self.updated_at.strftime("%Y%m%dT%H%M%S")
    event
  end

end
