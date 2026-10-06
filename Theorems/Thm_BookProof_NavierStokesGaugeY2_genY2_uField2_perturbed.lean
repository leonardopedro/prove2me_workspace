-- Generated from ChapterNavierStokesGaugeY2.lean — theorem BookProof.NavierStokesGaugeY2.genY2_uField2_perturbed
import Mathlib
import Definitions.Def_ChapterNavierStokesGaugeY2
import Definitions.Def_ChapterNavierStokesGaugeY
open BookProof.NavierStokesGaugeY
open BookProof.NavierStokesGaugeY2



open MvPolynomial BookProof.NavierStokesGaugeY

theorem BookProof.NavierStokesGaugeY2.genY2_uField2_perturbed (i j : Fin 3) (c : ℂ) :
    genY2 j (uField2 i + C c * (X (NSVar.y j) * X (NSVar.y j)))
      = C c * (2 * X (NSVar.y j)) := by sorry
