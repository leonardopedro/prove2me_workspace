-- Generated from ChapterNavierStokesHermiteFarisLavine.lean — theorem BookProof.NavierStokesFlow.HermiteFarisLavine.hasSum_commForm
import Mathlib
import Definitions.Def_ChapterNavierStokesHermiteFarisLavine
import Definitions.Def_ChapterFarisLavineCore
import Definitions.Def_ChapterNavierStokesIkebeKato
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.HermiteFarisLavine

variable {κ : ℝ}
variable {x : maxDom (oscSymbol κ)}


open scoped ENNReal



open LpNat BookProof.FarisLavine IkebeKato

theorem BookProof.NavierStokesFlow.HermiteFarisLavine.hasSum_commForm (hκ : 0 ≤ κ) (x : maxDom (oscSymbol κ)) :
    HasSum (fun n => 8 * κ * (amp κ n
        * ((starRingEnd ℂ) (((x : L2I ℕ) : ℕ → ℂ) n) * ((x : L2I ℕ) : ℕ → ℂ) (n + 2)).re))
      (commForm (nsH κ hκ) (diagMax (oscSymbol κ)) x) := by sorry
