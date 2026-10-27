-- Generated from ChapterNavierStokesGaugeY2.lean — solution of BookProof.NavierStokesGaugeY2.genY2_uField2_perturbed
import Mathlib
import Definitions.Def_ChapterNavierStokesGaugeY2
import Theorems.Thm_BookProof_NavierStokesGaugeY2_genY2_leibniz
import Theorems.Thm_BookProof_NavierStokesGaugeY2_genY2_uField2
open BookProof.NavierStokesGaugeY2




open MvPolynomial BookProof.NavierStokesGaugeY

set_option maxHeartbeats 1000000 in
theorem solution (i j : Fin 3) (c : ℂ) :
    genY2 j (uField2 i + C c * (X (NSVar.y j) * X (NSVar.y j)))
      = C c * (2 * X (NSVar.y j)) := by

  rw [map_add, genY2_uField2, zero_add, genY2_leibniz, genY2_C, genY2_leibniz, genY2_X_y,
    if_pos rfl]
  ring
