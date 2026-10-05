-- Generated from ChapterA1b.lean — solution of BookProof.Complexification.Cx.realPart_isSubsystem
import Mathlib
import Definitions.Def_ChapterA1b
import Theorems.Thm_BookProof_Complexification_Cx_continuous_ofReal
import Theorems.Thm_BookProof_Complexification_Cx_mem_realPart
open BookProof.Complexification



open scoped RealInnerProductSpace
open BookProof.ChapterA


variable {W : Type*} [NormedAddCommGroup W] [InnerProductSpace ℝ W]

variable {W : Type*} [NormedAddCommGroup W] [InnerProductSpace ℝ W]
variable [CompleteSpace W]

set_option maxHeartbeats 1000000 in
theorem solution (M : System ℝ W) {X : Submodule ℂ (Cx W)}
    (hX : (cxSystem M).IsSubsystem X) : (M).IsSubsystem (realPart X) := by

  obtain ⟨hX_closed, hX_inv⟩ := hX
  refine ⟨?_, ?_⟩
  · convert hX_closed.preimage continuous_ofReal using 1
    ext w
    simp [realPart]
  · intro m hm w hw
    have hmap : cxMap m (ofReal w) = ofReal (m w) := by
      ext <;> simp [ofReal]
    have := hX_inv _ (Set.mem_image_of_mem _ hm) _ hw
    simpa [hmap] using this
