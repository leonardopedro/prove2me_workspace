-- Generated from ChapterSirkCertifiedGap.lean — solution of BookProof.SirkCertifiedGap.qcdG2M4_certified_gap
import Mathlib
import Definitions.Def_ChapterSirkCertifiedGap
import Theorems.Thm_BookProof_SirkCertifiedGap_gap_ge_of_certificate
import Theorems.Thm_BookProof_SirkCertifiedGap_qcdG2M4_lower
open BookProof.SirkCertifiedGap











noncomputable section


open scoped InnerProductSpace
open Finset Filter Topology
open BookProof.SirkFinitePrecision

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] [FiniteDimensional ℂ E]

set_option maxHeartbeats 1000000 in
theorem solution {T P : E →ₗ[ℂ] E} {thetaE thetaO deltaE deltaO : ℝ}
    (hgap : thetaO - thetaE = 1.9875) (hwidth : deltaO + deltaE = 0.0555)
    (hEven : sectorGround T P 1 ≤ thetaE + deltaE)
    (hOdd : thetaO - deltaO ≤ sectorGround T P (-1)) :
    (1.932 : ℝ) ≤ sectorGround T P (-1) - sectorGround T P 1
      ∧ sectorGround T P 1 < sectorGround T P (-1) := by

  have hg : qcdG2M4.gap = thetaO - thetaE := by rw [hgap]; rfl
  have hw : qcdG2M4.width = deltaO + deltaE := by rw [hwidth]; rfl
  have h := gap_ge_of_certificate (T := T) (P := P) qcdG2M4 hg hw hEven hOdd
  rw [qcdG2M4_lower] at h
  exact ⟨h, by linarith⟩
