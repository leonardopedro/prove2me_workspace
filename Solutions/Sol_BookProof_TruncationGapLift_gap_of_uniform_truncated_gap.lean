-- Generated from ChapterTruncationGapLift.lean — solution of BookProof.TruncationGapLift.gap_of_uniform_truncated_gap
import Mathlib
import Definitions.Def_ChapterTruncationGapLift
import Theorems.Thm_BookProof_HermiteGalerkin_exists_mem_galerkinSpan
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
import Definitions.Def_ChapterFarisLavineCore
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
variable {D : Submodule ℂ F}

set_option maxHeartbeats 1000000 in
theorem solution (b : HilbertBasis ℕ ℂ F)
    (H : finiteModeDomain b →ₗ[ℂ] F) {mu : ℝ}
    (htrunc : ∀ m : ℕ, ∀ x : finiteModeDomain b, (x : F) ∈ galerkinSpan b m →
      mu * ‖(x : F)‖ ^ 2 ≤ quadForm H x)
    (v : finiteModeDomain b) : mu * ‖(v : F)‖ ^ 2 ≤ quadForm H v := by

  obtain ⟨m, hm⟩ := exists_mem_galerkinSpan b v.2
  exact htrunc m v hm
