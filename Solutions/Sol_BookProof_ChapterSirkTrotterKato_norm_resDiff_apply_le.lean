-- Generated from ChapterSirkTrotterKato.lean — solution of BookProof.ChapterSirkTrotterKato.norm_resDiff_apply_le
import Mathlib
import Definitions.Def_ChapterSirkTrotterKato
import Definitions.Def_ChapterStoneResolvent
open BookProof.ChapterSirkTrotterKato











noncomputable section

open Filter Topology Asymptotics
open scoped InnerProductSpace


open BookProof.ChapterStoneResolvent

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]













variable (T : UnboundedSelfAdjoint H) (S : ℕ → UnboundedSelfAdjoint H)

set_option maxHeartbeats 1000000 in
theorem solution (n : ℕ) (y : H) : ‖resDiff T S n y‖ ≤ 2 * ‖y‖ := by

  have h1 : ‖T.resCLM 1 y‖ ≤ ‖y‖ := by
    have := T.norm_resCLM_apply_le 1 y
    simpa using this
  have h2 : ‖(S n).resCLM 1 y‖ ≤ ‖y‖ := by
    have := (S n).norm_resCLM_apply_le 1 y
    simpa using this
  have : ‖resDiff T S n y‖ ≤ ‖T.resCLM 1 y‖ + ‖(S n).resCLM 1 y‖ := by
    simpa [resDiff] using norm_sub_le (T.resCLM 1 y) ((S n).resCLM 1 y)
  linarith
