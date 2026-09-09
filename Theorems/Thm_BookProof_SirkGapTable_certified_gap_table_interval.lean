-- Generated from ChapterSirkGapTable.lean — theorem BookProof.SirkGapTable.certified_gap_table_interval
import Mathlib
import Definitions.Def_ChapterSirkGapTable
open BookProof.SirkGapTable









noncomputable section


open BookProof.SirkCertifiedGap



variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]










variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]

theorem BookProof.SirkGapTable.certified_gap_table_interval {n : ℕ} (row : Fin n → CouplingCertificate)
    (T P : Fin n → E →ₗ[ℂ] E) (thetaE thetaO deltaE deltaO : Fin n → ℝ)
    (hgap : ∀ i, (row i).gap = thetaO i - thetaE i)
    (hwidth : ∀ i, (row i).width = deltaO i + deltaE i)
    (hEvenHi : ∀ i, sectorGround (T i) (P i) 1 ≤ thetaE i + deltaE i)
    (hEvenLo : ∀ i, thetaE i - deltaE i ≤ sectorGround (T i) (P i) 1)
    (hOddLo : ∀ i, thetaO i - deltaO i ≤ sectorGround (T i) (P i) (-1))
    (hOddHi : ∀ i, sectorGround (T i) (P i) (-1) ≤ thetaO i + deltaO i) :
    ∀ i, sectorGround (T i) (P i) (-1) - sectorGround (T i) (P i) 1
        ∈ Set.Icc (row i).lo (row i).hi := by sorry
