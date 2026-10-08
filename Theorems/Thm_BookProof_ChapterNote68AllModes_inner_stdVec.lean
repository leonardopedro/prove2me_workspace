-- Generated from ChapterNote68AllModes.lean — theorem BookProof.ChapterNote68AllModes.inner_stdVec
import Definitions.Def_ChapterSphericalBessel
import Definitions.Def_ChapterBesselHarmonic
import Definitions.Def_ChapterSolidHarmonic
import Mathlib
import Definitions.Def_ChapterNote68AllModes
open BookProof.ChapterNote68AllModes



open Laplacian InnerProductSpace Polynomial
open BookProof.ChapterSphericalBessel BookProof.ChapterBesselHarmonic
open BookProof.ChapterSolidHarmonic
open scoped RealInnerProductSpace

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E] [FiniteDimensional ℝ E]


theorem BookProof.ChapterNote68AllModes.inner_stdVec {i j : Fin 3} (h : i ≠ j) : ⟪stdVec i, stdVec j⟫_ℝ = 0 := by sorry
