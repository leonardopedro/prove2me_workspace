-- Generated from ChapterNavierStokesGaugeY.lean — theorem BookProof.NavierStokesGaugeY.genY_ccr_y
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Mathlib
import Definitions.Def_ChapterNavierStokesGaugeY
open BookProof.NavierStokesGaugeY



open MvPolynomial BookProof.NavierStokesFlow

theorem BookProof.NavierStokesGaugeY.genY_ccr_y (j k : Fin 3) (p : NSAlg) :
    genY j (X (NSVar.y k) * p) - X (NSVar.y k) * genY j p = if j = k then p else 0 := by sorry
