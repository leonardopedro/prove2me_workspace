-- Generated from ChapterNavierStokesGaugeY2.lean — solution of BookProof.NavierStokesGaugeY2.genY2_uField2
import Mathlib
import Definitions.Def_ChapterNavierStokesGaugeY2
import Theorems.Thm_BookProof_NavierStokesGaugeY2_uField2_pderiv_y
import Theorems.Thm_BookProof_NavierStokesGaugeY2_uField2_pderiv_u
import Theorems.Thm_BookProof_NavierStokesGaugeY2_uField2_pderiv_uD
open BookProof.NavierStokesGaugeY2




open MvPolynomial BookProof.NavierStokesGaugeY

set_option maxHeartbeats 1000000 in
theorem solution (i j : Fin 3) : genY2 j (uField2 i) = 0 := by

  rw [genY2_apply, uField2_pderiv_y,
    Finset.sum_congr rfl (fun m (_ : m ∈ Finset.univ) => by
      rw [uField2_pderiv_u m i] :
      ∀ m ∈ Finset.univ, X (NSVar.uD m j) * pderiv (NSVar.u m) (uField2 i)
        = X (NSVar.uD m j) * (if m = i then 1 else 0)),
    Finset.sum_congr rfl (fun m (_ : m ∈ Finset.univ) => by
      rw [uField2_pderiv_uD m j i] :
      ∀ m ∈ Finset.univ, X (NSVar.uL m) * pderiv (NSVar.uD m j) (uField2 i)
        = X (NSVar.uL m) * (if m = i then X (NSVar.y j) else 0))]
  simp only [mul_ite, mul_one, mul_zero, Finset.sum_ite_eq' Finset.univ i,
    if_pos (Finset.mem_univ i), uDField]
  ring
