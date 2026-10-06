-- Generated from ChapterE2.lean — theorem BookProof.ChapterE2.bornProb_sum_eq_one
import Mathlib
import Definitions.Def_ChapterE2
import Definitions.Def_ChapterDoubleSlit
open BookProof.ChapterDoubleSlit
open BookProof.ChapterE2


open scoped BigOperators
open Finset

theorem BookProof.ChapterE2.bornProb_sum_eq_one (θ : ℕ → ℝ) (n : ℕ) (hn : 1 ≤ n) :
    ∑ i : Fin n, bornProb θ n i = 1 := by sorry
