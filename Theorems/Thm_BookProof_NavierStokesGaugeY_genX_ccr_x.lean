-- Generated from ChapterNavierStokesGaugeY.lean — theorem BookProof.NavierStokesGaugeY.genX_ccr_x
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Mathlib
import Definitions.Def_ChapterNavierStokesGaugeY
open BookProof.NavierStokesGaugeY



open MvPolynomial BookProof.NavierStokesFlow

theorem BookProof.NavierStokesGaugeY.genX_ccr_x (j k : Fin 3) (p : NSAlg) :
    genX j (X (NSVar.x k) * p) - X (NSVar.x k) * genX j p
      = if NSVar.x j = NSVar.x k then p else 0 := by sorry
