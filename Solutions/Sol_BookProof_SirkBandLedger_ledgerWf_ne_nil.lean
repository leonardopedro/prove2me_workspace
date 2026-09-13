-- Generated from ChapterSirkBandLedger.lean — solution of BookProof.SirkBandLedger.ledgerWf_ne_nil
import Mathlib
import Definitions.Def_ChapterSirkBandLedger
import Definitions.Def_ChapterSirkCertificateReader
import Definitions.Def_ChapterBandEnclosure
open BookProof.SirkBandLedger
















open BookProof.SirkCertificateReader
open BookProof.BandEnclosure

set_option maxHeartbeats 1000000 in
theorem solution {L : List BandRecord} (h : LedgerWf L) : L ≠ [] := by

  intro hnil
  rw [LedgerWf, ledgerWfB, hnil] at h
  simp at h
