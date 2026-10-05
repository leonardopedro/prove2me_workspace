-- Generated from ChapterSchurGershgorinGap.lean — solution of BookProof.SchurGershgorin.gap_of_level_gap_and_matrix_bounds
import Mathlib
import Definitions.Def_ChapterSchurGershgorinGap
import Theorems.Thm_BookProof_SchurGershgorin_tail_coercive_of_gershgorin
import Theorems.Thm_BookProof_SchurGershgorin_coupling_bound_of_schur
import Theorems.Thm_BookProof_TruncationGapLift_gap_of_level_gap_and_tail
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
    (H : finiteModeDomain b →ₗ[ℂ] F) (hsym : SymmetricOn _ H) {m : ℕ} {mu eps : ℝ}
    (heps : 0 ≤ eps) (d r : ℕ → ℝ)
    (htrunc : ∀ x : finiteModeDomain b, (x : F) ∈ galerkinSpan b m →
      mu * ‖(x : F)‖ ^ 2 ≤ quadForm H x)
    (hdiag : ∀ i, m ≤ i → d i ≤ (entry b H i i).re)
    (hrow : ∀ i, m ≤ i → ∀ S : Finset ℕ, (∀ j ∈ S, m ≤ j) → i ∉ S →
      ∑ j ∈ S, ‖entry b H i j‖ ≤ r i)
    (hgap : ∀ i, m ≤ i → mu ≤ d i - r i)
    (hblockrow : ∀ i, i < m → ∀ S : Finset ℕ, (∀ j ∈ S, m ≤ j) →
      ∑ j ∈ S, ‖entry b H i j‖ ≤ eps)
    (hblockcol : ∀ j, m ≤ j → ∀ S : Finset ℕ, (∀ i ∈ S, i < m) →
      ∑ i ∈ S, ‖entry b H i j‖ ≤ eps)
    (v : finiteModeDomain b) : (mu - eps) * ‖(v : F)‖ ^ 2 ≤ quadForm H v :=
  gap_of_level_gap_and_tail b H hsym heps htrunc
      (tail_coercive_of_gershgorin b H hsym d r hdiag hrow hgap)
      (fun x w hx hw => coupling_bound_of_schur b H hblockrow hblockcol x w hx hw) v
