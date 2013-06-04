class LoadbalancersController < MVCLI::Controller
  requires :loadbalancers

  def index
    loadbalancers.all
  end

  def show
    balancer
  end

  def create
    #Add personalization options
    #Figure out what to do about load balancer address
    options = {
      name: "holder",
      port: 80,
      protocol: "HTTP",
      virtual_ips: [{
        type: "PUBLIC",
      }],
      nodes: [{
        address: "198.61.221.219",
        port: 80,
        condition: "ENABLED"
      }]
    }
    loadbalancers.create options
  end

  def destroy
    balancer.tap do |b|
      b.destroy
    end
  end

  private

  def balancer
    index.find {|s| s.name == params[:id]} or fail Fog::Erors::NotFound
  end
end
