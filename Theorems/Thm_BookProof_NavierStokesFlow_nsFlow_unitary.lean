-- Generated from ChapterNavierStokesFlow.lean — theorem BookProof.NavierStokesFlow.nsFlow_unitary
import Mathlib
import Definitions.Def_ChapterNavierStokesFlow
open BookProof.NavierStokesFlow












open scoped BigOperators Matrix Kronecker ComplexOrder TensorProduct




variable {E : Type*} [AddCommGroup E] [Module ℂ E] {ι : Type*} [Fintype ι]















variable {n : ℕ} (L : LagrangianNS n)

















variable {n : ℕ} (d : NSTruncation n)

theorem BookProof.NavierStokesFlow.nsFlow_unitary (t : ℝ) : (nsFlowUnitary d t)ᴴ * nsFlowUnitary d t = 1 := by sorry
