-- Generated from ChapterA3e.lean — solution of BookProof.ChapterA3.lorentzLie_zero
import Mathlib
import Definitions.Def_ChapterA3e
open BookProof.ChapterA3



open Matrix

set_option maxHeartbeats 1000000 in
theorem solution : (0 : Matrix (Fin 4) (Fin 4) ℝ) ∈ LorentzLie := by

  simp [LorentzLie]
