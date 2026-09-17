-- Generated from ChapterNavierStokesFlow.lean — solution of BookProof.NavierStokesFlow.nsWord_length_le_three
import Mathlib
import Definitions.Def_ChapterNavierStokesFlow
open BookProof.NavierStokesFlow



open scoped BigOperators Matrix Kronecker ComplexOrder TensorProduct

set_option maxHeartbeats 1000000 in
theorem solution (a : NSWordIndex) : (nsWord a).length ≤ 3 := by

  rcases a with ⟨i, j, b⟩ | ⟨i, b⟩ <;> cases b <;> simp [nsWord]
