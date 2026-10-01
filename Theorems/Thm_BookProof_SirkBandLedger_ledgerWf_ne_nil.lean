-- Generated from ChapterSirkBandLedger.lean — theorem BookProof.SirkBandLedger.ledgerWf_ne_nil
import Definitions.Def_ChapterSirkCertificateReader
import Definitions.Def_ChapterBandEnclosure
import Mathlib
import Definitions.Def_ChapterSirkBandLedger
open BookProof.SirkBandLedger



open BookProof.SirkCertificateReader
open BookProof.BandEnclosure

theorem BookProof.SirkBandLedger.ledgerWf_ne_nil {L : List BandRecord} (h : LedgerWf L) : L ≠ [] := by sorry
