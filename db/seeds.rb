require 'json'

Article.delete_all
Term.delete_all
ArticleTermLink.delete_all
Word.delete_all
Noun.delete_all
TermWordLink.delete_all


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

#Fill in the terms from external json
json = File.read('AB_codes.json')
terms = JSON.parse(json)

terms.each do |term|
  text = term['text']
  code = term['code']
  Term.create(text: text, icd: code)
end

#Fill up the word and noun tables based on the terms.
TermTokenizer.fill_word_tables

