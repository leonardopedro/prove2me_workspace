-- Generated from ChapterNavierStokesMomentumEsa.lean — solution of BookProof.NavierStokesFlow.MomentumEsa.hasZeroDeficiencyOn_of_esa_core
import Mathlib
import Definitions.Def_ChapterNavierStokesMomentumEsa
import Theorems.Thm_BookProof_FarisLavine_essentiallySelfAdjointOn_iff_hasZeroDeficiencyOn
import Theorems.Thm_BookProof_NavierStokesFlow_IkebeKato_finiteModes_le_maxDom
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.MomentumEsa





open LpNat BookProof.FarisLavine IkebeKato FarisLavineLift DiagonalEsa

variable {ι : Type*}

set_option maxHeartbeats 1000000 in
theorem solution {c : ι → ℝ} (H : maxDom c →ₗ[ℂ] L2I ι)
    (Hc : lpFiniteModes ι →ₗ[ℂ] lpFiniteModes ι)
    (hHc : ∀ x : lpFiniteModes ι, ((Hc x : lpFiniteModes ι) : L2I ι)
      = H (Submodule.inclusion (finiteModes_le_maxDom c) x))
    (hesa : EssentiallySelfAdjointOn (lpFiniteModes ι)
      (H.comp (Submodule.inclusion (finiteModes_le_maxDom c)))) :
    HasZeroDeficiencyOn (lpFiniteModes ι) Hc := by

  refine (essentiallySelfAdjointOn_iff_hasZeroDeficiencyOn (lpFiniteModes ι) Hc).1 ?_
  have hEq : (lpFiniteModes ι).subtype.comp Hc
      = H.comp (Submodule.inclusion (finiteModes_le_maxDom c)) :=
    LinearMap.ext fun x => hHc x
  rw [hEq]
  exact hesa
