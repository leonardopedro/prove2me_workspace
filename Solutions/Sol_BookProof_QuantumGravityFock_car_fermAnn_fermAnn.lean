-- Generated from ChapterQuantumGravityFock.lean — solution of BookProof.QuantumGravityFock.car_fermAnn_fermAnn
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
theorem solution (j k : ℕ) (u : FermAlg) :
    fermAnn j (fermAnn k u) + fermAnn k (fermAnn j u) = 0 := by

  refine Finsupp.ext fun α => ?_
  simp only [Finsupp.add_apply, Finsupp.zero_apply, fermAnn_apply]
  rcases eq_or_ne j k with rfl | h
  · by_cases hj : j ∈ α
    · simp [hj]
    · rw [if_neg hj, if_pos (Finset.mem_insert_self j α)]
      ring
  · by_cases hj : j ∈ α
    · rw [if_pos hj, if_pos (Finset.mem_insert_of_mem hj)]
      split <;> ring
    · by_cases hk : k ∈ α
      · rw [if_neg hj, if_pos hk, if_pos (Finset.mem_insert_of_mem hk)]
        ring
      · rw [if_neg hj, if_neg hk, if_neg (by simp [hk, Ne.symm h]), if_neg (by simp [hj, h]),
          Finset.insert_comm k j α, ← mul_assoc, ← mul_assoc, jw_swap_insert h hj hk]
        ring
