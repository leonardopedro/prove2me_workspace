-- Generated from ChapterNonnegUnitaryGroup.lean — solution of BookProof.NonnegUnitaryGroup.norm_unitaryU_sub_of_mem
import Mathlib
import Definitions.Def_ChapterNonnegUnitaryGroup
import Theorems.Thm_BookProof_NonnegUnitaryGroup_norm_expU_sub_self_le
import Theorems.Thm_BookProof_NonnegResolvent_norm_yosidaCLM_le_of_mem
open BookProof.NonnegUnitaryGroup




open BookProof.ClosureUniqueness BookProof.PositiveSquareRoot BookProof.NonnegSquareRoot
open BookProof.NonnegResolvent
open Filter Topology NormedSpace
open scoped InnerProductSpace

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable {B C : F →L[ℂ] F} {s t : ℝ}
variable {T : Submodule ℂ (F × F)} {a b : ℝ}

set_option maxHeartbeats 1000000 in
theorem solution (hT : IsNonnegSelfAdjoint T)
    (hsv : ∀ w : F, ((0 : F), w) ∈ T → w = 0) {h k : F} (hk : (h, k) ∈ T) (t : ℝ) :
    ‖unitaryU hT hsv t h - h‖ ≤ |t| * ‖k‖ := by

  have hf : Tendsto (fun n : ℕ => ‖approxU hT n t h - h‖) atTop
      (𝓝 ‖unitaryU hT hsv t h - h‖) :=
    ((tendsto_unitaryU hT hsv t h).sub tendsto_const_nhds).norm
  refine le_of_tendsto hf (Filter.Eventually.of_forall fun n => ?_)
  calc ‖approxU hT n t h - h‖ ≤ |t| * ‖yosidaAt hT n h‖ :=
        norm_expU_sub_self_le (isSelfAdjoint_yosidaAt hT n) t h
    _ ≤ |t| * ‖k‖ := by
        have := norm_yosidaCLM_le_of_mem hT (a := (n : ℝ) + 1) (by positivity) hk
        gcongr
        exact this
