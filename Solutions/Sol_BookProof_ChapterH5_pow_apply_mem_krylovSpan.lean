-- Generated from ChapterH5.lean — solution of BookProof.ChapterH5.pow_apply_mem_krylovSpan
import Mathlib
import Definitions.Def_ChapterH5
open BookProof.ChapterH5



noncomputable section



variable {K E : Type*} [Field K] [AddCommGroup E] [Module K E]

variable {K E : Type*} [Field K] [AddCommGroup E] [Module K E]
variable {H : E →ₗ[K] E} {v : E}

set_option maxHeartbeats 1000000 in
theorem solution {i m : ℕ} (hi : i < m) :
    (H ^ i) v ∈ krylovSpan H v m := Submodule.subset_span ⟨i, hi, rfl⟩
