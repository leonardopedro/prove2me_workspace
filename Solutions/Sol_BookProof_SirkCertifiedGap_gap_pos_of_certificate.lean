-- Generated from ChapterSirkCertifiedGap.lean — solution of BookProof.SirkCertifiedGap.gap_pos_of_certificate
import Mathlib
import Definitions.Def_ChapterSirkCertifiedGap
import Theorems.Thm_BookProof_SirkCertifiedGap_gap_ge_of_certificate
open BookProof.SirkCertifiedGap



noncomputable section


open scoped InnerProductSpace
open Finset Filter Topology
open BookProof.SirkFinitePrecision

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] [FiniteDimensional ℂ E]

set_option maxHeartbeats 1000000 in
)
    (hOdd : thetaO - deltaO ≤ sectorGround T P (-1)) :
    c.lower ≤ sectorGround T P (-1) - sectorGround T P 1 := by
  have h := certified_parity_gap (T := T) (P := P) hEven hOdd
  rw [GapCertificate.lower, hgap, hwidth]
  linarith

theorem solution {T P : E →ₗ[ℂ] E} (c : GapCertificate)
    {thetaE thetaO deltaE deltaO : ℝ}
    (hgap : c.ga :=
  p = thetaO - thetaE) (hwidth : c.width = deltaO + deltaE)
      (hEven : sectorGround T P 1 ≤
