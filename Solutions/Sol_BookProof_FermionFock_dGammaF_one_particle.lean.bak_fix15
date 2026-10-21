-- Generated from ChapterFermionFock.lean — solution of BookProof.FermionFock.dGammaF_one_particle
import Mathlib
import Definitions.Def_ChapterFermionFock
import Theorems.Thm_BookProof_FermionFock_creVecF_apply
open BookProof.FermionFock




open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.FarisLavine BookProof.HermiteGalerkin BookProof.FriedrichsExtension
open BookProof.YangMillsFriedrichs
open BookProof.HashimotoShiftInvert
open BookProof.FockSecondQuantization (IsHermCol IsPosCol opCol isHermCol_opCol isPosCol_opCol)

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (col : ℕ → (ℕ →₀ ℂ)) (k : ℕ) :
    dGammaF col (Finsupp.single ({k} : FConf) 1)
      = ∑ j ∈ (col k).support, (col k) j • Finsupp.single ({j} : FConf) (1 : ℂ) := by

  classical
  have hsign : ∀ j : ℕ, fsign j (∅ : FConf) = 1 := by
    intro j; simp [fsign]
  have hsk : fsign k ({k} : FConf) = 1 := by
    simp [fsign, Finset.filter_singleton]
  have hann : annF k (Finsupp.single ({k} : FConf) (1 : ℂ))
      = Finsupp.single (∅ : FConf) (1 : ℂ) := by
    rw [annF_single, if_pos (Finset.mem_singleton_self k), one_smul,
      Finset.erase_singleton, hsk]
  rw [dGammaF_single, Finset.sum_singleton, hann, one_smul, creVecF_apply]
  refine Finset.sum_congr rfl fun j _ => ?_
  rw [creF_single, if_neg (Finset.notMem_empty j), one_smul, hsign]
  congr 1
