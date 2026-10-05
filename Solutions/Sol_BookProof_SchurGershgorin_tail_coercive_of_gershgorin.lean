-- Generated from ChapterSchurGershgorinGap.lean — solution of BookProof.SchurGershgorin.tail_coercive_of_gershgorin
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
    (H : finiteModeDomain b →ₗ[ℂ] F) (hsym : SymmetricOn _ H) {m : ℕ} {mu : ℝ}
    (d r : ℕ → ℝ)
    (hdiag : ∀ i, m ≤ i → d i ≤ (entry b H i i).re)
    (hrow : ∀ i, m ≤ i → ∀ S : Finset ℕ, (∀ j ∈ S, m ≤ j) → i ∉ S →
      ∑ j ∈ S, ‖entry b H i j‖ ≤ r i)
    (hgap : ∀ i, m ≤ i → mu ≤ d i - r i)
    (w : finiteModeDomain b) (hw : (w : F) ∈ tailSpan b m) :
    mu * ‖(w : F)‖ ^ 2 ≤ quadForm H w :=
  quadForm_ge_of_gershgorin_on b H hsym {i | m ≤ i} d r (fun i hi => hdiag i hi)
      (fun i hi S hS hiS => hrow i hi S (fun _ hj => hS hj) hiS) (fun i hi => hgap i hi) w hw
