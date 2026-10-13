-- Generated from ChapterNavierStokesGaugeY.lean — solution of BookProof.NavierStokesGaugeY.genY_uField_perturbed
import Mathlib
import Definitions.Def_ChapterNavierStokesGaugeY
import Theorems.Thm_BookProof_NavierStokesGaugeY_genY_uField
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
open BookProof.NavierStokesGaugeY




open MvPolynomial BookProof.NavierStokesFlow


private theorem genY_apply (j : Fin 3) (p : NSAlg) :
    genY j p = pderiv (NSVar.y j) p - ∑ i : Fin 3, X (NSVar.uD i j) * pderiv (NSVar.u i) p := by
  simp [genY]

set_option maxHeartbeats 1000000 in
theorem solution (i j : Fin 3) (c : ℂ) :
    genY j (uField i + C c * X (NSVar.y j)) = C c := by

  have h := genY_uField i j
  have h2 : genY j (C c * X (NSVar.y j)) = C c := by
    simp [genY_apply, pderiv_X]
  rw [map_add, h, h2, zero_add]
