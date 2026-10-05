-- Generated from ChapterYangMillsCertificateSeam.lean — solution of BookProof.YangMillsCertificateSeam.example_ym_fock_gap
import Mathlib
import Definitions.Def_ChapterYangMillsCertificateSeam
import Theorems.Thm_BookProof_YangMillsCertificateSeam_ym_fock_gap_of_matrix_certificate
import Theorems.Thm_BookProof_YangMillsCertificateSeam_example_checkBounds
import Theorems.Thm_BookProof_YangMillsCertificateSeam_example_lower
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
theorem solution
    (htrunc : ∀ x : finiteModeDomain (coreBasis e),
      (x : L2d 99) ∈ galerkinSpan (coreBasis e) exampleRecord.m →
      ((exampleRecord.muQ : ℚ) : ℝ) * ‖(x : L2d 99)‖ ^ 2
        ≤ quadForm (ymHamiltonian (coreRepBasis e) fabc) x)
    (hdiag : ∀ i, exampleRecord.m ≤ i →
      ((exampleRecord.dminQ : ℚ) : ℝ)
        ≤ (entry (coreBasis e) (ymHamiltonian (coreRepBasis e) fabc) i i).re)
    (hrow : ∀ i, exampleRecord.m ≤ i → ∀ S : Finset ℕ, (∀ j ∈ S, exampleRecord.m ≤ j) → i ∉ S →
      ∑ j ∈ S, ‖entry (coreBasis e) (ymHamiltonian (coreRepBasis e) fabc) i j‖
        ≤ ((exampleRecord.rmaxQ : ℚ) : ℝ))
    (hblockrow : ∀ i, i < exampleRecord.m → ∀ S : Finset ℕ, (∀ j ∈ S, exampleRecord.m ≤ j) →
      ∑ j ∈ S, ‖entry (coreBasis e) (ymHamiltonian (coreRepBasis e) fabc) i j‖
        ≤ ((exampleRecord.epsQ : ℚ) : ℝ))
    (hblockcol : ∀ j, exampleRecord.m ≤ j → ∀ S : Finset ℕ, (∀ i ∈ S, i < exampleRecord.m) →
      ∑ i ∈ S, ‖entry (coreBasis e) (ymHamiltonian (coreRepBasis e) fabc) i j‖
        ≤ ((exampleRecord.epsQ : ℚ) : ℝ)) :
    dGamma (ymFockCol e fabc) vac = 0 ∧
      ∀ u : FockAlg, u 0 = 0 →
        (1.902 : ℝ) * ‖toLp u‖ ^ 2
          ≤ (inner ℂ (toLp u) (toLp (dGamma (ymFockCol e fabc) u)) : ℂ).re := by

  have h := ym_fock_gap_of_matrix_certificate e fabc exampleRecord example_checkBounds
    htrunc hdiag hrow hblockrow hblockcol
  have hcast : ((exampleRecord.lowerQ : ℚ) : ℝ) = (1.902 : ℝ) := by
    rw [example_lower]
    norm_num
  rwa [hcast] at h
