-- Generated from ChapterNavierStokesMomentumPerturbation.lean — solution of BookProof.NavierStokesFlow.MomentumPerturbation.pertHam_essentiallySelfAdjointOn_core
import Mathlib
import Definitions.Def_ChapterNavierStokesMomentumPerturbation
import Theorems.Thm_BookProof_NavierStokesFlow_MomentumPerturbation_pertHam_symmetricOn
import Theorems.Thm_BookProof_NavierStokesFlow_MomentumPerturbation_pertHam_relative_bound
import Theorems.Thm_BookProof_NavierStokesFlow_MomentumPerturbation_pertHam_commForm_bound
import Theorems.Thm_BookProof_NavierStokesFlow_IkebeKato_essentiallySelfAdjointOn_finiteModes_of_farisLavine_bounds
import Theorems.Thm_BookProof_NavierStokesFlow_IkebeKato_finiteModes_le_maxDom
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.MomentumPerturbation





open LpNat BookProof.FarisLavine IkebeKato

variable {ι : Type*}

variable {ι : Type*}

set_option maxHeartbeats 1000000 in
theorem solution (c : ι → ℝ) (hc : ∀ k, 1 ≤ c k)
    (u w : maxDom c) :
    EssentiallySelfAdjointOn (lpFiniteModes ι)
      ((pertHam c (u : L2I ι) (w : L2I ι)).comp
        (Submodule.inclusion (finiteModes_le_maxDom c))) := by

  refine essentiallySelfAdjointOn_finiteModes_of_farisLavine_bounds c
    (fun k => le_trans zero_le_one (hc k)) (pertHam c (u : L2I ι) (w : L2I ι))
    2 (2 * (2 * (‖(u : L2I ι)‖ * ‖(w : L2I ι)‖)) ^ 2)
    (2 * (‖(u : L2I ι)‖ * ‖diagMax c w‖ + ‖(w : L2I ι)‖ * ‖diagMax c u‖))
    (pertHam_symmetricOn c _ _) (by positivity)
    (pertHam_relative_bound c _ _) (pertHam_commForm_bound c hc u w)
