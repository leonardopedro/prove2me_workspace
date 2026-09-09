-- Generated from ChapterSirkGapTable.lean — theorem BookProof.SirkGapTable.gap_le_of_certificate
import Mathlib
import Definitions.Def_ChapterSirkGapTable
open BookProof.SirkGapTable









noncomputable section


open BookProof.SirkCertifiedGap



variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]

theorem BookProof.SirkGapTable.gap_le_of_certificate {T P : E →ₗ[ℂ] E} {thetaE thetaO deltaE deltaO : ℝ}
    (hEven : thetaE - deltaE ≤ sectorGround T P 1)
    (hOdd : sectorGround T P (-1) ≤ thetaO + deltaO) :
    sectorGround T P (-1) - sectorGround T P 1 ≤ thetaO - thetaE + (deltaO + deltaE) := by sorry
