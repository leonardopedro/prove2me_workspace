-- Generated from ChapterNavierStokesGaugeY.lean — theorem BookProof.NavierStokesGaugeY.genY_shifts_velocity
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Mathlib
import Definitions.Def_ChapterNavierStokesGaugeY
open BookProof.NavierStokesGaugeY



open MvPolynomial BookProof.NavierStokesFlow

theorem BookProof.NavierStokesGaugeY.genY_shifts_velocity (i j : Fin 3) (p : NSAlg) :
    genY j (X (NSVar.u i) * p) - X (NSVar.u i) * genY j p = -(X (NSVar.uD i j) * p) := by sorry
