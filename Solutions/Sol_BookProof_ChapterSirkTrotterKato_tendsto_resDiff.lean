-- Generated from ChapterSirkTrotterKato.lean — solution of BookProof.ChapterSirkTrotterKato.tendsto_resDiff
import Mathlib
import Definitions.Def_ChapterSirkTrotterKato
open BookProof.ChapterSirkTrotterKato











noncomputable section

open Filter Topology Asymptotics
open scoped InnerProductSpace


open BookProof.ChapterStoneResolvent

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]













variable (T : UnboundedSelfAdjoint H) (S : ℕ → UnboundedSelfAdjoint H)

set_option maxHeartbeats 1000000 in
theorem solution (hres : StrongResolventConvergence T S) (y : H) :
    Tendsto (fun n => resDiff T S n y) atTop (𝓝 0) := by

  have h := (hres y).const_sub (T.resCLM 1 y)
  simpa [resDiff] using h
