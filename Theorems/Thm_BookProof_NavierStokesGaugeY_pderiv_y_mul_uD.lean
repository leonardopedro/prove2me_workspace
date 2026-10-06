-- Generated from ChapterNavierStokesGaugeY.lean — theorem BookProof.NavierStokesGaugeY.pderiv_y_mul_uD
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Mathlib
import Definitions.Def_ChapterNavierStokesGaugeY
open BookProof.NavierStokesGaugeY



open MvPolynomial BookProof.NavierStokesFlow

theorem BookProof.NavierStokesGaugeY.pderiv_y_mul_uD (m i j : Fin 3) (q : NSAlg) :
    pderiv (NSVar.y m) (X (NSVar.uD i j) * q) = X (NSVar.uD i j) * pderiv (NSVar.y m) q := by sorry
