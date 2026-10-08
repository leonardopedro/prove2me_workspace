-- Generated from ChapterNavierStokesHermiteFarisLavine.lean — theorem BookProof.NavierStokesFlow.HermiteFarisLavine.normSq_hFun_le
import Mathlib
import Definitions.Def_ChapterNavierStokesHermiteFarisLavine
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.HermiteFarisLavine


open scoped ENNReal



open LpNat BookProof.FarisLavine IkebeKato

variable {κ : ℝ}
variable {x : maxDom (oscSymbol κ)}

theorem BookProof.NavierStokesFlow.HermiteFarisLavine.normSq_hFun_le (hκ : 0 ≤ κ) (X : ℕ → ℂ) (m : ℕ) :
    ‖hFun κ X m‖ ^ 2
      ≤ 2 * shift2 (fun n => (ampSeq κ X n) ^ 2) m + 2 * (ampSeq κ X (m + 2)) ^ 2 := by sorry
