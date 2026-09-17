-- Generated from ChapterNavierStokesFlow.lean — solution of BookProof.NavierStokesFlow.nsNumberOp_eq_secondQuant
import Mathlib
import Definitions.Def_ChapterNavierStokesFlow
open BookProof.NavierStokesFlow



open scoped BigOperators Matrix Kronecker ComplexOrder TensorProduct

set_option maxHeartbeats 1000000 in
theorem solution {m : ℕ} (A : Fin m → Matrix (Fin n) (Fin n) ℂ) :
    nsNumberOp A = nsSecondQuant A 1 := by

  simp [nsNumberOp, nsSecondQuant, Matrix.one_apply]
