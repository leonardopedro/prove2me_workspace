-- Generated from ChapterNavierStokesGaugeY.lean — theorem BookProof.NavierStokesGaugeY.genY_uField_perturbed
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Mathlib
import Definitions.Def_ChapterNavierStokesGaugeY
open BookProof.NavierStokesGaugeY



open MvPolynomial BookProof.NavierStokesFlow

theorem BookProof.NavierStokesGaugeY.genY_uField_perturbed (i j : Fin 3) (c : ℂ) :
    genY j (uField i + C c * X (NSVar.y j)) = C c := by sorry
