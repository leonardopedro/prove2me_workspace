-- Generated from ChapterF8.lean — theorem BookProof.ChapterF8.twoLevelHash_total
import Mathlib
import Definitions.Def_ChapterF8
import Definitions.Def_ChapterNavierStokesFockManyMode
open BookProof.NavierStokesFlow.FockManyMode
open BookProof.ChapterF8


noncomputable section

open scoped BigOperators

theorem BookProof.ChapterF8.twoLevelHash_total {d k K : ℕ} (h : Fin d → Fin k) (g : Fin k → Fin K)
    (x : Fin d → ℝ) : twoLevelHash h g x ∈ singleExcitation K := by sorry
