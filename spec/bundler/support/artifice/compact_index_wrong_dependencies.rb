# frozen_string_literal: true
require File.expand_path("../compact_index", __FILE__)

Artifice.deactivate

class CompactIndexWrongDependencies < CompactIndexAPI
  get "/info/:name" do
    etag_response do
      gem = gems.find {|g| g.name == params[:name] }
      gem.versions.each {|gv| gv.dependencies.clear } if gem
      CompactIndex.info(gem ? gem.versions : [])
    end
  end
end

Artifice.activate_with(CompactIndexWrongDependencies)
