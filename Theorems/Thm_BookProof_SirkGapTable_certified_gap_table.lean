-- Generated from ChapterSirkGapTable.lean — theorem BookProof.SirkGapTable.certified_gap_table
import Mathlib
import Definitions.Def_ChapterSirkGapTable
open BookProof.SirkGapTable









noncomputable section


open BookProof.SirkCertifiedGap



variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]










variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]

theorem BookProof.SirkGapTable.certified_gap_table {n : ℕ} (row : Fin n → CouplingCertificate)
    (T P : Fin n → E →ₗ[ℂ] E) (thetaE thetaO deltaE deltaO : Fin n → ℝ)
    (hgap : ∀ i, (row i).gap = thetaO i - thetaE i)
    (hwidth : ∀ i, (row i).width = deltaO i + deltaE i)
    (hEven : ∀ i, sectorGround (T i) (P i) 1 ≤ thetaE i + deltaE i)
    (hOdd : ∀ i, thetaO i - deltaO i ≤ sectorGround (T i) (P i) (-1)) :
    ∀ i, (row i).lo ≤ sectorGround (T i) (P i) (-1) - sectorGround (T i) (P i) 1 := by sorry
