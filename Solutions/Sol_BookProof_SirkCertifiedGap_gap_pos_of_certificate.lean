-- Generated from ChapterSirkCertifiedGap.lean — solution of BookProof.SirkCertifiedGap.gap_pos_of_certificate
import Mathlib
import Definitions.Def_ChapterSirkCertifiedGap
import Theorems.Thm_BookProof_SirkCertifiedGap_gap_ge_of_certificate
import Definitions.Def_ChapterSirkFinitePrecision
open BookProof.SirkCertifiedGap











noncomputable section


open scoped InnerProductSpace
open Finset Filter Topology
open BookProof.SirkFinitePrecision

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] [FiniteDimensional ℂ E]

set_option maxHeartbeats 1000000 in
theorem solution {T P : E →ₗ[ℂ] E} (c : GapCertificate)
    {thetaE thetaO deltaE deltaO : ℝ}
    (hgap : c.gap = thetaO - thetaE) (hwidth : c.width = deltaO + deltaE)
    (hEven : sectorGround T P 1 ≤ thetaE + deltaE)
    (hOdd : thetaO - deltaO ≤ sectorGround T P (-1))
    (hpos : 0 < c.lower) :
    sectorGround T P 1 < sectorGround T P (-1) := by

  have h := gap_ge_of_certificate (T := T) (P := P) c hgap hwidth hEven hOdd
  linarith
