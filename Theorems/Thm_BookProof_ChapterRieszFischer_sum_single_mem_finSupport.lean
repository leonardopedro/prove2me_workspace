-- Generated from ChapterRieszFischer.lean — theorem BookProof.ChapterRieszFischer.sum_single_mem_finSupport
import Mathlib
import Definitions.Def_ChapterRieszFischer
open BookProof.ChapterRieszFischer


open Filter
open scoped ENNReal

theorem BookProof.ChapterRieszFischer.sum_single_mem_finSupport (f : Ell2) (s : Finset ℕ) :
    (∑ i ∈ s, lp.single 2 i ((f : ℕ → ℝ) i)) ∈ FinSupport := by sorry
