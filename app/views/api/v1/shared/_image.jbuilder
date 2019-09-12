json.small image&.picture.present? ? "#{ENV["UPLOAD_SERVER"]}/#{image&.picture&.url(:small)}" : nil
json.medium image&.picture.present? ? "#{ENV["UPLOAD_SERVER"]}/#{image&.picture&.url(:medium)}" : nil
json.large image&.picture.present? ? "#{ENV["UPLOAD_SERVER"]}/#{image&.picture&.url(:large)}" : nil
json.orginal image&.picture.present? ? "#{ENV["UPLOAD_SERVER"]}/#{image&.picture&.url(:orginal)}" : nil