-- Generated from ChapterSirkBandLedger.lean — theorem BookProof.SirkBandLedger.nestedBands_of_wf
import Definitions.Def_ChapterSirkCertificateReader
import Mathlib
import Definitions.Def_ChapterSirkBandLedger
import Definitions.Def_ChapterBandEnclosure
open BookProof.BandEnclosure
open BookProof.SirkBandLedger



open BookProof.SirkCertificateReader
open BookProof.BandEnclosure

theorem BookProof.SirkBandLedger.nestedBands_of_wf {L : List BandRecord} (h : LedgerWf L) :
    NestedBands (ledgerLo L) (ledgerHi L) := by sorry
