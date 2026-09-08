-- Generated from ChapterSirkCertificateReader.lean — solution of BookProof.SirkCertificateReader.formatExample_certified_gap
import Mathlib
import Definitions.Def_ChapterSirkCertificateReader
import Theorems.Thm_BookProof_SirkCertificateReader_gap_ge_of_ndjson
import Theorems.Thm_BookProof_SirkCertificateReader_formatExample_parse
import Theorems.Thm_BookProof_SirkCertificateReader_formatExample_lower
open BookProof.SirkCertificateReader










open BookProof.SirkCertifiedGap




































variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]

set_option maxHeartbeats 1000000 in
theorem solution {E : Type*} [NormedAddCommGroup E]
    [InnerProductSpace ℂ E] {T P : E →ₗ[ℂ] E}
    (hEven : sectorGround T P 1
        ≤ ((formatExampleData.even.theta.toQ : ℚ) : ℝ)
          + ((formatExampleData.even.delta.toQ : ℚ) : ℝ))
    (hOdd : ((formatExampleData.odd.theta.toQ : ℚ) : ℝ)
        - ((formatExampleData.odd.delta.toQ : ℚ) : ℝ) ≤ sectorGround T P (-1)) :
    (1.932 : ℝ) ≤ sectorGround T P (-1) - sectorGround T P 1
      ∧ sectorGround T P 1 < sectorGround T P (-1) := by

  have h := gap_ge_of_ndjson (T := T) (P := P) formatExample_parse formatExample_lower hEven hOdd
  have hcast : (((1932 / 1000 : ℚ)) : ℝ) = (1.932 : ℝ) := by norm_num
  rw [hcast] at h
  refine ⟨h, ?_⟩
  have : (0 : ℝ) < 1.932 := by norm_num
  linarith
