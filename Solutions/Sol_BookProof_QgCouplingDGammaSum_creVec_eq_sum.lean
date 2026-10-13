-- Generated from ChapterQgCouplingDGammaSum.lean — solution of BookProof.QgCouplingDGammaSum.creVec_eq_sum
import Mathlib
import Definitions.Def_ChapterQgCouplingDGammaSum
import Theorems.Thm_BookProof_FockSecondQuantization_creVec_apply
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Definitions.Def_ChapterNavierStokesIkebeKato
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterFriedrichsExtension
import Definitions.Def_ChapterYangMillsFriedrichs
import Definitions.Def_ChapterFockSecondQuantization
open BookProof.QgCouplingDGammaSum




open BookProof.FockSecondQuantization
open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.FarisLavine BookProof.FriedrichsExtension BookProof.YangMillsFriedrichs

noncomputable section

variable {ι : Type*}

variable {ι : Type*}

set_option maxHeartbeats 1000000 in
theorem solution {v : ℕ →₀ ℂ} {L : Finset ℕ} (hL : v.support ⊆ L) (x : FockAlg) :
    creVec v x = ∑ j ∈ L, v j • creA j x := by

  rw [creVec_apply]
  refine Finset.sum_subset hL fun j _ hj => ?_
  rw [Finsupp.notMem_support_iff.mp hj, zero_smul]
