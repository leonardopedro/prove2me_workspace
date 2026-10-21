-- Generated from ChapterNavierStokesGaugeY.lean — solution of BookProof.NavierStokesGaugeY.uField_pderiv_y
import Mathlib
import Definitions.Def_ChapterNavierStokesGaugeY
open BookProof.NavierStokesGaugeY




open MvPolynomial BookProof.NavierStokesFlow

set_option maxHeartbeats 1000000 in
theorem solution (i j : Fin 3) :
    pderiv (NSVar.y j) (uField i) = X (NSVar.uD i j) := by

  simp [uField, pderiv_X, Pi.single_apply, Finset.sum_ite_eq', apply_ite]
