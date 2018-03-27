require 'google/apis/analyticsreporting_v4'

module Admin
  class PagesController < Admin::ApplicationController

    def stats
      analytics = Google::Apis::AnalyticsreportingV4::AnalyticsReportingService.new
      token = session[:user_token]
      analytics.authorization = session[:user_token] # See: https://github.com/zquestz/omniauth-google-oauth2
      p '- - - - - - - - - - - - - - token- - - - - - - - - - - - - - - -' 
      p token.inspect
      p ''

      date_range = Google::Apis::AnalyticsreportingV4::DateRange.new(start_date: '7DaysAgo', end_date: 'today')
      metric = Google::Apis::AnalyticsreportingV4::Metric.new(expression: 'ga:sessions', alias: 'sessions')
      dimension = Google::Apis::AnalyticsreportingV4::Dimension.new(name: 'ga:browser')

      request = Google::Apis::AnalyticsreportingV4::GetReportsRequest.new(
        report_requests: [Google::Apis::AnalyticsreportingV4::ReportRequest.new(
          view_id: 'VIEW_ID_FROM_ANALYTICS_PROPERTY',
           metrics: [metric],
           dimensions: [dimension],
           date_ranges: [date_range]
        )]
      ) # thanks to @9mm: https://github.com/google/google-api-ruby-client/issues/489

      response = analytics.batch_get_reports(request)
      rerere = response.reports
      p '- - - - - - - - - - - - - - rerere- - - - - - - - - - - - - - - -' 
      p rerere.inspect
      p ''
    end

    def rename
    end

    def archive
    end

    def loadrefdata
    end

    def load_ref_data
      Rails.application.load_seed
    end

    def archive_all_aids
      d  = Date.parse("2014-1-17")
      Aid.all.update_all("archived_at = '#{d}'")
      return
    end

    def unarchive_all_aids
      Aid.all.update_all("archived_at = null")
      return
    end

    def rename_eligible_value
      
      a = params.extract!(:initial_value).permit(:initial_value).to_h
      b = params.extract!(:final_value).permit(:final_value).to_h


      initial_value = a[:initial_value]

      
      final_value = b[:final_value]

      CustomRuleCheck.where(result: initial_value).update_all("result = '#{final_value}'")
    end
  end
end
