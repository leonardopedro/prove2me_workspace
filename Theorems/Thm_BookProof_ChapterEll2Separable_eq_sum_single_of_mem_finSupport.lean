-- Generated from ChapterEll2Separable.lean — theorem BookProof.ChapterEll2Separable.eq_sum_single_of_mem_finSupport
import Mathlib
import Definitions.Def_ChapterEll2Separable
import Definitions.Def_ChapterRieszFischer
open BookProof.ChapterRieszFischer
open BookProof.ChapterEll2Separable


open Filter Finset
open scoped ENNReal


open BookProof.ChapterRieszFischer

theorem BookProof.ChapterEll2Separable.eq_sum_single_of_mem_finSupport (f : Ell2) {s : Finset ℕ}
    (hs : Function.support ((f : ℕ → ℝ)) ⊆ (s : Set ℕ)) :
    f = ∑ i ∈ s, lp.single 2 i ((f : ℕ → ℝ) i) := by sorry
