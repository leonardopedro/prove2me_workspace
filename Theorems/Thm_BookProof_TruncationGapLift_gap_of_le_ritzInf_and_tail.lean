-- Generated from ChapterTruncationGapLift.lean — theorem BookProof.TruncationGapLift.gap_of_le_ritzInf_and_tail
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
import Mathlib
import Definitions.Def_ChapterTruncationGapLift
import Definitions.Def_ChapterFarisLavineCore
import Definitions.Def_ChapterHermiteGalerkinFriedrichs
open BookProof.HermiteGalerkin
open BookProof.TruncationGapLift

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {D : Submodule ℂ F}


noncomputable section


open BookProof.FarisLavine BookProof.HermiteGalerkin BookProof.BandEnclosure
open BookProof.FockSecondQuantization BookProof.FockOneParticleGap
open BookProof.FockNumberPreservingGap BookProof.FockInteractionStability
open BookProof.YangMillsHermite BookProof.HermiteProductCore
open BookProof.YangMillsFriedrichs BookProof.YangMillsFockGapChain


theorem BookProof.TruncationGapLift.gap_of_le_ritzInf_and_tail (b : HilbertBasis ℕ ℂ F)
    (H : finiteModeDomain b →ₗ[ℂ] F) (hsym : SymmetricOn _ H)
    (hpos : ∀ x : finiteModeDomain b, 0 ≤ quadForm H x) {m : ℕ} {mu eps : ℝ}
    (heps : 0 ≤ eps) (hritz : mu ≤ ritzInf H (galerkinSpan b m))
    (htail : ∀ w : finiteModeDomain b, (w : F) ∈ tailSpan b m →
      mu * ‖(w : F)‖ ^ 2 ≤ quadForm H w)
    (hcoup : ∀ x w : finiteModeDomain b, (x : F) ∈ galerkinSpan b m →
      (w : F) ∈ tailSpan b m →
      |(inner ℂ (x : F) (H w) : ℂ).re| ≤ eps * ‖(x : F)‖ * ‖(w : F)‖)
    (v : finiteModeDomain b) : (mu - eps) * ‖(v : F)‖ ^ 2 ≤ quadForm H v := by sorry
