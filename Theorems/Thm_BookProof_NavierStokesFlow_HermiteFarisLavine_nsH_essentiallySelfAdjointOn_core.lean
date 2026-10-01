-- Generated from ChapterNavierStokesHermiteFarisLavine.lean — theorem BookProof.NavierStokesFlow.HermiteFarisLavine.nsH_essentiallySelfAdjointOn_core
import Mathlib
import Definitions.Def_ChapterNavierStokesHermiteFarisLavine
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.HermiteFarisLavine

variable {κ : ℝ}
variable {x : maxDom (oscSymbol κ)}


open scoped ENNReal



open LpNat FarisLavine IkebeKato

theorem BookProof.NavierStokesFlow.HermiteFarisLavine.nsH_essentiallySelfAdjointOn_core (hκ : 0 ≤ κ) :
    EssentiallySelfAdjointOn (lpFiniteModes ℕ)
      ((nsH κ hκ).comp (Submodule.inclusion (finiteModes_le_maxDom (oscSymbol κ)))) := by sorry
