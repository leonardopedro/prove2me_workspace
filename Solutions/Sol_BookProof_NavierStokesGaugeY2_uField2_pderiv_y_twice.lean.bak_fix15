-- Generated from ChapterNavierStokesGaugeY2.lean — solution of BookProof.NavierStokesGaugeY2.uField2_pderiv_y_twice
import Mathlib
import Definitions.Def_ChapterNavierStokesGaugeY2
import Theorems.Thm_BookProof_NavierStokesGaugeY2_uField2_pderiv_y
open BookProof.NavierStokesGaugeY2




open MvPolynomial BookProof.NavierStokesGaugeY

set_option maxHeartbeats 1000000 in
theorem solution (i j : Fin 3) :
    pderiv (NSVar.y j) (pderiv (NSVar.y j) (uField2 i)) = X (NSVar.uL i) := by

  rw [uField2_pderiv_y, uDField, map_add, pderiv_mul]
  simp [pderiv_X]
