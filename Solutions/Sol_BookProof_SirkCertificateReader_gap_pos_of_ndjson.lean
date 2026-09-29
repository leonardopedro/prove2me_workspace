-- Generated from ChapterSirkCertificateReader.lean — solution of BookProof.SirkCertificateReader.gap_pos_of_ndjson
import Mathlib
import Definitions.Def_ChapterSirkCertificateReader
import Theorems.Thm_BookProof_SirkCertificateReader_gap_ge_of_ndjson
import Definitions.Def_ChapterSirkCertifiedGap
open BookProof.SirkCertificateReader










open BookProof.SirkCertifiedGap




































variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]

set_option maxHeartbeats 1000000 in
theorem solution {T P : E →ₗ[ℂ] E} {s : String} {d : CertificateData} {lo : ℚ}
    (hd : parseCertificate s = some d) (hs : ndjsonLower s = some lo) (hpos : 0 < lo)
    (hEven : sectorGround T P 1 ≤ ((d.even.theta.toQ : ℚ) : ℝ) + ((d.even.delta.toQ : ℚ) : ℝ))
    (hOdd : ((d.odd.theta.toQ : ℚ) : ℝ) - ((d.odd.delta.toQ : ℚ) : ℝ) ≤ sectorGround T P (-1)) :
    sectorGround T P 1 < sectorGround T P (-1) := by

  have h := gap_ge_of_ndjson (T := T) (P := P) hd hs hEven hOdd
  have : (0 : ℝ) < ((lo : ℚ) : ℝ) := by exact_mod_cast hpos
  linarith
