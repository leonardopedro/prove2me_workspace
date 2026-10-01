-- Generated from ChapterH5.lean — solution of BookProof.ChapterH5.inversion_free_seed
import Mathlib
import Definitions.Def_ChapterH5
open BookProof.ChapterH5



noncomputable section



variable {K E : Type*} [Field K] [AddCommGroup E] [Module K E]

set_option maxHeartbeats 1000000 in
theorem solution (S R : E →ₗ[K] E) (v₀ : E) (m : ℕ)
    (hR : R.comp S = LinearMap.id) :
    R ((S ^ (m + 1)) v₀) = (S ^ m) v₀ := by

  have hstep : ((S ^ (m + 1)) v₀) = S ((S ^ m) v₀) := by
    rw [pow_succ']; rfl
  rw [hstep]
  exact congrArg (fun f : E →ₗ[K] E => f ((S ^ m) v₀)) hR
