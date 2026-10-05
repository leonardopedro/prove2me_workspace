-- Generated from ChapterFermionFock.lean — solution of BookProof.FermionFock.fsign_conj
import Mathlib
import Definitions.Def_ChapterFermionFock
open BookProof.FermionFock




open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.FarisLavine BookProof.HermiteGalerkin BookProof.FriedrichsExtension
open BookProof.YangMillsFriedrichs
open BookProof.HashimotoShiftInvert
open BookProof.FockSecondQuantization (IsHermCol IsPosCol opCol isHermCol_opCol isPosCol_opCol)

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (j : ℕ) (S : FConf) : (starRingEnd ℂ) (fsign j S) = fsign j S := by

  rw [fsign, map_pow]
  norm_num
