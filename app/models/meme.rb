# == Schema Information
#
# Table name: memes
#
#  id         :integer          not null, primary key
#  image_url  :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Meme < ApplicationRecord
end
