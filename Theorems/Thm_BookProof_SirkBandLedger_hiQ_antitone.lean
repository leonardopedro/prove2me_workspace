-- Generated from ChapterSirkBandLedger.lean — theorem BookProof.SirkBandLedger.hiQ_antitone
import Definitions.Def_ChapterSirkCertificateReader
import Definitions.Def_ChapterBandEnclosure
import Mathlib
import Definitions.Def_ChapterSirkBandLedger
open BookProof.SirkBandLedger



open BookProof.SirkCertificateReader
open BookProof.BandEnclosure

theorem BookProof.SirkBandLedger.hiQ_antitone {L : List BandRecord} (h : LedgerWf L) : Antitone (hiQ L) := by sorry
