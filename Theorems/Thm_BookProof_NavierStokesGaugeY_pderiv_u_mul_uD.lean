-- Generated from ChapterNavierStokesGaugeY.lean — theorem BookProof.NavierStokesGaugeY.pderiv_u_mul_uD
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Mathlib
import Definitions.Def_ChapterNavierStokesGaugeY
open BookProof.NavierStokesGaugeY



open MvPolynomial BookProof.NavierStokesFlow

theorem BookProof.NavierStokesGaugeY.pderiv_u_mul_uD (m i j : Fin 3) (q : NSAlg) :
    pderiv (NSVar.u m) (X (NSVar.uD i j) * q) = X (NSVar.uD i j) * pderiv (NSVar.u m) q := by sorry
