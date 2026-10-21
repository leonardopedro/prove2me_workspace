-- Generated from ChapterCoreBoundsEsa.lean — solution of BookProof.CoreBounds.essentiallySelfAdjointOn_finiteModes_of_core_bounds
import Mathlib
import Definitions.Def_ChapterCoreBoundsEsa
import Theorems.Thm_BookProof_CoreBounds_coreExt_core
import Theorems.Thm_BookProof_CoreBounds_norm_coreExt_le
import Theorems.Thm_BookProof_CoreBounds_coreExt_symmetricOn
import Theorems.Thm_BookProof_CoreBounds_coreExt_commForm_le
import Theorems.Thm_BookProof_NavierStokesFlow_IkebeKato_finiteModes_le_maxDom
import Theorems.Thm_BookProof_OperatorSeries_essentiallySelfAdjointOn_finiteModes_of_bounds
open BookProof.CoreBounds




open BookProof.FarisLavine BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.OperatorSeries
open Filter Topology

noncomputable section

variable {ι : Type*} {c : ι → ℝ}

variable {ι : Type*} {c : ι → ℝ}
variable (H₀ : lpFiniteModes ι →ₗ[ℂ] L2I ι) (A : ℝ)

set_option maxHeartbeats 1000000 in
theorem solution
    (c : ι → ℝ) (hc : ∀ k, 0 ≤ c k) (H₀ : lpFiniteModes ι →ₗ[ℂ] L2I ι) (A B : ℝ) (hB : 0 ≤ B)
    (hsym : ∀ u v : lpFiniteModes ι,
      (inner ℂ (H₀ u) ((v : L2I ι)) : ℂ) = inner ℂ ((u : L2I ι)) (H₀ v))
    (hA : CoreRelBound c H₀ A)
    (hcomm : ∀ u : lpFiniteModes ι,
      |(-2 : ℝ) * (inner ℂ (H₀ u) ((diagMax c (inclC c u) : L2I ι)) : ℂ).im|
        ≤ B * (inner ℂ ((u : L2I ι)) ((diagMax c (inclC c u) : L2I ι)) : ℂ).re) :
    EssentiallySelfAdjointOn (lpFiniteModes ι) H₀ := by

  classical
  have hkey := essentiallySelfAdjointOn_finiteModes_of_bounds c hc (coreExt hA) A B hB
    (coreExt_symmetricOn hA hsym) (norm_coreExt_le hA) (coreExt_commForm_le hA hcomm)
  have hres : (coreExt hA).comp (Submodule.inclusion (finiteModes_le_maxDom c)) = H₀ :=
    LinearMap.ext fun u => coreExt_core hA u
  rwa [hres] at hkey
