-- Generated from ChapterYangMillsFockFriedrichs.lean — solution of BookProof.YmFockFriedrichs.gaussPolyN_eval
import Mathlib
import Definitions.Def_ChapterYangMillsFockFriedrichs
import Theorems.Thm_BookProof_YmFockFriedrichs_ycoord_injective
open BookProof.YmFockFriedrichs




open MvPolynomial
open BookProof.YangMillsHermite BookProof.YangMillsFriedrichs BookProof.FriedrichsExtension
open BookProof.HermiteProductCore BookProof.FarisLavine BookProof.DirectSumEsa
open BookProof.QgOuterFock BookProof.StoneBridge BookProof.Qg3DGaugeFL
open BookProof.ChapterStoneResolvent

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution {n : ℕ} (p : Fin n) (a : Fin 8) :
    eval (fun I => if I = ycoord p (idxD 0 0 a) then (1 : ℂ) else 0) (gaussPolyN p a) = 1 := by

  have h1 : (idxD 1 1 a : Fin 99) ≠ idxD 0 0 a := by
    simp [idxD, Fin.ext_iff]
  have h2 : (idxD 2 2 a : Fin 99) ≠ idxD 0 0 a := by
    simp [idxD, Fin.ext_iff]
  have hy1 : ycoord p (idxD 1 1 a) ≠ ycoord p (idxD 0 0 a) := fun h =>
    h1 (ycoord_injective p h)
  have hy2 : ycoord p (idxD 2 2 a) ≠ ycoord p (idxD 0 0 a) := fun h =>
    h2 (ycoord_injective p h)
  simp [gaussPolyN, Fin.sum_univ_three, hy1, hy2]
