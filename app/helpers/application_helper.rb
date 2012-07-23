module ApplicationHelper

  ###
  # Construct a document title for the layout with possible
  # controller-specified prefix
  def document_title
    if content_for? :title
      content_for( :title ) + ' - ' + TITLE_SUFFIX
    else
      TITLE_SUFFIX
    end
  end

  
  ###
  # Construct a document title for the layout with possible
  # controller-specified prefix
  def page_title
    if content_for? :page_title
      content_for( :page_title )
    else
      DEFAULT_PAGE_TITLE
    end
  end

  
  ##
  # 
  def header_content
    if authenticated?
      render "layouts/site_search"
    end
  end


  ##
  #
  def sidebar_note
    if content_for? :sidebar_note
      content_for( :sidebar_note )
    end
  end


  def current_semester
    "F12"
  end

  ##############################################################################
  private

  # Application wide document title suffix
  TITLE_SUFFIX = "Graduate Student Services - Eberly Center - Carnegie Mellon University"

  # Application wide page title
  DEFAULT_PAGE_TITLE = "Graduate Student Services"

end
