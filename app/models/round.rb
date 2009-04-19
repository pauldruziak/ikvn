class Round < ActiveRecord::Base
  belongs_to :season
  has_many :questions, :dependent => :destroy do
    def not_valid
      self.select do |question|
        !question.valid?
      end
    end
  end
  named_scope :published, :conditions => { :published => true }

  validates_presence_of :name, :start_responses_at, :end_responses_at, :start_assess_at, :end_assess_at

  def publish
    update_attribute("published", true)
  end

  def status
    status = :planned
    if published
      status = :next if start_responses_at > DateTime.now
      status = :current if start_responses_at < DateTime.now && DateTime.now < end_assess_at
      status = :completed if Time.now > end_assess_at
    end
    status
  end

  def current?
    status == :current
  end

  alias :open? :current?

  def previous
    Round.find :last, :limit => 1, :conditions => ["id < ?", self.id], :order => "id ASC"
  end

  def next
    Round.find :first, :limit => 1, :conditions => ["id > ?", self.id], :order => "id ASC"
  end


  protected
  def validate
    if (!start_responses_at.nil? && start_responses_at < DateTime.now - 1.minute)
      errors.add(:start_responses_at, I18n.t('activerecord.errors.messages.greater_than_today'))
      #errors.add(:start_responses_at, 'activerecord.errors.messages.greater_than_today')
    end
    if (!end_responses_at.nil? && end_responses_at < DateTime.now)
      errors.add(:end_responses_at, I18n.t('activerecord.errors.messages.greater_than_today'))
    end

    if (!start_assess_at.nil? && start_assess_at < DateTime.now)
      errors.add(:start_assess_at, I18n.t('activerecord.errors.messages.greater_than_today'))
    end

    if (!end_assess_at.nil? && end_assess_at < DateTime.now)
      errors.add(:end_assess_at, I18n.t('activerecord.errors.messages.greater_than_today'))
    end

    if (!start_responses_at.nil? && !end_responses_at.nil? && (start_responses_at > end_responses_at))
      errors.add(:end_responses_at, I18n.t('activerecord.errors.messages.greater_than_or_equal_to', :count => Round.human_attribute_name('start_responses_at')))
    end

    if (!start_assess_at.nil? && !end_assess_at.nil? && (start_assess_at > end_assess_at))
      errors.add(:end_assess_at, I18n.t('activerecord.errors.messages.greater_than_or_equal_to', :count => Round.human_attribute_name('start_assess_at')))
    end

    if (!end_responses_at.nil? && !start_assess_at.nil? && (end_responses_at > start_assess_at))
      errors.add(:start_assess_at, I18n.t('activerecord.errors.messages.greater_than_or_equal_to', :count => Round.human_attribute_name('end_responses_at')))
    end
  end

end

