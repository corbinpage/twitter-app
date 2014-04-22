class WordType < ActiveRecord::Base
  has_many :words
  has_many :tweets, through: :words

  TECH_COMPANY_TOPICS = ["google","apple","microsoft","facebook","amazon"]
  TWUBBLE_TOPICS = ["affliction","agony","anguish","bad news","blues",
                    "catastrophe","crying","dejection","depression","desolation",
                    "despair","despondence","distress","doldrums","dolor","gloom",
                    "grief","grieving","guilt","hardship","heartache","heartbreak",
                    "lonely","melancholy","misery","misfortune","mourning","oppression",
                    "pain","regret","remorse","sadness","self-pity","shame","sorrow",
                    "suffering","torment","trouble","unhappiness","weeping ","woe",
                    "worry","wretched"]
end