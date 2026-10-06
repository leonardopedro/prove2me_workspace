-- Generated from ChapterNavierStokesGaugeY.lean — theorem BookProof.NavierStokesGaugeY.pderiv_x_mul_uD
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Mathlib
import Definitions.Def_ChapterNavierStokesGaugeY
open BookProof.NavierStokesGaugeY



open MvPolynomial BookProof.NavierStokesFlow

theorem BookProof.NavierStokesGaugeY.pderiv_x_mul_uD (m i j : Fin 3) (q : NSAlg) :
    pderiv (NSVar.x m) (X (NSVar.uD i j) * q) = X (NSVar.uD i j) * pderiv (NSVar.x m) q := by sorry
