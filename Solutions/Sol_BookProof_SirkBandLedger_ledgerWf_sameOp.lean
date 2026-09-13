-- Generated from ChapterSirkBandLedger.lean — solution of BookProof.SirkBandLedger.ledgerWf_sameOp
import Mathlib
import Definitions.Def_ChapterSirkBandLedger
import Definitions.Def_ChapterSirkCertificateReader
import Definitions.Def_ChapterBandEnclosure
open BookProof.SirkBandLedger
















open BookProof.SirkCertificateReader
open BookProof.BandEnclosure

set_option maxHeartbeats 1000000 in
theorem solution {L : List BandRecord} (h : LedgerWf L) {r : BandRecord}
    (hr : r ∈ L) : r.op = (L.getD 0 default).op := by

  rw [LedgerWf, ledgerWfB] at h
  simp only [Bool.and_eq_true, List.all_eq_true, beq_iff_eq] at h
  exact h.1.1.1.2 r hr
