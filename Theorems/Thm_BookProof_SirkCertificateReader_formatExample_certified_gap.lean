-- Generated from ChapterSirkCertificateReader.lean — theorem BookProof.SirkCertificateReader.formatExample_certified_gap
import Mathlib
import Definitions.Def_ChapterSirkCertificateReader
open BookProof.SirkCertificateReader









open BookProof.SirkCertifiedGap




































variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]

theorem BookProof.SirkCertificateReader.formatExample_certified_gap {E : Type*} [NormedAddCommGroup E]
    [InnerProductSpace ℂ E] {T P : E →ₗ[ℂ] E}
    (hEven : sectorGround T P 1
        ≤ ((formatExampleData.even.theta.toQ : ℚ) : ℝ)
          + ((formatExampleData.even.delta.toQ : ℚ) : ℝ))
    (hOdd : ((formatExampleData.odd.theta.toQ : ℚ) : ℝ)
        - ((formatExampleData.odd.delta.toQ : ℚ) : ℝ) ≤ sectorGround T P (-1)) :
    (1.932 : ℝ) ≤ sectorGround T P (-1) - sectorGround T P 1
      ∧ sectorGround T P 1 < sectorGround T P (-1) := by sorry
