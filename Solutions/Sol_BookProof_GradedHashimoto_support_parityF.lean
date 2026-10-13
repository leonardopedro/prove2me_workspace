-- Generated from ChapterGradedHashimoto.lean — solution of BookProof.GradedHashimoto.support_parityF
import Mathlib
import Definitions.Def_ChapterGradedHashimoto
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Definitions.Def_ChapterNavierStokesIkebeKato
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterFriedrichsExtension
import Definitions.Def_ChapterYangMillsFriedrichs
import Definitions.Def_ChapterHermiteGalerkinFriedrichs
import Definitions.Def_ChapterComplexShiftCore
import Definitions.Def_ChapterFockSecondQuantization
import Definitions.Def_ChapterFermionFock
import Definitions.Def_ChapterGradedFock
import Definitions.Def_ChapterGradedFriedrichs
import Definitions.Def_ChapterSirkTrotterKato
import Definitions.Def_ChapterStoneBridge
open BookProof.GradedHashimoto




open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.FarisLavine BookProof.FriedrichsExtension BookProof.YangMillsFriedrichs
open BookProof.HermiteGalerkin BookProof.HashimotoShiftInvert
open BookProof.FockSecondQuantization BookProof.FermionFock BookProof.GradedFock
open BookProof.GradedFriedrichs
open BookProof.ChapterStoneResolvent BookProof.StoneBridge

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (u : FermiAlg) : (parityF u).support ⊆ u.support := by

  intro S hS
  rw [Finsupp.mem_support_iff] at hS ⊢
  intro h
  exact hS (by rw [parityF_apply, h, mul_zero])
