-- Generated from ChapterFermionFock.lean — solution of BookProof.FermionFock.fsign_erase
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
theorem solution (j : ℕ) (S : FConf) : fsign j (S.erase j) = fsign j S := by

  rw [fsign, fsign]
  congr 1
  congr 1
  ext i
  simp only [Finset.mem_filter, Finset.mem_erase]
  constructor
  · rintro ⟨⟨_, hi⟩, hlt⟩; exact ⟨hi, hlt⟩
  · rintro ⟨hi, hlt⟩; exact ⟨⟨by omega, hi⟩, hlt⟩
