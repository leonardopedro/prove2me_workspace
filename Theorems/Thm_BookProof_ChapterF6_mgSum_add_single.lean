-- Generated from ChapterF6.lean — theorem BookProof.ChapterF6.mgSum_add_single
import Mathlib
import Definitions.Def_ChapterF6
open BookProof.ChapterF6

variable {α : Type*} [DecidableEq α]


open scoped BigOperators



theorem BookProof.ChapterF6.mgSum_add_single (T : α →₀ ℕ) (x : α) :
    mgSum (T + Finsupp.single x 1) = mgSum T + 1 := by sorry
