-- Generated from ChapterYangMillsCertificateSeam.lean — solution of BookProof.YangMillsCertificateSeam.ym_fock_mass_gap_of_matrix_certificate
import Mathlib
import Definitions.Def_ChapterYangMillsCertificateSeam
import Theorems.Thm_BookProof_YangMillsCertificateSeam_valid_of_checkBounds
import Theorems.Thm_BookProof_SchurGershgorin_ym_fock_mass_gap_of_truncated_gap_and_matrix_bounds
open BookProof.YangMillsCertificateSeam



noncomputable section


open BookProof.SirkCertificateReader
open BookProof.SchurGershgorin
open BookProof.FarisLavine BookProof.HermiteGalerkin BookProof.TruncationGapLift
open BookProof.FockSecondQuantization BookProof.FockOneParticleGap
open BookProof.YangMillsHermite BookProof.HermiteProductCore
open BookProof.YangMillsFriedrichs BookProof.YangMillsFockGapChain

variable (e : ℕ ≃ (Fin 99 →₀ ℕ)) (fabc : Fin 8 → Fin 8 → Fin 8 → ℝ)

set_option maxHeartbeats 1000000 in
theorem solution (c : MatrixBoundRecord)
    (hchk : c.checkBounds = true)
    (htrunc : ∀ x : finiteModeDomain (coreBasis e),
      (x : L2d 99) ∈ galerkinSpan (coreBasis e) c.m →
      ((c.muQ : ℚ) : ℝ) * ‖(x : L2d 99)‖ ^ 2 ≤ quadForm (ymHamiltonian (coreRepBasis e) fabc) x)
    (hdiag : ∀ i, c.m ≤ i →
      ((c.dminQ : ℚ) : ℝ) ≤ (entry (coreBasis e) (ymHamiltonian (coreRepBasis e) fabc) i i).re)
    (hrow : ∀ i, c.m ≤ i → ∀ S : Finset ℕ, (∀ j ∈ S, c.m ≤ j) → i ∉ S →
      ∑ j ∈ S, ‖entry (coreBasis e) (ymHamiltonian (coreRepBasis e) fabc) i j‖
        ≤ ((c.rmaxQ : ℚ) : ℝ))
    (hblockrow : ∀ i, i < c.m → ∀ S : Finset ℕ, (∀ j ∈ S, c.m ≤ j) →
      ∑ j ∈ S, ‖entry (coreBasis e) (ymHamiltonian (coreRepBasis e) fabc) i j‖
        ≤ ((c.epsQ : ℚ) : ℝ))
    (hblockcol : ∀ j, c.m ≤ j → ∀ S : Finset ℕ, (∀ i ∈ S, i < c.m) →
      ∑ i ∈ S, ‖entry (coreBasis e) (ymHamiltonian (coreRepBasis e) fabc) i j‖
        ≤ ((c.epsQ : ℚ) : ℝ)) :
    (∃ (Dom : Submodule ℂ Fock) (A : Dom →ₗ[ℂ] Fock),
        IsPositiveSelfAdjointExtension (dGammaOp (ymFockCol e fabc)) A) ∧
      dGamma (ymFockCol e fabc) vac = 0 ∧
      ∀ u : FockAlg, u 0 = 0 → u ≠ 0 →
        0 < (inner ℂ (toLp u) (toLp (dGamma (ymFockCol e fabc) u)) : ℂ).re := by

  obtain ⟨heps, hlt, hdom⟩ := valid_of_checkBounds hchk
  have hepsR : (0 : ℝ) ≤ ((c.epsQ : ℚ) : ℝ) := by exact_mod_cast heps
  have hltR : ((c.epsQ : ℚ) : ℝ) < ((c.muQ : ℚ) : ℝ) := by exact_mod_cast hlt
  have hdomR : ((c.muQ : ℚ) : ℝ) ≤ ((c.dminQ : ℚ) : ℝ) - ((c.rmaxQ : ℚ) : ℝ) := by
    have : ((c.muQ : ℚ) : ℝ) ≤ (((c.dminQ - c.rmaxQ : ℚ)) : ℝ) := by exact_mod_cast hdom
    simpa using this
  exact ym_fock_mass_gap_of_truncated_gap_and_matrix_bounds e fabc hepsR hltR
    (fun _ => ((c.dminQ : ℚ) : ℝ)) (fun _ => ((c.rmaxQ : ℚ) : ℝ))
    htrunc (fun i hi => hdiag i hi) (fun i hi => hrow i hi)
    (fun _ _ => hdomR) hblockrow hblockcol
