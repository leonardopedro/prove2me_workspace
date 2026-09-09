-- Generated from ChapterSirkGapTable.lean — theorem BookProof.SirkGapTable.strongCoupling_mem_of_certificate
import Mathlib
import Definitions.Def_ChapterSirkGapTable
open BookProof.SirkGapTable









noncomputable section


open BookProof.SirkCertifiedGap



variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]










variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]

theorem BookProof.SirkGapTable.strongCoupling_mem_of_certificate {E : Type*} [NormedAddCommGroup E]
    [InnerProductSpace ℂ E] {T P : E →ₗ[ℂ] E} (c : CouplingCertificate)
    {thetaE thetaO deltaE deltaO : ℝ}
    (hgap : c.gap = thetaO - thetaE) (hwidth : c.width = deltaO + deltaE)
    (hEven : sectorGround T P 1 ≤ thetaE + deltaE)
    (hOdd : thetaO - deltaO ≤ sectorGround T P (-1))
    (hcons : c.strongCouplingConsistent) :
    c.lo ≤ sectorGround T P (-1) - sectorGround T P 1 ∧ c.lo ≤ strongCoupling c.g := by sorry
