-- Generated from ChapterFockSecondQuantization.lean — solution of BookProof.FockSecondQuantization.dGamma_single
import Mathlib
import Definitions.Def_ChapterFockSecondQuantization
import Theorems.Thm_BookProof_FockSecondQuantization_annA_single
open BookProof.FockSecondQuantization








open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.FarisLavine BookProof.YangMillsFriedrichs
open BookProof.HermiteGalerkin BookProof.FriedrichsExtension
open BookProof.HashimotoShiftInvert

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (col : ℕ → (ℕ →₀ ℂ)) (β : Conf) (c : ℂ) :
    dGamma col (Finsupp.single β c)
      = c • ∑ k ∈ β.support, creVec (col k) (annA k (Finsupp.single β 1)) := by

  simp [dGamma, LinearMap.toSpanSingleton]
