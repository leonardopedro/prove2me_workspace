-- Generated from ChapterA1b.lean — solution of BookProof.Complexification.Cx.complexify_isSubsystem
import Mathlib
import Definitions.Def_ChapterA1b
import Theorems.Thm_BookProof_Complexification_Cx_continuous_re
import Theorems.Thm_BookProof_Complexification_Cx_continuous_im
open BookProof.Complexification
open BookProof.Complexification.Cx



open scoped RealInnerProductSpace
open BookProof.ChapterA


variable {W : Type*} [NormedAddCommGroup W] [InnerProductSpace ℝ W]

variable {W : Type*} [NormedAddCommGroup W] [InnerProductSpace ℝ W]
variable [CompleteSpace W]

set_option maxHeartbeats 1000000 in
theorem solution (M : System ℝ W) {Y : Submodule ℝ W}
    (hY : (M).IsSubsystem Y) : (cxSystem M).IsSubsystem (complexify Y) := by

  refine ⟨?_, ?_⟩
  · convert IsClosed.inter (hY.1.preimage continuous_re) (hY.1.preimage continuous_im) using 1
    ext w
    simp [complexify]
  · rintro _ ⟨m, hm, rfl⟩ w hw
    exact ⟨by simpa [cxMap_apply] using hY.2 m hm w.re hw.1,
      by simpa [cxMap_apply] using hY.2 m hm w.im hw.2⟩
