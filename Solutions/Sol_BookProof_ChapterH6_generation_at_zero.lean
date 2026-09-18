-- Generated from ChapterH6.lean — solution of BookProof.ChapterH6.generation_at_zero
import Mathlib
import Definitions.Def_ChapterH6
open BookProof.ChapterH6



noncomputable section

open Filter Topology

set_option maxHeartbeats 1000000 in
theorem solution (A : Matrix (Fin m) (Fin m) ℂ) (psi0 : Fin m → ℂ) :
    generatedState A 0 psi0 = psi0 := by

  rw [generatedState]
  simp [NormedSpace.exp_zero, Matrix.one_mulVec]
