-- Generated from ChapterE.lean — solution of BookProof.ChapterE.cos_sq_surjective
import Mathlib
import Definitions.Def_ChapterE
open BookProof.ChapterE



open scoped Matrix BigOperators
open Filter
open scoped Topology

set_option maxHeartbeats 1000000 in
theorem solution {p : ℝ} (hp0 : 0 ≤ p) (hp1 : p ≤ 1) :
    ∃ t : ℝ, Real.cos t ^ 2 = p := by

  refine ⟨ Real.arccos ( Real.sqrt p ), ?_ ⟩
  rw [ Real.cos_arccos ] <;> nlinarith [ Real.mul_self_sqrt hp0 ]
