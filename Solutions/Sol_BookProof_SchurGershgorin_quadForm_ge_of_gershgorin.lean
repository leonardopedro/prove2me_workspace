-- Generated from ChapterSchurGershgorinGap.lean — solution of BookProof.SchurGershgorin.quadForm_ge_of_gershgorin
import Mathlib
import Definitions.Def_ChapterSchurGershgorinGap
import Theorems.Thm_BookProof_SchurGershgorin_quadForm_ge_of_gershgorin_on
open BookProof.SchurGershgorin



noncomputable section


open BookProof.FarisLavine BookProof.HermiteGalerkin BookProof.TruncationGapLift
open BookProof.FockSecondQuantization BookProof.FockOneParticleGap
open BookProof.YangMillsHermite BookProof.HermiteProductCore
open BookProof.YangMillsFriedrichs BookProof.YangMillsFockGapChain

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

set_option maxHeartbeats 1000000 in
theorem solution (b : HilbertBasis ℕ ℂ F)
    (H : finiteModeDomain b →ₗ[ℂ] F) (hsym : SymmetricOn _ H) {mu : ℝ} (d r : ℕ → ℝ)
    (hdiag : ∀ i, d i ≤ (entry b H i i).re)
    (hrow : ∀ i, ∀ S : Finset ℕ, i ∉ S → ∑ j ∈ S, ‖entry b H i j‖ ≤ r i)
    (hgap : ∀ i, mu ≤ d i - r i) (v : finiteModeDomain b) :
    mu * ‖(v : F)‖ ^ 2 ≤ quadForm H v := by

  refine quadForm_ge_of_gershgorin_on b H hsym Set.univ d r (fun i _ => hdiag i)
    (fun i _ S _ hiS => hrow i S hiS) (fun i _ => hgap i) v ?_
  have : (b '' Set.univ) = Set.range b := Set.image_univ
  rw [this]
  exact v.2
