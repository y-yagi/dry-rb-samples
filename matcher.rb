require "dry-matcher"

success_case = Dry::Matcher::Case.new(
  match: -> value { value.first == :ok },
  resolve: -> value { value.last }
)

failure_case = Dry::Matcher::Case.new(
  match: -> value, *pattern {
    value[0] == :err && (pattern.any? ? pattern.include?(value[1]) : true)
  },
  resolve: -> value { value.last }
)

other_case = Dry::Matcher::Case.new(
  match: -> value { true },
  resolve: -> value { value }
)

matcher = Dry::Matcher.new(success: success_case, failure: failure_case, other: other_case)

matcher.call([:ok, "success!"] ) do |m|
  m.success do |v|
    puts "Yay: #{v}"
  end

  m.failure :not_found do |v|
    puts "Oops, not found: #{v}"
  end

  m.failure do |v|
    puts "Boo: #{v}"
  end

  m.other do |v|
    puts "Other"
  end
end

matcher.call([:err, :not_found, 'failure']) do |m|
  m.success do |v|
    puts "Yay: #{v}"
  end

  m.failure :not_found do |v|
    puts "Oops, not found: #{v}"
  end

  m.failure do |v|
    puts "Boo: #{v}"
  end
end

matcher.call(["success!"] ) do |m|
  m.success do |v|
    puts "Yay: #{v}"
  end

  m.failure :not_found do |v|
    puts "Oops, not found: #{v}"
  end

  m.failure do |v|
    puts "Boo: #{v}"
  end

  m.other do |v|
    puts "Other"
  end
end
