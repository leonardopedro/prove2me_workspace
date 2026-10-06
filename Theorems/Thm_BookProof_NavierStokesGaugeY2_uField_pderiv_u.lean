-- Generated from ChapterNavierStokesGaugeY2.lean — theorem BookProof.NavierStokesGaugeY2.uField_pderiv_u
import Mathlib
import Definitions.Def_ChapterNavierStokesGaugeY2
import Definitions.Def_ChapterNavierStokesGaugeY
open BookProof.NavierStokesGaugeY
open BookProof.NavierStokesGaugeY2



open MvPolynomial BookProof.NavierStokesGaugeY

theorem BookProof.NavierStokesGaugeY2.uField_pderiv_u (m i : Fin 3) :
    pderiv (NSVar.u m) (uField i) = if m = i then 1 else 0 := by sorry
