-- Generated from ChapterQuantumGravityFock.lean — solution of BookProof.QuantumGravityFock.qgGhostCar_book
import Mathlib
import Definitions.Def_ChapterQuantumGravityFock
import Theorems.Thm_BookProof_QuantumGravityFock_qgGhostCar
import Theorems.Thm_BookProof_QuantumGravityFock_qgGhostCar_of_ne
open BookProof.QuantumGravityFock




open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.NavierStokesFlow.FockOfFock BookProof.NavierStokesFlow.FullEsa
open BookProof.FarisLavine BookProof.StoneBridge BookProof.EsaClosure
open BookProof.ChapterStoneResolvent BookProof.YangMillsFriedrichs
open BookProof.HermiteGalerkin BookProof.HashimotoShiftInvert
open BookProof.FockSecondQuantization

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (a b : Fin qgGhostModes) (z : QGGraded) :
    ghostOp (fermAnn a.val) (ghostOp (fermCre b.val) z)
        + ghostOp (fermCre b.val) (ghostOp (fermAnn a.val) z)
      = if a = b then z else 0 := by

  by_cases h : a = b
  · subst h; rw [if_pos rfl, qgGhostCar]
  · rw [if_neg h, qgGhostCar_of_ne (by simpa [Fin.val_inj] using h)]
