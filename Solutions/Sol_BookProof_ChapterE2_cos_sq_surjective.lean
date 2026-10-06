-- Generated from ChapterE2.lean — solution of BookProof.ChapterE2.cos_sq_surjective
import Mathlib
import Definitions.Def_ChapterE2
open BookProof.ChapterE2



open scoped BigOperators
open Finset

set_option maxHeartbeats 1000000 in
theorem solution {p : ℝ} (hp0 : 0 ≤ p) (hp1 : p ≤ 1) :
    ∃ t : ℝ, Real.cos t ^ 2 = p := by

  refine ⟨Real.arccos (Real.sqrt p), ?_⟩
  rw [Real.cos_arccos] <;> nlinarith [Real.sq_sqrt hp0, Real.sqrt_nonneg p]
