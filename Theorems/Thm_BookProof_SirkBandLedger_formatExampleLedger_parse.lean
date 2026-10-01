-- Generated from ChapterSirkBandLedger.lean — theorem BookProof.SirkBandLedger.formatExampleLedger_parse
import Definitions.Def_ChapterSirkCertificateReader
import Definitions.Def_ChapterBandEnclosure
import Mathlib
import Definitions.Def_ChapterSirkBandLedger
open BookProof.SirkBandLedger

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]



open BookProof.SirkCertificateReader
open BookProof.BandEnclosure

theorem BookProof.SirkBandLedger.formatExampleLedger_parse :
    parseLedger formatExampleLedgerNdjson = formatExampleLedger := by sorry
