-- Generated from ChapterFockNumberPreservingGap.lean — solution of BookProof.FockNumberPreservingGap.numberCol_eq
import Mathlib
import Definitions.Def_ChapterFockNumberPreservingGap
open BookProof.FockNumberPreservingGap



noncomputable section


open BookProof.FockSecondQuantization BookProof.FockOneParticleGap
open BookProof.FarisLavine BookProof.NavierStokesFlow

set_option maxHeartbeats 1000000 in
theorem solution (k : ℕ) : numberCol k = Finsupp.single k (1 : ℂ) := by

  simp [numberCol, diagCol]
