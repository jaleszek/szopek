module Payments
  class ResponseLog
    attr_reader :response

    def initialize(response)
      @response = response
    end
  end
end

# This class definitely should has database persistance and should store all information
# received from payments gateway.

# Choice of db storage here is problematic, so left without yet.

# At the first glance some NoSQL solution would be nice to storing this logs.
# Ability to grouping, searching for specific element of request can be provided
# by some dynamic data structure and it's argument against serializing.

# MongoDB is the first shot, is known as good solution for storing logs,
# but is also known from issues with data consistency on multiserver solutions especially.
# Moreover because of character this logs,
# and fact that in case of problems probably will be a arbitrary source of the judgement, other options
# should be considered also.
