-- Generated from ChapterNavierStokesMomentumEsa.lean — theorem BookProof.NavierStokesFlow.MomentumEsa.hasZeroDeficiencyOn_of_esa_core
import Mathlib
import Definitions.Def_ChapterNavierStokesMomentumEsa
import Definitions.Def_ChapterFarisLavineCore
import Definitions.Def_ChapterNavierStokesEsa
import Definitions.Def_ChapterNavierStokesFlow
import Definitions.Def_ChapterNavierStokesIkebeKato
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.MomentumEsa




open LpNat BookProof.FarisLavine IkebeKato FarisLavineLift DiagonalEsa

variable {ι : Type*}

theorem BookProof.NavierStokesFlow.MomentumEsa.hasZeroDeficiencyOn_of_esa_core {c : ι → ℝ} (H : maxDom c →ₗ[ℂ] L2I ι)
    (Hc : lpFiniteModes ι →ₗ[ℂ] lpFiniteModes ι)
    (hHc : ∀ x : lpFiniteModes ι, ((Hc x : lpFiniteModes ι) : L2I ι)
      = H (Submodule.inclusion (finiteModes_le_maxDom c) x))
    (hesa : EssentiallySelfAdjointOn (lpFiniteModes ι)
      (H.comp (Submodule.inclusion (finiteModes_le_maxDom c)))) :
    HasZeroDeficiencyOn (lpFiniteModes ι) Hc := by sorry
