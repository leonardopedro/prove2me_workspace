-- Generated from ChapterSirkGapTable.lean — solution of BookProof.SirkGapTable.gap_le_of_certificate
import Mathlib
import Definitions.Def_ChapterSirkGapTable
import Definitions.Def_ChapterSirkCertifiedGap
open BookProof.SirkGapTable










noncomputable section


open BookProof.SirkCertifiedGap



variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]

set_option maxHeartbeats 1000000 in
theorem solution {T P : E →ₗ[ℂ] E} {thetaE thetaO deltaE deltaO : ℝ}
    (hEven : thetaE - deltaE ≤ sectorGround T P 1)
    (hOdd : sectorGround T P (-1) ≤ thetaO + deltaO) :
    sectorGround T P (-1) - sectorGround T P 1 ≤ thetaO - thetaE + (deltaO + deltaE) := by

  linarith
