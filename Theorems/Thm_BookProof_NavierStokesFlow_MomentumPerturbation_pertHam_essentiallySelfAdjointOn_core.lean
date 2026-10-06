-- Generated from ChapterNavierStokesMomentumPerturbation.lean — theorem BookProof.NavierStokesFlow.MomentumPerturbation.pertHam_essentiallySelfAdjointOn_core
import Mathlib
import Definitions.Def_ChapterNavierStokesMomentumPerturbation
import Definitions.Def_ChapterFarisLavineCore
import Definitions.Def_ChapterNavierStokesEsa
import Definitions.Def_ChapterNavierStokesIkebeKato
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.MomentumPerturbation

variable {ι : Type*}




open LpNat BookProof.FarisLavine IkebeKato


theorem BookProof.NavierStokesFlow.MomentumPerturbation.pertHam_essentiallySelfAdjointOn_core (c : ι → ℝ) (hc : ∀ k, 1 ≤ c k)
    (u w : maxDom c) :
    EssentiallySelfAdjointOn (lpFiniteModes ι)
      ((pertHam c (u : L2I ι) (w : L2I ι)).comp
        (Submodule.inclusion (finiteModes_le_maxDom c))) := by sorry
