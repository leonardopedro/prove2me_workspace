-- Generated from ChapterSirkCertificateReader.lean — solution of BookProof.SirkCertificateReader.toGapCertificate_lower
import Mathlib
import Definitions.Def_ChapterSirkCertificateReader
import Definitions.Def_ChapterSirkCertifiedGap
open BookProof.SirkCertificateReader










open BookProof.SirkCertifiedGap

set_option maxHeartbeats 1000000 in
theorem solution {d : CertificateData} {c : GapCertificate}
    (h : d.toGapCertificate = some c) : c.lower = ((d.lowerQ : ℚ) : ℝ) := by

  unfold CertificateData.toGapCertificate at h
  split at h
  · have hc := Option.some.inj h
    subst hc
    simp [GapCertificate.lower, CertificateData.lowerQ, CertificateData.gapQ,
      CertificateData.widthQ]
  · exact absurd h (by simp)
