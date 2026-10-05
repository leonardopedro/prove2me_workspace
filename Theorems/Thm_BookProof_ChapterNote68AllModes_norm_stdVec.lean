-- Generated from ChapterNote68AllModes.lean — theorem BookProof.ChapterNote68AllModes.norm_stdVec
import Definitions.Def_ChapterSphericalBessel
import Definitions.Def_ChapterBesselHarmonic
import Definitions.Def_ChapterSolidHarmonic
import Mathlib
import Definitions.Def_ChapterNote68AllModes
open BookProof.ChapterNote68AllModes

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E] [FiniteDimensional ℝ E]



open Laplacian InnerProductSpace Polynomial
open BookProof.ChapterSphericalBessel BookProof.ChapterBesselHarmonic
open BookProof.ChapterSolidHarmonic
open scoped RealInnerProductSpace


theorem BookProof.ChapterNote68AllModes.norm_stdVec (i : Fin 3) : ‖stdVec i‖ = 1 := by sorry
