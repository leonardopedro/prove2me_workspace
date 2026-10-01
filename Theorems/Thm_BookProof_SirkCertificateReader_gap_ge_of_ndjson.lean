-- Generated from ChapterSirkCertificateReader.lean — theorem BookProof.SirkCertificateReader.gap_ge_of_ndjson
import Mathlib
import Definitions.Def_ChapterSirkCertificateReader
import Definitions.Def_ChapterSirkCertifiedGap
open BookProof.SirkCertifiedGap
open BookProof.SirkCertificateReader

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]



open BookProof.SirkCertifiedGap

theorem BookProof.SirkCertificateReader.gap_ge_of_ndjson {T P : E →ₗ[ℂ] E} {s : String} {d : CertificateData} {lo : ℚ}
    (hd : parseCertificate s = some d) (hs : ndjsonLower s = some lo)
    (hEven : sectorGround T P 1 ≤ ((d.even.theta.toQ : ℚ) : ℝ) + ((d.even.delta.toQ : ℚ) : ℝ))
    (hOdd : ((d.odd.theta.toQ : ℚ) : ℝ) - ((d.odd.delta.toQ : ℚ) : ℝ) ≤ sectorGround T P (-1)) :
    ((lo : ℚ) : ℝ) ≤ sectorGround T P (-1) - sectorGround T P 1 := by sorry
