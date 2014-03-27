require 'json'

# Article.delete_all
Term.delete_all
ArticleTermLink.delete_all
Word.delete_all
TermNoun.delete_all
TermWordLink.delete_all

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

