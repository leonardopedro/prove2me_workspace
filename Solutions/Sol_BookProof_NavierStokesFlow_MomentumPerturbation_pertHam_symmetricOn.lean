-- Generated from ChapterNavierStokesMomentumPerturbation.lean — solution of BookProof.NavierStokesFlow.MomentumPerturbation.pertHam_symmetricOn
import Mathlib
import Definitions.Def_ChapterNavierStokesMomentumPerturbation
import Theorems.Thm_BookProof_NavierStokesFlow_MomentumPerturbation_rankTwo_symmetric
import Theorems.Thm_BookProof_NavierStokesFlow_IkebeKato_diagMax_symmetricOn
import Definitions.Def_ChapterFarisLavineCore
import Definitions.Def_ChapterNavierStokesIkebeKato
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.MomentumPerturbation





open LpNat BookProof.FarisLavine IkebeKato

variable {ι : Type*}

variable {ι : Type*}


@[simp] private theorem pertHam_apply (c : ι → ℝ) (u w : L2I ι) (x : maxDom c) :
    pertHam c u w x = diagMax c x + rankTwo u w (x : L2I ι) := rfl

set_option maxHeartbeats 1000000 in
theorem solution (c : ι → ℝ) (u w : L2I ι) :
    SymmetricOn (maxDom c) (pertHam c u w) := by

  intro x y
  simp only [pertHam_apply, inner_add_left, inner_add_right]
  rw [diagMax_symmetricOn c x y, rankTwo_symmetric u w (x : L2I ι) (y : L2I ι)]
