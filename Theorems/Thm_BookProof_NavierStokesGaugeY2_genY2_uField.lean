-- Generated from ChapterNavierStokesGaugeY2.lean — theorem BookProof.NavierStokesGaugeY2.genY2_uField
import Mathlib
import Definitions.Def_ChapterNavierStokesGaugeY2
import Definitions.Def_ChapterNavierStokesGaugeY
open BookProof.NavierStokesGaugeY
open BookProof.NavierStokesGaugeY2



open MvPolynomial BookProof.NavierStokesGaugeY

theorem BookProof.NavierStokesGaugeY2.genY2_uField (i j : Fin 3) :
    genY2 j (uField i) = -(X (NSVar.uL i) * X (NSVar.y j)) := by sorry
