-- Generated from ChapterTruncationGapLift.lean — solution of BookProof.TruncationGapLift.gap_of_le_ritzInf_and_tail
import Mathlib
import Definitions.Def_ChapterTruncationGapLift
import Theorems.Thm_BookProof_TruncationGapLift_gap_of_level_gap_and_tail
import Theorems.Thm_BookProof_TruncationGapLift_quadForm_ge_of_le_ritzInf_on
open BookProof.TruncationGapLift



noncomputable section


open BookProof.FarisLavine BookProof.HermiteGalerkin BookProof.BandEnclosure
open BookProof.FockSecondQuantization BookProof.FockOneParticleGap
open BookProof.FockNumberPreservingGap BookProof.FockInteractionStability
open BookProof.YangMillsHermite BookProof.HermiteProductCore
open BookProof.YangMillsFriedrichs BookProof.YangMillsFockGapChain

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {D : Submodule ℂ F}

set_option maxHeartbeats 1000000 in
theorem solution (b : HilbertBasis ℕ ℂ F)
    (H : finiteModeDomain b →ₗ[ℂ] F) (hsym : SymmetricOn _ H)
    (hpos : ∀ x : finiteModeDomain b, 0 ≤ quadForm H x) {m : ℕ} {mu eps : ℝ}
    (heps : 0 ≤ eps) (hritz : mu ≤ ritzInf H (galerkinSpan b m))
    (htail : ∀ w : finiteModeDomain b, (w : F) ∈ tailSpan b m →
      mu * ‖(w : F)‖ ^ 2 ≤ quadForm H w)
    (hcoup : ∀ x w : finiteModeDomain b, (x : F) ∈ galerkinSpan b m →
      (w : F) ∈ tailSpan b m →
      |(inner ℂ (x : F) (H w) : ℂ).re| ≤ eps * ‖(x : F)‖ * ‖(w : F)‖)
    (v : finiteModeDomain b) : (mu - eps) * ‖(v : F)‖ ^ 2 ≤ quadForm H v :=
  gap_of_level_gap_and_tail b H hsym heps
      (fun x hx => quadForm_ge_of_le_ritzInf_on H hpos hritz x hx) htail hcoup v
