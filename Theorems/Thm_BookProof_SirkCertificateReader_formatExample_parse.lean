-- Generated from ChapterSirkCertificateReader.lean — theorem BookProof.SirkCertificateReader.formatExample_parse
import Mathlib
import Definitions.Def_ChapterSirkCertificateReader
open BookProof.SirkCertificateReader

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]



open BookProof.SirkCertifiedGap

theorem BookProof.SirkCertificateReader.formatExample_parse : parseCertificate formatExampleNdjson = some formatExampleData := by sorry
