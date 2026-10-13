-- Generated from ChapterQuantumGravityFock.lean — solution of BookProof.QuantumGravityFock.jwSign_mul_self
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
theorem solution (j : ℕ) (α : FermConf) : jwSign j α * jwSign j α = 1 := by

  rw [jwSign, ← pow_add]
  rcases Nat.even_or_odd (jwCount j α) with he | ho
  · rw [Even.neg_one_pow (he.add he)]
  · rw [Even.neg_one_pow (ho.add_odd ho)]
