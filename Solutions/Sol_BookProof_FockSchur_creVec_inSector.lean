-- Generated from ChapterFockSchurEsa.lean — solution of BookProof.FockSchur.creVec_inSector
import Mathlib
import Definitions.Def_ChapterFockSchurEsa
import Theorems.Thm_BookProof_FockSchur_inSector_smul
import Theorems.Thm_BookProof_FockSchur_inSector_sum
import Theorems.Thm_BookProof_FockSchur_creA_inSector
import Theorems.Thm_BookProof_FockSecondQuantization_creVec_apply
open BookProof.FockSchur




open BookProof.FockSecondQuantization BookProof.CoreBounds
open BookProof.FarisLavine BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent
open BookProof.YangMillsFriedrichs

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution {n : ℕ} {u : FockAlg} (hu : InSector n u) (v : ℕ →₀ ℂ) :
    InSector (n + 1) (creVec v u) := by

  rw [creVec_apply]
  exact inSector_sum _ _ fun j _ => inSector_smul _ (creA_inSector hu j)
