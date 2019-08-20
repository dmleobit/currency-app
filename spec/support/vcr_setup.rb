VCR.configure do |c|
  c.register_request_matcher :uri_without_access_key, &VCR.request_matchers.uri_without_param(:access_key)

  c.register_request_matcher :uri_ignoring_date do |request_1, request_2|
    uri_1 = request_1.uri
    uri_2 = request_2.uri

    regexp_trail_id = /\d{4}\-\d{2}\-\d{2}/

    if uri1.match(regexp_trail_id)
      r1_without_id = uri1.gsub(regexp_trail_id, "")
      r2_without_id = uri2.gsub(regexp_trail_id, "")
      uri_1.match(regexp_trail_id) && uri_2.match(regexp_trail_id) && r1_without_id.eql?(r2_without_id)
    else
      uri_1.eql?(uri_2)
    end
  end

  c.cassette_library_dir = "spec/vcr"
  c.hook_into :webmock
end
