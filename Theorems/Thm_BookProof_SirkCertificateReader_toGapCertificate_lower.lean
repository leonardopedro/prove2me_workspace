-- Generated from ChapterSirkCertificateReader.lean — theorem BookProof.SirkCertificateReader.toGapCertificate_lower
import Mathlib
import Definitions.Def_ChapterSirkCertificateReader
import Definitions.Def_ChapterGravityProjector
import Definitions.Def_ChapterSirkCertifiedGap
import Definitions.Def_ChapterSirkFinitePrecision
open BookProof.ChapterGravityProjector
open BookProof.SirkCertifiedGap
open BookProof.SirkFinitePrecision
open BookProof.SirkFinitePrecision.CertInterval
open BookProof.SirkCertificateReader



open BookProof.SirkCertifiedGap

theorem BookProof.SirkCertificateReader.toGapCertificate_lower {d : CertificateData} {c : GapCertificate}
    (h : d.toGapCertificate = some c) : c.lower = ((d.lowerQ : ℚ) : ℝ) := by sorry
