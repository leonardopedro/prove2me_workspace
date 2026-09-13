-- Generated from ChapterSirkGapTable.lean — solution of BookProof.SirkGapTable.strongCoupling_mem_of_certificate
import Mathlib
import Definitions.Def_ChapterSirkGapTable
import Theorems.Thm_BookProof_SirkCertifiedGap_certified_parity_gap
import Definitions.Def_ChapterSirkCertifiedGap
open BookProof.SirkGapTable










noncomputable section


open BookProof.SirkCertifiedGap



variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]










variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]

set_option maxHeartbeats 1000000 in
theorem solution {E : Type*} [NormedAddCommGroup E]
    [InnerProductSpace ℂ E] {T P : E →ₗ[ℂ] E} (c : CouplingCertificate)
    {thetaE thetaO deltaE deltaO : ℝ}
    (hgap : c.gap = thetaO - thetaE) (hwidth : c.width = deltaO + deltaE)
    (hEven : sectorGround T P 1 ≤ thetaE + deltaE)
    (hOdd : thetaO - deltaO ≤ sectorGround T P (-1))
    (hcons : c.strongCouplingConsistent) :
    c.lo ≤ sectorGround T P (-1) - sectorGround T P 1 ∧ c.lo ≤ strongCoupling c.g := by

  have h := certified_parity_gap (T := T) (P := P) hEven hOdd
  have hlo : c.lo ≤ sectorGround T P (-1) - sectorGround T P 1 := by
    simp only [CouplingCertificate.lo, hgap, hwidth]
    linarith
  exact ⟨hlo, hcons.1⟩
