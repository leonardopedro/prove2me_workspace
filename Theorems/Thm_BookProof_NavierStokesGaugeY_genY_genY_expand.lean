-- Generated from ChapterNavierStokesGaugeY.lean — theorem BookProof.NavierStokesGaugeY.genY_genY_expand
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Mathlib
import Definitions.Def_ChapterNavierStokesGaugeY
open BookProof.NavierStokesGaugeY



open MvPolynomial BookProof.NavierStokesFlow

theorem BookProof.NavierStokesGaugeY.genY_genY_expand (j k : Fin 3) (p : NSAlg) :
    genY j (genY k p) =
      pderiv (NSVar.y j) (pderiv (NSVar.y k) p)
      - ∑ i : Fin 3, X (NSVar.uD i j) * pderiv (NSVar.y k) (pderiv (NSVar.u i) p)
      - ∑ i : Fin 3, X (NSVar.uD i k) * pderiv (NSVar.y j) (pderiv (NSVar.u i) p)
      + ∑ i : Fin 3, ∑ m : Fin 3,
          X (NSVar.uD i j) * X (NSVar.uD m k) * pderiv (NSVar.u i) (pderiv (NSVar.u m) p) := by sorry
