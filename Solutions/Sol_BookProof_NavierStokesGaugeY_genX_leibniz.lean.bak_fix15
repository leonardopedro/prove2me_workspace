-- Generated from ChapterNavierStokesGaugeY.lean — solution of BookProof.NavierStokesGaugeY.genX_leibniz
import Mathlib
import Definitions.Def_ChapterNavierStokesGaugeY
open BookProof.NavierStokesGaugeY




open MvPolynomial BookProof.NavierStokesFlow

set_option maxHeartbeats 1000000 in
theorem solution (j : Fin 3) (p q : NSAlg) :
    genX j (p * q) = genX j p * q + p * genX j q := by

  rw [genX_apply, genX_apply, genX_apply, pderiv_mul]
