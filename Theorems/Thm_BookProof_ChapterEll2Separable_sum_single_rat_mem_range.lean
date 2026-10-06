-- Generated from ChapterEll2Separable.lean — theorem BookProof.ChapterEll2Separable.sum_single_rat_mem_range
import Mathlib
import Definitions.Def_ChapterEll2Separable
import Definitions.Def_ChapterRieszFischer
open BookProof.ChapterRieszFischer
open BookProof.ChapterEll2Separable


open Filter Finset
open scoped ENNReal


open BookProof.ChapterRieszFischer

theorem BookProof.ChapterEll2Separable.sum_single_rat_mem_range (s : Finset ℕ) (q : ℕ → ℚ) :
    (∑ i ∈ s, lp.single 2 i ((q i : ℝ))) ∈ Set.range ratVec := by sorry
