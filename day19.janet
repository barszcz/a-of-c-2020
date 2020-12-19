(defn split-lines [x] (string/split "\n" x))
(defn p [x] (printf "%q" x))

(defn compile-char [c] c)
(defn compile-seq [& seq] ~(* ,;(map keyword seq)))
(defn compile-choice [c1 c2] ~(+ ,(compile-seq ;c1) ,(compile-seq ;c2)))

(def grammar-grammar ~{
  :rule-num (cmt (<- :d+) ,keyword)
  :rule-char (* `"` (<- :a) `"`)
  :rule-seq (some (* (<- :d+) (? " ")))
  :rule-choice (* (group :rule-seq) "| " (group :rule-seq))
  :rule (+ (cmt :rule-char ,compile-char) (cmt :rule-choice ,compile-choice) (cmt :rule-seq ,compile-seq))
  :main (* :rule-num ": " :rule)
})

(defn compile-rule [rule] (peg/match grammar-grammar rule))

(defn compile-grammar [rules]
  (let [compiled-rules (mapcat compile-rule rules)
        grammar-struct (struct ;compiled-rules :main '(<- :0))]
    (peg/compile grammar-struct)))

(defn exact-match [patt s]
  (if-let [matches (peg/match patt s)
          match (0 matches)]
          (= match s)))

(defn part-1 []
  (let [raw (slurp "input/day19.txt")
        [rules-raw inputs-raw] (string/split "\n\n" raw)
        rules (split-lines rules-raw)
        inputs (split-lines inputs-raw)
        grammar (compile-grammar rules)]
        (count |(exact-match grammar $) inputs)))

(p (part-1))