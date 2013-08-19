require 'problem_destroy'

class ResolvedProblemClearer
  def initialize(keepdays=nil)
    @keepdays = keepdays
  end

  ##
  # Clear all problem already resolved
  #
  def execute
    nb_problem_resolved.tap { |nb|
      if nb > 0
        criteria.each do |problem|
          ProblemDestroy.new(problem).execute
        end
        repair_database
      end
    }
  end

  private

  def nb_problem_resolved
    @count ||= criteria.count
  end

  def criteria
    if @keepdays
      @criteria = Problem.resolved.where(:resolved_at.lt => DateTime.now - @keepdays)
    else
      @criteria = Problem.resolved
    end
    return @criteria
  end

  def repair_database
    Mongoid.config.master.command(:repairDatabase => 1)
  end
end
