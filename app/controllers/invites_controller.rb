class InvitesController < ApplicationController
  before_action :set_invite, only: %i[show edit update destroy]
  before_action :set_user, only: %i[create]
  def set_user
    invite_params[:user] = @user
  end

  # GET /invites or /invites.json
  def index
    @invites = Invite.all
  end

  # GET /invites/1 or /invites/1.json
  def show
  end

  # GET /invites/new
  def new
    @invite = Invite.new
  end

  # GET /invites/1/edit
  def edit
  end

  # POST /invites or /invites.json
  def create
    to_use = User.find(invite_params[:user])
    to_event = Event.find(invite_params[:event_id])
    @invite = Invite.create(user: to_use, event: to_event)

    respond_to do |format|
      if @invite.save
        format.html do
          redirect_to event_path(invite_params[:event_id]), notice: 'Invite was successfully created.'
        end
        format.json { render :show, status: :created, location: @invite }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @invite.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /invites/1 or /invites/1.json
  def update
    respond_to do |format|
      if @invite.update(invite_params)
        if @invite.status == 'declined'
          event = @invite.event
          user = @invite.user
          event.attendees.delete(user)
          @invite.destroy!
          puts "Invite destory? #{@invite.destroyed?}"
        end
        format.html { redirect_to user_path(current_user.id), notice: 'Invite was successfully updated.' }
        format.json { render :show, status: :ok, location: @invite }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @invite.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /invites/1 or /invites/1.json
  def destroy
    @invite.destroy!

    respond_to do |format|
      format.html { redirect_to invites_path, status: :see_other, notice: 'Invite was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_invite
    @invite = Invite.find(params.expect(:id))
  end

  # Only allow a list of trusted parameters through.
  def invite_params
    params.expect(invite: %i[status user event_id])
  end
end
