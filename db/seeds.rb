require 'json'
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Article.create(name: "Mumps Artikel 1", idwiki: 22)
Article.create(name: "Krebs", idwiki: 144)
Article.create(name: "Tuberkulose Artikel 1", idwiki: 245)
Article.create(name: "Tuberkulose Artikel 2", idwiki: 235)
Article.create(name: "Tuberkulose Artikel 3", idwiki: 883)
Article.create(name: "Mumps Artikel 2", idwiki: 23)

Term.create(text: "Mumps", icd: "a01")
Term.create(text: "Bronchitis", icd: "b12")
Term.create(text: "Tuberkulose der Atmungsorgane", icd: "a15")

ArticleTermLink.create(article_id: 1, term_id: 1, ranking: 103)
ArticleTermLink.create(article_id: 6, term_id: 1, ranking: 66)
ArticleTermLink.create(article_id: 3, term_id: 3, ranking: 22)
ArticleTermLink.create(article_id: 4, term_id: 3, ranking: 2)
ArticleTermLink.create(article_id: 5, term_id: 3, ranking: 3)

json = File.read('AB_codes.json')
terms = JSON.parse(json)

terms.each do |term|
  text = term['text']
  code = term['code']
  Term.create(text: text, icd: code)
end
