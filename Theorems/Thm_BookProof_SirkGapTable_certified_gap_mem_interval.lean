-- Generated from ChapterSirkGapTable.lean — theorem BookProof.SirkGapTable.certified_gap_mem_interval
import Mathlib
import Definitions.Def_ChapterSirkGapTable
open BookProof.SirkGapTable









noncomputable section


open BookProof.SirkCertifiedGap



variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]

theorem BookProof.SirkGapTable.certified_gap_mem_interval {T P : E →ₗ[ℂ] E} {thetaE thetaO deltaE deltaO : ℝ}
    (hEvenHi : sectorGround T P 1 ≤ thetaE + deltaE)
    (hEvenLo : thetaE - deltaE ≤ sectorGround T P 1)
    (hOddLo : thetaO - deltaO ≤ sectorGround T P (-1))
    (hOddHi : sectorGround T P (-1) ≤ thetaO + deltaO) :
    sectorGround T P (-1) - sectorGround T P 1 ∈
      Set.Icc (thetaO - thetaE - (deltaO + deltaE)) (thetaO - thetaE + (deltaO + deltaE)) := by sorry
