-- Generated from ChapterF3.lean — theorem BookProof.ChapterF3.overlap_prod_pos
import Mathlib
import Definitions.Def_ChapterF3
open BookProof.ChapterF3


open scoped BigOperators
open Polynomial


noncomputable section

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]

theorem BookProof.ChapterF3.overlap_prod_pos {ι : Type*} (s : Finset ι) (w : ι → ℝ) (hw : ∀ i ∈ s, 0 < w i) :
    0 < ∏ i ∈ s, Real.sqrt (w i / (2 * Real.pi)) := by sorry
