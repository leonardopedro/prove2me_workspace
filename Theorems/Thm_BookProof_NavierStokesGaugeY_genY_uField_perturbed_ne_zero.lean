-- Generated from ChapterNavierStokesGaugeY.lean — theorem BookProof.NavierStokesGaugeY.genY_uField_perturbed_ne_zero
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Mathlib
import Definitions.Def_ChapterNavierStokesGaugeY
open BookProof.NavierStokesGaugeY



open MvPolynomial BookProof.NavierStokesFlow

theorem BookProof.NavierStokesGaugeY.genY_uField_perturbed_ne_zero (i j : Fin 3) (c : ℂ) (hc : c ≠ 0) :
    genY j (uField i + C c * X (NSVar.y j)) ≠ 0 := by sorry
