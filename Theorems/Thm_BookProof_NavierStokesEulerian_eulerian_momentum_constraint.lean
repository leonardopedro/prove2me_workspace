-- Generated from ChapterNavierStokesEulerian.lean — theorem BookProof.NavierStokesEulerian.eulerian_momentum_constraint
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Mathlib
import Definitions.Def_ChapterNavierStokesEulerian
open BookProof.NavierStokesEulerian



open BookProof.NavierStokesFlow Matrix

theorem BookProof.NavierStokesEulerian.eulerian_momentum_constraint (j k : Fin 3) (p : MvPolynomial (Fin 3) ℂ) :
    (MvPolynomial.pderiv k) (MvPolynomial.X j * p)
      - MvPolynomial.X j * (MvPolynomial.pderiv k) p = (if k = j then p else 0) := by sorry
