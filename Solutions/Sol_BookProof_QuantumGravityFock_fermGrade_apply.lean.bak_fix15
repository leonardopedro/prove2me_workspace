-- Generated from ChapterQuantumGravityFock.lean — solution of BookProof.QuantumGravityFock.fermGrade_apply
import Mathlib
import Definitions.Def_ChapterQuantumGravityFock
open BookProof.QuantumGravityFock




open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.NavierStokesFlow.FockOfFock BookProof.NavierStokesFlow.FullEsa
open BookProof.FarisLavine BookProof.StoneBridge BookProof.EsaClosure
open BookProof.ChapterStoneResolvent BookProof.YangMillsFriedrichs
open BookProof.HermiteGalerkin BookProof.HashimotoShiftInvert
open BookProof.FockSecondQuantization

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (u : FermAlg) (α : FermConf) :
    fermGrade u α = ((-1 : ℂ) ^ α.card) * u α := by

  induction u using Finsupp.induction_linear with
  | zero => simp
  | add f g hf hg => simp only [map_add, Finsupp.add_apply, hf, hg]; ring
  | single β c =>
    rw [fermGrade_single]
    by_cases h : α = β
    · subst h; simp
    · simp [h]
