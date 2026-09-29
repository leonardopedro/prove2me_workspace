-- Generated from ChapterNavierStokesFlow.lean — solution of BookProof.NavierStokesFlow.nsWord_length_le_three
import Mathlib
import Definitions.Def_ChapterNavierStokesFlow
open BookProof.NavierStokesFlow













open scoped BigOperators Matrix Kronecker ComplexOrder TensorProduct




variable {E : Type*} [AddCommGroup E] [Module ℂ E] {ι : Type*} [Fintype ι]















variable {n : ℕ} (L : LagrangianNS n)

















variable {n : ℕ} (d : NSTruncation n)

set_option maxHeartbeats 1000000 in
theorem solution (a : NSWordIndex) : (nsWord a).length ≤ 3 := by

  rcases a with ⟨i, j, b⟩ | ⟨i, b⟩ <;> cases b <;> simp [nsWord]
