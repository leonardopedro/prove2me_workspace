-- Generated from ChapterSirkBandLedger.lean — solution of BookProof.SirkBandLedger.recAt_of_lt
import Mathlib
import Definitions.Def_ChapterSirkBandLedger
open BookProof.SirkBandLedger
















open BookProof.SirkCertificateReader
open BookProof.BandEnclosure

set_option maxHeartbeats 1000000 in
theorem solution {L : List BandRecord} {m : ℕ} (hm : m < L.length) :
    recAt L m = L.getD m default := by

  have h : min m (L.length - 1) = m := min_eq_left (by omega)
  simp [recAt, h]
