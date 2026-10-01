-- Generated from ChapterSirkCertifiedGap.lean — theorem BookProof.SirkCertifiedGap.gap_pos_of_certificate
import Mathlib
import Definitions.Def_ChapterSirkCertifiedGap
open BookProof.SirkCertifiedGap

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] [FiniteDimensional ℂ E]


noncomputable section


open scoped InnerProductSpace
open Finset Filter Topology
open BookProof.SirkFinitePrecision

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] [FiniteDimensional ℂ E]

)
    (hOdd : thetaO - deltaO ≤ sectorGround T P (-1)) :
    c.lower ≤ sectorGround T P (-1) - sectorGround T P 1 := by
  have h := certified_parity_gap (T := T) (P := P) hEven hOdd
  rw [GapCertificate.lower, hgap, hwidth]
  linarith

theorem BookProof.SirkCertifiedGap.gap_pos_of_certificate {T P : E →ₗ[ℂ] E} (c : GapCertificate)
    {thetaE thetaO deltaE deltaO : ℝ}
    (hgap : c.ga := by sorry
