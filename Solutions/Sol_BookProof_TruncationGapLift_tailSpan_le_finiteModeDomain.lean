-- Generated from ChapterTruncationGapLift.lean — solution of BookProof.TruncationGapLift.tailSpan_le_finiteModeDomain
import Mathlib
import Definitions.Def_ChapterTruncationGapLift
open BookProof.TruncationGapLift



noncomputable section


open BookProof.FarisLavine BookProof.HermiteGalerkin BookProof.BandEnclosure
open BookProof.FockSecondQuantization BookProof.FockOneParticleGap
open BookProof.FockNumberPreservingGap BookProof.FockInteractionStability
open BookProof.YangMillsHermite BookProof.HermiteProductCore
open BookProof.YangMillsFriedrichs BookProof.YangMillsFockGapChain

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

set_option maxHeartbeats 1000000 in
theorem solution (b : HilbertBasis ℕ ℂ F) (m : ℕ) :
    tailSpan b m ≤ finiteModeDomain b := Submodule.span_mono (by rintro x ⟨i, _, rfl⟩; exact ⟨i, rfl⟩)
