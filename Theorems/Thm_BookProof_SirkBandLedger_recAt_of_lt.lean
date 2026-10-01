-- Generated from ChapterSirkBandLedger.lean — theorem BookProof.SirkBandLedger.recAt_of_lt
import Definitions.Def_ChapterSirkCertificateReader
import Definitions.Def_ChapterBandEnclosure
import Mathlib
import Definitions.Def_ChapterSirkBandLedger
open BookProof.SirkBandLedger



open BookProof.SirkCertificateReader
open BookProof.BandEnclosure

theorem BookProof.SirkBandLedger.recAt_of_lt {L : List BandRecord} {m : ℕ} (hm : m < L.length) :
    recAt L m = L.getD m default := by sorry
