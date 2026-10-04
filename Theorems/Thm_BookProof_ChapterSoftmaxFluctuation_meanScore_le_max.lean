-- Generated from ChapterSoftmaxFluctuation.lean — theorem BookProof.ChapterSoftmaxFluctuation.meanScore_le_max
import Mathlib
import Definitions.Def_ChapterSoftmaxFluctuation
import Definitions.Def_ChapterSoftmaxSharpness
import Definitions.Def_ChapterA4
open BookProof.ChapterSoftmaxSharpness
open BookProof.ChapterSoftmaxFluctuation

variable {m : ℕ}


open scoped BigOperators

noncomputable section




theorem BookProof.ChapterSoftmaxFluctuation.meanScore_le_max (beta : ℝ) (s : Fin m → ℝ) (i : Fin m)
    (hmax : ∀ l, s l ≤ s i) : meanScore beta s ≤ s i := by sorry
