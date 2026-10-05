-- Generated from ChapterTruncationGapLift.lean — solution of BookProof.TruncationGapLift.exists_galerkin_tail_decomp
import Mathlib
import Definitions.Def_ChapterTruncationGapLift
import Theorems.Thm_BookProof_TruncationGapLift_galerkinSpan_sup_tailSpan
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
theorem solution (b : HilbertBasis ℕ ℂ F) (m : ℕ)
    {v : F} (hv : v ∈ finiteModeDomain b) :
    ∃ x ∈ galerkinSpan b m, ∃ w ∈ tailSpan b m, v = x + w := by

  rw [← galerkinSpan_sup_tailSpan b m, Submodule.mem_sup] at hv
  obtain ⟨x, hx, w, hw, hxw⟩ := hv
  exact ⟨x, hx, w, hw, hxw.symm⟩
