-- Generated from ChapterNavierStokesGaugeY.lean — solution of BookProof.NavierStokesGaugeY.genY_uField
import Mathlib
import Definitions.Def_ChapterNavierStokesGaugeY
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
open BookProof.NavierStokesGaugeY




open MvPolynomial BookProof.NavierStokesFlow


private theorem genY_apply (j : Fin 3) (p : NSAlg) :
    genY j p = pderiv (NSVar.y j) p - ∑ i : Fin 3, X (NSVar.uD i j) * pderiv (NSVar.u i) p := by
  simp [genY]

set_option maxHeartbeats 1000000 in
theorem solution (i j : Fin 3) : genY j (uField i) = 0 := by

  simp [genY_apply, uField, pderiv_X, Pi.single_apply, Finset.sum_ite_eq', apply_ite]
