-- Generated from ChapterGaugeUnconstrainedSpectrum.lean — solution of BookProof.ChapterGaugeUnconstrainedSpectrum.diagOp_injective
import Mathlib
import Definitions.Def_ChapterGaugeUnconstrainedSpectrum
open BookProof.ChapterGaugeUnconstrainedSpectrum




variable {X : Type*}

variable {X : Type*}

set_option maxHeartbeats 1000000 in
theorem solution : Function.Injective (diagOp (X := X)) := by

  intro d e h
  funext x
  have := congrArg (fun T : Op X => T (fun _ => (1 : ℂ)) x) h
  simpa using this
