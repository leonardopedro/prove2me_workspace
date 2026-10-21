-- Generated from ChapterFockCubicUnbounded.lean — solution of BookProof.FockCubicUnbounded.confAt_ne_zero
import Mathlib
import Definitions.Def_ChapterFockCubicUnbounded
import Theorems.Thm_BookProof_FockCubicUnbounded_confAt_self
open BookProof.FockCubicUnbounded



noncomputable section


open BookProof.FockSecondQuantization BookProof.FockOneParticleGap
open BookProof.FockNumberPreservingGap BookProof.FockFieldPerturbation

set_option maxHeartbeats 1000000 in
theorem solution {k m : ℕ} (h : m ≠ 0) : confAt k m ≠ 0 := by

  intro hc
  have := congrArg (fun β : Conf => β k) hc
  simp only [confAt_self] at this
  exact h this
