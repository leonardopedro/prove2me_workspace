-- Generated from ChapterNavierStokesEulerian.lean — solution of BookProof.NavierStokesEulerian.eulerian_momentum_constraint
import Mathlib
import Definitions.Def_ChapterNavierStokesEulerian
import Theorems.Thm_BookProof_NavierStokesFlow_ccr_field
open BookProof.NavierStokesEulerian




open BookProof.NavierStokesFlow Matrix

set_option maxHeartbeats 1000000 in
theorem solution (j k : Fin 3) (p : MvPolynomial (Fin 3) ℂ) :
    (MvPolynomial.pderiv k) (MvPolynomial.X j * p)
      - MvPolynomial.X j * (MvPolynomial.pderiv k) p = (if k = j then p else 0) := ccr_field k j p
