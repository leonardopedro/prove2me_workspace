import Mathlib
import Definitions.Def_ChapterFockSchurEsa

open BookProof.ChapterFockSchurEsa




open Matrix
open scoped ComplexConjugate


variable {¬ Summable fun k : ℕ => ‖(hopCol k) (k + 1)‖}


theorem hopCol_not_summable := by sorry
