-- Generated from ChapterNavierStokesGaugeY2.lean — theorem BookProof.NavierStokesGaugeY2.uField2_pderiv_uD
import Mathlib
import Definitions.Def_ChapterNavierStokesGaugeY2
import Definitions.Def_ChapterNavierStokesGaugeY
open BookProof.NavierStokesGaugeY
open BookProof.NavierStokesGaugeY2



open MvPolynomial BookProof.NavierStokesGaugeY

theorem BookProof.NavierStokesGaugeY2.uField2_pderiv_uD (m k i : Fin 3) :
    pderiv (NSVar.uD m k) (uField2 i) = if m = i then X (NSVar.y k) else 0 := by sorry
