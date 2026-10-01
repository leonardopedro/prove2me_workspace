-- Generated from ChapterNavierStokesFlow.lean — theorem BookProof.NavierStokesFlow.ccr_field
import Mathlib
import Definitions.Def_ChapterNavierStokesFlow
open BookProof.NavierStokesFlow

variable {E : Type*} [AddCommGroup E] [Module ℂ E] {ι : Type*} [Fintype ι]
variable {n : ℕ} (L : LagrangianNS n)
variable {n : ℕ} (d : NSTruncation n)
variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]


open scoped BigOperators Matrix Kronecker ComplexOrder TensorProduct

theorem BookProof.NavierStokesFlow.ccr_field {σ : Type*} [DecidableEq σ] (a b : σ) (p : MvPolynomial σ ℂ) :
    (MvPolynomial.pderiv a) (MvPolynomial.X b * p)
      - MvPolynomial.X b * (MvPolynomial.pderiv a) p = (if a = b then p else 0) := by sorry
