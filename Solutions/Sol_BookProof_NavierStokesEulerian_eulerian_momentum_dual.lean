-- Generated from ChapterNavierStokesEulerian.lean — solution of BookProof.NavierStokesEulerian.eulerian_momentum_dual
import Mathlib
import Definitions.Def_ChapterNavierStokesEulerian
open BookProof.NavierStokesEulerian




open BookProof.NavierStokesFlow Matrix

set_option maxHeartbeats 1000000 in
theorem solution (i j k l : Fin 3) :
    (MvPolynomial.pderiv (i, j)) (MvPolynomial.X (k, l) : MvPolynomial (Fin 3 × Fin 3) ℂ)
      = if i = k ∧ j = l then 1 else 0 := by

  rw [MvPolynomial.pderiv_X]
  simp [Prod.ext_iff, Pi.single_apply, eq_comm]
