-- Generated from ChapterNavierStokesEulerian.lean — theorem BookProof.NavierStokesEulerian.eulerian_momentum_dual
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Mathlib
import Definitions.Def_ChapterNavierStokesEulerian
open BookProof.NavierStokesEulerian



open BookProof.NavierStokesFlow Matrix

theorem BookProof.NavierStokesEulerian.eulerian_momentum_dual (i j k l : Fin 3) :
    (MvPolynomial.pderiv (i, j)) (MvPolynomial.X (k, l) : MvPolynomial (Fin 3 × Fin 3) ℂ)
      = if i = k ∧ j = l then 1 else 0 := by sorry
