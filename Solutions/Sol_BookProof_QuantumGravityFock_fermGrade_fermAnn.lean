-- Generated from ChapterQuantumGravityFock.lean — solution of BookProof.QuantumGravityFock.fermGrade_fermAnn
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
import Definitions.Def_ChapterSmCarAlgebra
open BookProof.QuantumGravityFock




open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.NavierStokesFlow.FockOfFock BookProof.NavierStokesFlow.FullEsa
open BookProof.FarisLavine BookProof.StoneBridge BookProof.EsaClosure
open BookProof.ChapterStoneResolvent BookProof.YangMillsFriedrichs
open BookProof.HermiteGalerkin BookProof.HashimotoShiftInvert
open BookProof.FockSecondQuantization
open BookProof.SmCar

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (j : ℕ) (u : FermAlg) :
    fermGrade (fermAnn j u) = - fermAnn j (fermGrade u) := by

  refine Finsupp.ext fun α => ?_
  rw [fermGrade_apply, fermAnn_apply, Finsupp.neg_apply, fermAnn_apply]
  by_cases hj : j ∈ α
  · simp [hj]
  · rw [if_neg hj, if_neg hj, fermGrade_apply, Finset.card_insert_of_notMem hj, pow_succ]
    ring
