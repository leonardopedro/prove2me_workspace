-- Generated from ChapterNavierStokesFlow.lean — theorem BookProof.NavierStokesFlow.nsNumberOp_eq_secondQuant
import Mathlib
import Definitions.Def_ChapterNavierStokesFlow
open BookProof.NavierStokesFlow


open scoped BigOperators Matrix Kronecker ComplexOrder TensorProduct

variable {n : ℕ}

theorem BookProof.NavierStokesFlow.nsNumberOp_eq_secondQuant {m : ℕ} (A : Fin m → Matrix (Fin n) (Fin n) ℂ) :
    nsNumberOp A = nsSecondQuant A 1 := by sorry
