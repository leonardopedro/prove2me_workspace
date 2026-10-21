-- Generated from ChapterNavierStokesGaugeY2.lean — solution of BookProof.NavierStokesGaugeY2.genY_uField2
import Mathlib
import Definitions.Def_ChapterNavierStokesGaugeY2
import Theorems.Thm_BookProof_NavierStokesGaugeY2_uField2_pderiv_y
import Theorems.Thm_BookProof_NavierStokesGaugeY2_uField2_pderiv_u
open BookProof.NavierStokesGaugeY2




open MvPolynomial BookProof.NavierStokesGaugeY

set_option maxHeartbeats 1000000 in
theorem solution (i j : Fin 3) :
    genY j (uField2 i) = X (NSVar.uL i) * X (NSVar.y j) := by

  rw [genY_apply, uField2_pderiv_y,
    Finset.sum_congr rfl (fun m (_ : m ∈ Finset.univ) => by
      rw [uField2_pderiv_u m i] :
      ∀ m ∈ Finset.univ, X (NSVar.uD m j) * pderiv (NSVar.u m) (uField2 i)
        = X (NSVar.uD m j) * (if m = i then 1 else 0))]
  simp only [mul_ite, mul_one, mul_zero, Finset.sum_ite_eq' Finset.univ i,
    if_pos (Finset.mem_univ i), uDField]
  ring
