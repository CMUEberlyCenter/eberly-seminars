class ParticipantsController < ApplicationController


  def index
    #@participants = Participant.all
    #if( !params[:term] )
    #  raise bar
    #end
    #ActiveRecord::Base.include_root_in_json = false
    @carnegie_people = CarnegieMellonPerson.generic_search(params[:term])
    #@carnegie_people = CarnegieMellonPerson.find_by_andrewid(params[:term])
    #raise foo
    #params[:term] = "foo"
    #respond_to do |format|
    #  format.js {
        #render :text =>           "[ { label: \"Choice1\", value: \"value1\" }, { label: \"Choice1\", value: \"value1\" }]"
    #render :json =>           "[ { label: \"Choice1\", value: \"value1\" }, { label: \"Choice2\", value: \"value2\" }]"
          #:andrew_users => @participants.collect {|p| p.as_json}"asdf" 
        #render :json => { :andrew_users => @participants.collect {|p| p.as_json} }
    #  }
    #end
    #render :json => "[ { \"label\": \"Choice1\", \"value\": \"value1\" }, { \"label\": \"Choice2\", \"value\": \"value2\" }]"

    render :json => @carnegie_people
    #render :text => @carnegie_people
    #render :json => "[ " + @carnegie_people.each{ |p| "{ \"label\": \"Choice1\", \"value\": \"value1\" },"  } + " ]"

    #render :json => @participants.collect { |p| "\{ \"label\" : #{p.id}, \"value\": \"#{p.andrewid}\" \}," }
    #render :json => { @participants.collect { |p| p.as_json

  end

end
