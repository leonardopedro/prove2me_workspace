-- Generated from ChapterNavierStokesFlow.lean — theorem BookProof.NavierStokesFlow.nsNumberOp_posSemidef
import Mathlib
import Definitions.Def_ChapterNavierStokesFlow
open BookProof.NavierStokesFlow


open scoped BigOperators Matrix Kronecker ComplexOrder TensorProduct

variable {n : ℕ}

theorem BookProof.NavierStokesFlow.nsNumberOp_posSemidef {m : ℕ} (A : Fin m → Matrix (Fin n) (Fin n) ℂ) :
    (nsNumberOp A).PosSemidef := by sorry
