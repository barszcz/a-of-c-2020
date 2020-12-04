(defn part-1 []
  (let [file (string/trim (slurp "input/day1.txt"))
        lines (string/split "\n" file)
        numbers (map scan-number lines)]
    (loop [x :in numbers
           y :in numbers
           :when (= 2020 (+ x y))]
           (print (* x y))
           )))

(defn part-2 []
  (let [file (string/trim (slurp "input/day1.txt"))
        lines (string/split "\n" file)
        numbers (map scan-number lines)]
    (loop [x :in numbers
           y :in numbers
           z :in numbers
           :when (= 2020 (+ x y z))]
           (print (* x y z))
           )))

(part-1)
(part-2)
