-- Generated from ChapterNavierStokesGaugeY.lean — solution of BookProof.NavierStokesGaugeY.genX_ccr_y
import Mathlib
import Definitions.Def_ChapterNavierStokesGaugeY
open BookProof.NavierStokesGaugeY




open MvPolynomial BookProof.NavierStokesFlow

set_option maxHeartbeats 1000000 in
theorem solution (j k : Fin 3) (p : NSAlg) :
    genX j (X (NSVar.y k) * p) - X (NSVar.y k) * genX j p = 0 := by

  rw [genX_apply, genX_apply, pderiv_mul, pderiv_X_of_ne (by simp)]; ring
