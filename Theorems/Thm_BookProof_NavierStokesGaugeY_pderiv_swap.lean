-- Generated from ChapterNavierStokesGaugeY.lean — theorem BookProof.NavierStokesGaugeY.pderiv_swap
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Mathlib
import Definitions.Def_ChapterNavierStokesGaugeY
open BookProof.NavierStokesGaugeY



open MvPolynomial BookProof.NavierStokesFlow

theorem BookProof.NavierStokesGaugeY.pderiv_swap (a b : NSVar) (p : NSAlg) :
    pderiv a (pderiv b p) = pderiv b (pderiv a p) := by sorry
