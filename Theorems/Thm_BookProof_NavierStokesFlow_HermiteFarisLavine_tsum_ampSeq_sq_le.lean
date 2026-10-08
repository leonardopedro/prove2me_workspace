-- Generated from ChapterNavierStokesHermiteFarisLavine.lean — theorem BookProof.NavierStokesFlow.HermiteFarisLavine.tsum_ampSeq_sq_le
import Mathlib
import Definitions.Def_ChapterNavierStokesHermiteFarisLavine
import Definitions.Def_ChapterNavierStokesIkebeKato
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.HermiteFarisLavine


open scoped ENNReal



open LpNat BookProof.FarisLavine IkebeKato

variable {κ : ℝ}
variable {x : maxDom (oscSymbol κ)}

theorem BookProof.NavierStokesFlow.HermiteFarisLavine.tsum_ampSeq_sq_le (hκ : 0 ≤ κ) (x : maxDom (oscSymbol κ)) :
    (∑' n, (ampSeq κ ((x : L2I ℕ) : ℕ → ℂ) n) ^ 2)
      ≤ (1 / 8) * ‖(diagMax (oscSymbol κ) x : L2I ℕ)‖ ^ 2 + (κ ^ 2 / 2) * ‖(x : L2I ℕ)‖ ^ 2 := by sorry
