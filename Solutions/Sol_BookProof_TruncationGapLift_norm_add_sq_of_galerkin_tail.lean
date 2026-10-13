-- Generated from ChapterTruncationGapLift.lean — solution of BookProof.TruncationGapLift.norm_add_sq_of_galerkin_tail
import Mathlib
import Definitions.Def_ChapterTruncationGapLift
import Theorems.Thm_BookProof_TruncationGapLift_inner_eq_zero_of_mem_galerkin_tail
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterBandEnclosure
import Definitions.Def_ChapterFockSecondQuantization
import Definitions.Def_ChapterFockOneParticleGap
import Definitions.Def_ChapterFockNumberPreservingGap
import Definitions.Def_ChapterFockInteractionStability
import Definitions.Def_ChapterYangMillsHermite
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterYangMillsFriedrichs
import Definitions.Def_ChapterYangMillsFockGapChain
import Definitions.Def_ChapterHermiteGalerkinFriedrichs
open BookProof.TruncationGapLift



noncomputable section


open BookProof.FarisLavine BookProof.HermiteGalerkin BookProof.BandEnclosure
open BookProof.FockSecondQuantization BookProof.FockOneParticleGap
open BookProof.FockNumberPreservingGap BookProof.FockInteractionStability
open BookProof.YangMillsHermite BookProof.HermiteProductCore
open BookProof.YangMillsFriedrichs BookProof.YangMillsFockGapChain
open BookProof.HermiteGalerkin

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

set_option maxHeartbeats 1000000 in
theorem solution (b : HilbertBasis ℕ ℂ F) {m : ℕ}
    {x w : F} (hx : x ∈ galerkinSpan b m) (hw : w ∈ tailSpan b m) :
    ‖x + w‖ ^ 2 = ‖x‖ ^ 2 + ‖w‖ ^ 2 := by

  have h := norm_add_sq_eq_norm_sq_add_norm_sq_of_inner_eq_zero x w
    (inner_eq_zero_of_mem_galerkin_tail b hx hw)
  simpa [pow_two] using h
