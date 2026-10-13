-- Generated from ChapterFockCubicUnbounded.lean — solution of BookProof.FockCubicUnbounded.confAt_injective
import Mathlib
import Definitions.Def_ChapterFockCubicUnbounded
import Theorems.Thm_BookProof_FockCubicUnbounded_confAt_self
import Definitions.Def_ChapterFockOneParticleGap
import Definitions.Def_ChapterFockNumberPreservingGap
import Definitions.Def_ChapterFockFieldPerturbation
import Definitions.Def_ChapterFockSecondQuantization
open BookProof.FockCubicUnbounded



noncomputable section


open BookProof.FockSecondQuantization BookProof.FockOneParticleGap
open BookProof.FockNumberPreservingGap BookProof.FockFieldPerturbation
open BookProof.FockSecondQuantization

set_option maxHeartbeats 1000000 in
theorem solution (k : ℕ) {m m' : ℕ} (h : confAt k m = confAt k m') : m = m' := by

  have := congrArg (fun β : Conf => β k) h
  simpa [confAt_self] using this
