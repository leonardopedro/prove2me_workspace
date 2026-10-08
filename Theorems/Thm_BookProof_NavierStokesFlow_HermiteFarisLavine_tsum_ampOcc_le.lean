-- Generated from ChapterNavierStokesHermiteFarisLavine.lean — theorem BookProof.NavierStokesFlow.HermiteFarisLavine.tsum_ampOcc_le
import Mathlib
import Definitions.Def_ChapterNavierStokesHermiteFarisLavine
import Definitions.Def_ChapterFarisLavineCore
import Definitions.Def_ChapterNavierStokesIkebeKato
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.HermiteFarisLavine


open scoped ENNReal



open LpNat BookProof.FarisLavine IkebeKato

variable {κ : ℝ}
variable {x : maxDom (oscSymbol κ)}

theorem BookProof.NavierStokesFlow.HermiteFarisLavine.tsum_ampOcc_le (hκ : 0 ≤ κ) (x : maxDom (oscSymbol κ)) :
    (∑' n, amp κ n * ‖((x : L2I ℕ) : ℕ → ℂ) n‖ ^ 2)
      ≤ (1 / 4 + κ / 2) * quadForm (diagMax (oscSymbol κ)) x := by sorry
