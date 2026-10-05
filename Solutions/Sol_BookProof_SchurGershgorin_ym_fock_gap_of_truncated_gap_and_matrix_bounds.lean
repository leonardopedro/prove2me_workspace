-- Generated from ChapterSchurGershgorinGap.lean — solution of BookProof.SchurGershgorin.ym_fock_gap_of_truncated_gap_and_matrix_bounds
import Mathlib
import Definitions.Def_ChapterSchurGershgorinGap
import Theorems.Thm_BookProof_SchurGershgorin_gap_of_level_gap_and_matrix_bounds
import Theorems.Thm_BookProof_YangMillsFockGapChain_ym_fock_gap_of_one_particle_form_gap
import Theorems.Thm_BookProof_YangMillsHermite_ymHamiltonian_symmetricOn
open BookProof.SchurGershgorin



noncomputable section


open BookProof.FarisLavine BookProof.HermiteGalerkin BookProof.TruncationGapLift
open BookProof.FockSecondQuantization BookProof.FockOneParticleGap
open BookProof.YangMillsHermite BookProof.HermiteProductCore
open BookProof.YangMillsFriedrichs BookProof.YangMillsFockGapChain

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable (e : ℕ ≃ (Fin 99 →₀ ℕ)) (fabc : Fin 8 → Fin 8 → Fin 8 → ℝ)

set_option maxHeartbeats 1000000 in
theorem solution {m : ℕ} {mu eps : ℝ}
    (heps : 0 ≤ eps) (hmueps : 0 ≤ mu - eps) (d r : ℕ → ℝ)
    (htrunc : ∀ x : finiteModeDomain (coreBasis e),
      (x : L2d 99) ∈ galerkinSpan (coreBasis e) m →
      mu * ‖(x : L2d 99)‖ ^ 2 ≤ quadForm (ymHamiltonian (coreRepBasis e) fabc) x)
    (hdiag : ∀ i, m ≤ i →
      d i ≤ (entry (coreBasis e) (ymHamiltonian (coreRepBasis e) fabc) i i).re)
    (hrow : ∀ i, m ≤ i → ∀ S : Finset ℕ, (∀ j ∈ S, m ≤ j) → i ∉ S →
      ∑ j ∈ S, ‖entry (coreBasis e) (ymHamiltonian (coreRepBasis e) fabc) i j‖ ≤ r i)
    (hgap : ∀ i, m ≤ i → mu ≤ d i - r i)
    (hblockrow : ∀ i, i < m → ∀ S : Finset ℕ, (∀ j ∈ S, m ≤ j) →
      ∑ j ∈ S, ‖entry (coreBasis e) (ymHamiltonian (coreRepBasis e) fabc) i j‖ ≤ eps)
    (hblockcol : ∀ j, m ≤ j → ∀ S : Finset ℕ, (∀ i ∈ S, i < m) →
      ∑ i ∈ S, ‖entry (coreBasis e) (ymHamiltonian (coreRepBasis e) fabc) i j‖ ≤ eps) :
    dGamma (ymFockCol e fabc) vac = 0 ∧
      ∀ u : FockAlg, u 0 = 0 →
        (mu - eps) * ‖toLp u‖ ^ 2
          ≤ (inner ℂ (toLp u) (toLp (dGamma (ymFockCol e fabc) u)) : ℂ).re :=
  ym_fock_gap_of_one_particle_form_gap e fabc hmueps
      (gap_of_level_gap_and_matrix_bounds (coreBasis e) (ymHamiltonian (coreRepBasis e) fabc)
        (ymHamiltonian_symmetricOn (coreRepBasis e) fabc) heps d r htrunc hdiag hrow hgap
        hblockrow hblockcol)
