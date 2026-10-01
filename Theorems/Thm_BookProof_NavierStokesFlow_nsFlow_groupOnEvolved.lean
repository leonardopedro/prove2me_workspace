-- Generated from ChapterNavierStokesFlow.lean — theorem BookProof.NavierStokesFlow.nsFlow_groupOnEvolved
import Mathlib
import Definitions.Def_ChapterNavierStokesFlow
open BookProof.NavierStokesFlow

variable {E : Type*} [AddCommGroup E] [Module ℂ E] {ι : Type*} [Fintype ι]
variable {n : ℕ} (L : LagrangianNS n)
variable {n : ℕ} (d : NSTruncation n)
variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]


open scoped BigOperators Matrix Kronecker ComplexOrder TensorProduct

theorem BookProof.NavierStokesFlow.nsFlow_groupOnEvolved (t₁ t₂ : ℝ) (psi : Fin n → ℂ) :
    nsFlowUnitary d t₁ *ᵥ (nsFlowUnitary d t₂ *ᵥ psi) = nsFlowUnitary d (t₁ + t₂) *ᵥ psi := by sorry
