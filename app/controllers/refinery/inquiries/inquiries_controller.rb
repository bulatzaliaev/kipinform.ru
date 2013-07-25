#encoding utf-8
module Refinery
  module Inquiries
    class InquiriesController < ::ApplicationController

      before_filter :find_page, :only => [:create, :new]

      def thank_you
        @page = ::Refinery::Page.find_by_link_url("/contact/thank_you")
      end

      def new
        @inquiry = ::Refinery::Inquiries::Inquiry.new
        @inquiries = ::Refinery::Inquiries::Inquiry.all
      end

      def create
        @inquiry = ::Refinery::Inquiries::Inquiry.new(params[:inquiry])

        if @inquiry.save
          if @inquiry.ham?
            begin
              ::Refinery::Inquiries::InquiryMailer.notification(@inquiry, request).deliver
            rescue
              logger.warn "Error \n#{$!}\n"
            end

            begin
              ::Refinery::Inquiries::InquiryMailer.confirmation(@inquiry, request).deliver
            rescue
              logger.warn "Error:\n#{$!}\n"
            end if ::Refinery::Inquiries::Setting.send_confirmation?
          end

          redirect_to refinery.thank_you_inquiries_inquiries_path
        else
          render :action => 'new'
        end
      end

      #def show_inq
       # @inqs = ::Refinery::Inquiries::Inquiry.all
      #end

      protected

      def find_page
        @page = ::Refinery::Page.find_by_link_url("/contact")
      end

    end
  end
end
