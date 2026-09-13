-- Generated from ChapterSirkBandLedger.lean — solution of BookProof.SirkBandLedger.recAt_of_ge
import Mathlib
import Definitions.Def_ChapterSirkBandLedger
import Definitions.Def_ChapterSirkCertificateReader
import Definitions.Def_ChapterBandEnclosure
open BookProof.SirkBandLedger
















open BookProof.SirkCertificateReader
open BookProof.BandEnclosure

set_option maxHeartbeats 1000000 in
theorem solution {L : List BandRecord} {m : ℕ} (hm : L.length - 1 ≤ m) :
    recAt L m = recAt L (L.length - 1) := by

  simp [recAt, min_eq_right hm]
