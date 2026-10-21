-- Generated from ChapterNavierStokesGaugeY.lean — solution of BookProof.NavierStokesGaugeY.pderiv_y_mul_uD
import Mathlib
import Definitions.Def_ChapterNavierStokesGaugeY
open BookProof.NavierStokesGaugeY




open MvPolynomial BookProof.NavierStokesFlow

set_option maxHeartbeats 1000000 in
theorem solution (m i j : Fin 3) (q : NSAlg) :
    pderiv (NSVar.y m) (X (NSVar.uD i j) * q) = X (NSVar.uD i j) * pderiv (NSVar.y m) q := by

  rw [pderiv_mul, pderiv_X_of_ne (by simp)]; ring
