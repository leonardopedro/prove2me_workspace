-- Generated from ChapterNavierStokesGaugeY.lean — solution of BookProof.NavierStokesGaugeY.genX_ccr_x
import Mathlib
import Definitions.Def_ChapterNavierStokesGaugeY
import Theorems.Thm_BookProof_NavierStokesFlow_ccr_field
open BookProof.NavierStokesGaugeY




open MvPolynomial BookProof.NavierStokesFlow

set_option maxHeartbeats 1000000 in
theorem solution (j k : Fin 3) (p : NSAlg) :
    genX j (X (NSVar.x k) * p) - X (NSVar.x k) * genX j p
      = if NSVar.x j = NSVar.x k then p else 0 := ccr_field _ _ p
