-- Generated from ChapterSirkGapTable.lean — theorem BookProof.SirkGapTable.certified_gap_table_interval
import Mathlib
import Definitions.Def_ChapterSirkGapTable
import Definitions.Def_ChapterSirkCertifiedGap
import Definitions.Def_ChapterSirkFinitePrecision
open BookProof.SirkCertifiedGap
open BookProof.SirkFinitePrecision
open BookProof.SirkFinitePrecision.CertInterval
open BookProof.SirkGapTable

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]


noncomputable section


open BookProof.SirkCertifiedGap

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
