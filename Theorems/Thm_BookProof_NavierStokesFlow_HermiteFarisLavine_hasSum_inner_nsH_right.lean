-- Generated from ChapterNavierStokesHermiteFarisLavine.lean — theorem BookProof.NavierStokesFlow.HermiteFarisLavine.hasSum_inner_nsH_right
import Mathlib
import Definitions.Def_ChapterNavierStokesHermiteFarisLavine
import Definitions.Def_ChapterContinuityUnitaryInfinite
import Definitions.Def_ChapterNavierStokesIkebeKato
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
open BookProof.ChapterContinuityUnitaryInfinite
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.HermiteFarisLavine


open scoped ENNReal



open LpNat BookProof.FarisLavine IkebeKato

variable {κ : ℝ}
variable {x : maxDom (oscSymbol κ)}

theorem BookProof.NavierStokesFlow.HermiteFarisLavine.hasSum_inner_nsH_right (hκ : 0 ≤ κ) (x y : maxDom (oscSymbol κ)) :
    HasSum (fun n => -Complex.I * crossA κ ((x : L2I ℕ) : ℕ → ℂ) (((y : L2I ℕ) : ℕ → ℂ)) n
        + Complex.I * crossB κ ((x : L2I ℕ) : ℕ → ℂ) (((y : L2I ℕ) : ℕ → ℂ)) n)
      (inner ℂ (x : L2I ℕ) (nsH κ hκ y : L2I ℕ)) := by sorry
