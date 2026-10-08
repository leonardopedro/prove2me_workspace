-- Generated from ChapterNavierStokesFlow.lean — theorem BookProof.NavierStokesFlow.nsWord_length_le_three
import Mathlib
import Definitions.Def_ChapterNavierStokesFlow
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
open BookProof.NavierStokesFlow


open scoped BigOperators Matrix Kronecker ComplexOrder TensorProduct

variable {E : Type*} [AddCommGroup E] [Module ℂ E] {ι : Type*} [Fintype ι]
variable {n : ℕ} (L : LagrangianNS n)
variable {n : ℕ} (d : NSTruncation n)

theorem BookProof.NavierStokesFlow.nsWord_length_le_three (a : NSWordIndex) : (nsWord a).length ≤ 3 := by sorry
