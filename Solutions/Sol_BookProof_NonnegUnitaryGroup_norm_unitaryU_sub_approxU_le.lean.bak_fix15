-- Generated from ChapterNonnegUnitaryGroup.lean — solution of BookProof.NonnegUnitaryGroup.norm_unitaryU_sub_approxU_le
import Mathlib
import Definitions.Def_ChapterNonnegUnitaryGroup
import Theorems.Thm_BookProof_ChapterStoneResolvent_UnboundedSelfAdjoint_norm_approxU_sub_apply_le
import Theorems.Thm_BookProof_NonnegResolvent_tendsto_yosidaAt
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
    (hsv : ∀ w : F, ((0 : F), w) ∈ T → w = 0) {h k : F} (hk : (h, k) ∈ T) (m : ℕ) (t : ℝ) :
    ‖unitaryU hT hsv t h - approxU hT m t h‖ ≤ |t| * ‖k - yosidaAt hT m h‖ := by

  have hf : Tendsto (fun n : ℕ => ‖approxU hT n t h - approxU hT m t h‖) atTop
      (𝓝 ‖unitaryU hT hsv t h - approxU hT m t h‖) :=
    ((tendsto_unitaryU hT hsv t h).sub tendsto_const_nhds).norm
  have hg : Tendsto (fun n : ℕ => |t| * ‖yosidaAt hT n h - yosidaAt hT m h‖) atTop
      (𝓝 (|t| * ‖k - yosidaAt hT m h‖)) :=
    ((((tendsto_yosidaAt hT hsv hk).sub tendsto_const_nhds).norm).const_mul _)
  exact le_of_tendsto_of_tendsto' hf hg (fun n => norm_approxU_sub_apply_le hT n m t h)
