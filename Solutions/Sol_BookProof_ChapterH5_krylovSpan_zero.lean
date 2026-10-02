-- Generated from ChapterH5.lean — solution of BookProof.ChapterH5.krylovSpan_zero
import Mathlib
import Definitions.Def_ChapterH5
open BookProof.ChapterH5



noncomputable section



variable {K E : Type*} [Field K] [AddCommGroup E] [Module K E]

variable {K E : Type*} [Field K] [AddCommGroup E] [Module K E]
variable {H : E →ₗ[K] E} {v : E}

set_option maxHeartbeats 1000000 in
theorem solution : krylovSpan H v 0 = ⊥ := by

  rw [krylovSpan]
  convert Submodule.span_empty (R := K) (M := E)
  ext x
  simp
