-- Generated from ChapterSirkCertificateReader.lean — theorem BookProof.SirkCertificateReader.Decimal.toQ_nonneg
import Definitions.Def_ChapterSirkCertifiedGap
import Mathlib
import Definitions.Def_ChapterSirkCertificateReader
import Definitions.Def_ChapterSirkBandLedger
open BookProof.SirkBandLedger
open BookProof.SirkCertificateReader
open BookProof.SirkCertificateReader.Decimal



open BookProof.SirkCertifiedGap

theorem BookProof.SirkCertificateReader.Decimal.toQ_nonneg {d : Decimal} (h : 0 ≤ d.mant) : 0 ≤ d.toQ := by sorry
