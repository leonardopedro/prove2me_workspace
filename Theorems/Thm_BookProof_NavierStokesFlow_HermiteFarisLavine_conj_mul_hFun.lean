-- Generated from ChapterNavierStokesHermiteFarisLavine.lean — theorem BookProof.NavierStokesFlow.HermiteFarisLavine.conj_mul_hFun
import Mathlib
import Definitions.Def_ChapterNavierStokesHermiteFarisLavine
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.HermiteFarisLavine


open scoped ENNReal



open LpNat BookProof.FarisLavine IkebeKato

variable {κ : ℝ}
variable {x : maxDom (oscSymbol κ)}

theorem BookProof.NavierStokesFlow.HermiteFarisLavine.conj_mul_hFun (κ : ℝ) (X Y : ℕ → ℂ) (m : ℕ) :
    (starRingEnd ℂ) (X m) * hFun κ Y m
      = -Complex.I * crossA κ X Y m + Complex.I * shift2 (crossB κ X Y) m := by sorry
