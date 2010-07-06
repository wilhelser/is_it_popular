class RanksController < ApplicationController
  def show
    @page_rank = PageRank.find(params[:id])
  end

  def new
    @page_rank = PageRank.new
  end

  def create
    site = params[:page_rank][:site]
    @page_rank = PageRank.find_by_site(site)
    
    if @page_rank.nil?
      @page_rank = PageRank.create_with_stats(site)
    elsif @page_rank.updated_at > 5.days.ago
      @page_rank.update_with_stats
    end
    @page_rank.save
    
    redirect_to rank_path(@page_rank)
  end
end
