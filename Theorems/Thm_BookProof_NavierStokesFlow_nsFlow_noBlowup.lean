-- Generated from ChapterNavierStokesFlow.lean — theorem BookProof.NavierStokesFlow.nsFlow_noBlowup
import Mathlib
import Definitions.Def_ChapterNavierStokesFlow
open BookProof.NavierStokesFlow












open scoped BigOperators Matrix Kronecker ComplexOrder TensorProduct




variable {E : Type*} [AddCommGroup E] [Module ℂ E] {ι : Type*} [Fintype ι]















variable {n : ℕ} (L : LagrangianNS n)

















variable {n : ℕ} (d : NSTruncation n)

theorem BookProof.NavierStokesFlow.nsFlow_noBlowup (t : ℝ) (psi : Fin n → ℂ) (k : Fin n) :
    ‖(nsFlowUnitary d t *ᵥ psi) k‖ ^ 2 ≤ ∑ a, ‖psi a‖ ^ 2 := by sorry
