-- Generated from ChapterQuantumGravityFock.lean — solution of BookProof.QuantumGravityFock.qgCCR_bose_of_ne
import Mathlib
import Definitions.Def_ChapterQuantumGravityFock
import Theorems.Thm_BookProof_FockSecondQuantization_ccr_annA_creA_of_ne
open BookProof.QuantumGravityFock




open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.NavierStokesFlow.FockOfFock BookProof.NavierStokesFlow.FullEsa
open BookProof.FarisLavine BookProof.StoneBridge BookProof.EsaClosure
open BookProof.ChapterStoneResolvent BookProof.YangMillsFriedrichs
open BookProof.HermiteGalerkin BookProof.HashimotoShiftInvert
open BookProof.FockSecondQuantization

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution {j k : ℕ} (h : j ≠ k) (u : BoseAlg) :
    annA j (creA k u) - creA k (annA j u) = 0 := by

  rw [ccr_annA_creA_of_ne h u, sub_self]
