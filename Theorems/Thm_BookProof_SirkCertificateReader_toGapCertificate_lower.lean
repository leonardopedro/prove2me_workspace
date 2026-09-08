-- Generated from ChapterSirkCertificateReader.lean — theorem BookProof.SirkCertificateReader.toGapCertificate_lower
import Mathlib
import Definitions.Def_ChapterSirkCertificateReader
open BookProof.SirkCertificateReader









open BookProof.SirkCertifiedGap

theorem BookProof.SirkCertificateReader.toGapCertificate_lower {d : CertificateData} {c : GapCertificate}
    (h : d.toGapCertificate = some c) : c.lower = ((d.lowerQ : ℚ) : ℝ) := by sorry
