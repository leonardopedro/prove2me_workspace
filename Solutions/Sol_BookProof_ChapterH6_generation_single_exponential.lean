-- Generated from ChapterH6.lean — solution of BookProof.ChapterH6.generation_single_exponential
import Mathlib
import Definitions.Def_ChapterH6
open BookProof.ChapterH6



noncomputable section

open Filter Topology

set_option maxHeartbeats 1000000 in
theorem solution (A : Matrix (Fin m) (Fin m) ℂ) (psi0 : Fin m → ℂ) :
    generatedState A 1 psi0 = (NormedSpace.exp ((-Complex.I) • A)).mulVec psi0 := by

  rw [generatedState, mul_one]
