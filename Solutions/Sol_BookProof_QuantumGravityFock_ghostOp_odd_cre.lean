-- Generated from ChapterQuantumGravityFock.lean — solution of BookProof.QuantumGravityFock.ghostOp_odd_cre
import Mathlib
import Definitions.Def_ChapterQuantumGravityFock
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Definitions.Def_ChapterNavierStokesIkebeKato
import Definitions.Def_ChapterNavierStokesFockSpace
import Definitions.Def_ChapterNavierStokesFullEsa
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterStoneBridge
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterSirkTrotterKato
import Definitions.Def_ChapterYangMillsFriedrichs
import Definitions.Def_ChapterHermiteGalerkinFriedrichs
import Definitions.Def_ChapterComplexShiftCore
import Definitions.Def_ChapterFockSecondQuantization
open BookProof.QuantumGravityFock




open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.NavierStokesFlow.FockOfFock BookProof.NavierStokesFlow.FullEsa
open BookProof.FarisLavine BookProof.StoneBridge BookProof.EsaClosure
open BookProof.ChapterStoneResolvent BookProof.YangMillsFriedrichs
open BookProof.HermiteGalerkin BookProof.HashimotoShiftInvert
open BookProof.FockSecondQuantization

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (j : ℕ) (z : QGGraded) :
    qgGrade (ghostOp (fermCre j) z) = - ghostOp (fermCre j) (qgGrade z) := by

  induction z using TensorProduct.induction_on with
  | zero => simp [qgGrade]; abel
  | tmul x y =>
      simp only [qgGrade, ghostOp_tmul, fermGrade_fermCre]
      rw [TensorProduct.tmul_neg]
  | add z w hz hw =>
      simp only [map_add, hz, hw]
      abel
