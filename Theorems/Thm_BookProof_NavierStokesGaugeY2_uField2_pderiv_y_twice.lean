-- Generated from ChapterNavierStokesGaugeY2.lean — theorem BookProof.NavierStokesGaugeY2.uField2_pderiv_y_twice
import Mathlib
import Definitions.Def_ChapterNavierStokesGaugeY2
import Definitions.Def_ChapterNavierStokesGaugeY
open BookProof.NavierStokesGaugeY
open BookProof.NavierStokesGaugeY2



open MvPolynomial BookProof.NavierStokesGaugeY

theorem BookProof.NavierStokesGaugeY2.uField2_pderiv_y_twice (i j : Fin 3) :
    pderiv (NSVar.y j) (pderiv (NSVar.y j) (uField2 i)) = X (NSVar.uL i) := by sorry
