-- Generated from ChapterSirkGapTable.lean — solution of BookProof.SirkGapTable.certified_gap_mem_interval
import Mathlib
import Definitions.Def_ChapterSirkGapTable
import Theorems.Thm_BookProof_SirkGapTable_gap_le_of_certificate
import Theorems.Thm_BookProof_SirkCertifiedGap_certified_parity_gap
import Definitions.Def_ChapterSirkCertifiedGap
open BookProof.SirkGapTable










noncomputable section


open BookProof.SirkCertifiedGap



variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]

set_option maxHeartbeats 1000000 in
theorem solution {T P : E →ₗ[ℂ] E} {thetaE thetaO deltaE deltaO : ℝ}
    (hEvenHi : sectorGround T P 1 ≤ thetaE + deltaE)
    (hEvenLo : thetaE - deltaE ≤ sectorGround T P 1)
    (hOddLo : thetaO - deltaO ≤ sectorGround T P (-1))
    (hOddHi : sectorGround T P (-1) ≤ thetaO + deltaO) :
    sectorGround T P (-1) - sectorGround T P 1 ∈
      Set.Icc (thetaO - thetaE - (deltaO + deltaE)) (thetaO - thetaE + (deltaO + deltaE)) := ⟨certified_parity_gap hEvenHi hOddLo, gap_le_of_certificate hEvenLo hOddHi⟩
