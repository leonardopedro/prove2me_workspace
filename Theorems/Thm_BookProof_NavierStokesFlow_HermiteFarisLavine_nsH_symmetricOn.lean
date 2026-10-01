-- Generated from ChapterNavierStokesHermiteFarisLavine.lean — theorem BookProof.NavierStokesFlow.HermiteFarisLavine.nsH_symmetricOn
import Mathlib
import Definitions.Def_ChapterNavierStokesHermiteFarisLavine
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.HermiteFarisLavine

variable {κ : ℝ}
variable {x : maxDom (oscSymbol κ)}


open scoped ENNReal



open LpNat FarisLavine IkebeKato

theorem BookProof.NavierStokesFlow.HermiteFarisLavine.nsH_symmetricOn (hκ : 0 ≤ κ) : SymmetricOn (maxDom (oscSymbol κ)) (nsH κ hκ) := by sorry
