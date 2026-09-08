-- Generated from ChapterSirkCertificateReader.lean — solution of BookProof.SirkCertificateReader.gap_ge_of_ndjson
import Mathlib
import Definitions.Def_ChapterSirkCertificateReader
open BookProof.SirkCertificateReader










open BookProof.SirkCertifiedGap




































variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]

set_option maxHeartbeats 1000000 in
theorem solution {T P : E →ₗ[ℂ] E} {s : String} {d : CertificateData} {lo : ℚ}
    (hd : parseCertificate s = some d) (hs : ndjsonLower s = some lo)
    (hEven : sectorGround T P 1 ≤ ((d.even.theta.toQ : ℚ) : ℝ) + ((d.even.delta.toQ : ℚ) : ℝ))
    (hOdd : ((d.odd.theta.toQ : ℚ) : ℝ) - ((d.odd.delta.toQ : ℚ) : ℝ) ≤ sectorGround T P (-1)) :
    ((lo : ℚ) : ℝ) ≤ sectorGround T P (-1) - sectorGround T P 1 := by

  have hlo : lo = d.lowerQ := by
    rw [ndjsonLower, hd] at hs
    exact (Option.some_inj.mp hs.symm)
  have h := certified_parity_gap (T := T) (P := P) hEven hOdd
  rw [hlo]
  have : ((d.lowerQ : ℚ) : ℝ)
      = (((d.odd.theta.toQ : ℚ) : ℝ) - ((d.even.theta.toQ : ℚ) : ℝ))
        - (((d.odd.delta.toQ : ℚ) : ℝ) + ((d.even.delta.toQ : ℚ) : ℝ)) := by
    simp [CertificateData.lowerQ, CertificateData.gapQ, CertificateData.widthQ]
  rw [this]
  linarith
