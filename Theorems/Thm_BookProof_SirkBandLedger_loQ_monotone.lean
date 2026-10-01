-- Generated from ChapterSirkBandLedger.lean — theorem BookProof.SirkBandLedger.loQ_monotone
import Definitions.Def_ChapterSirkCertificateReader
import Definitions.Def_ChapterBandEnclosure
import Mathlib
import Definitions.Def_ChapterSirkBandLedger
open BookProof.SirkBandLedger



open BookProof.SirkCertificateReader
open BookProof.BandEnclosure

theorem BookProof.SirkBandLedger.loQ_monotone {L : List BandRecord} (h : LedgerWf L) : Monotone (loQ L) := by sorry
